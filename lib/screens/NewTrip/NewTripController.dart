import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karaz_driver/Services/AuthenticationService/Core/manager.dart';
import 'package:karaz_driver/Utilities/general.dart';
import 'package:karaz_driver/theme/app_colors.dart';
import 'package:karaz_driver/globalvariabels.dart';
import 'package:karaz_driver/helpers/helpermethods.dart';
import 'package:karaz_driver/helpers/mapkithelper.dart';
import 'package:karaz_driver/widgets/CollectPaymentDialog.dart';
import 'package:karaz_driver/widgets/ProgressDialog.dart';

class NewTripController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  GoogleMapController? rideMapController;
  final Completer<GoogleMapController> googleMapController = Completer();
  double mapPaddingBottom = 0;
  var tripDetails = Get.arguments;
  final Set<Marker> markers = <Marker>{};
  final Set<Circle> circles = <Circle>{};
  final Set<Polyline> polyLines = <Polyline>{};

  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  Geolocator geoLocator = Geolocator();

  BitmapDescriptor? movingMarkerIcon;

  Position? myPosition;

  RxString status = 'accepted'.obs;

  RxString durationString = ''.obs;

  RxBool isRequestingDirection = false.obs;

  RxString buttonTitle = 'ARRIVED'.obs;

  Rx<Color> buttonColor = AppColors.success.obs;

  Timer? timer;

  int durationCounter = 0;

  @override
  void onInit() {
    acceptTrip();
    createMarker();
    super.onInit();
  }

  void createMarker() {
    if (movingMarkerIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(Get.context!, size: const Size(2, 2));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration,
              (Platform.isIOS)
                  ? 'images/car_ios.png'
                  : 'images/car_android.png')
          .then((icon) {
        movingMarkerIcon = icon;
      });
    }
  }

  void acceptTrip() {
    String rideID = tripDetails.rideID!;
    rideRef = FirebaseDatabase.instance.ref().child('rideRequest/$rideID');

    rideRef!.child('status').set('accepted');
    rideRef!.child('driver_name').set(currentDriverInfo.value.fullname);
    rideRef!
        .child('car_details')
        .set('${currentDriverInfo.value.carColor} - ${currentDriverInfo.value.carType}');
    rideRef!.child('driver_phone').set(currentDriverInfo.value.phone);
    rideRef!.child('driver_id').set(currentDriverInfo.value.id);

    Map locationMap = {
      'latitude': currentPosition!.latitude.toString(),
      'longitude': currentPosition!.longitude.toString(),
    };

    rideRef!.child('driver_location').set(locationMap);

    DatabaseReference historyRef = FirebaseDatabase.instance
        .ref()
        .child('drivers/${currentFirebaseUser!.uid}/history/$rideID');
    historyRef.set(true);
  }

  void getLocationUpdates() {
    LatLng oldPosition = const LatLng(0, 0);

    ridePositionStream = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.bestForNavigation,
                distanceFilter: 4))
        .listen((Position position) {
      myPosition = position;
      currentPosition = position;
      LatLng pos = LatLng(position.latitude, position.longitude);

      var rotation = MapKitHelper.getMarkerRotation(oldPosition.latitude,
          oldPosition.longitude, pos.latitude, pos.longitude);
      Marker movingMaker = Marker(
          markerId: const MarkerId('moving'),
          position: pos,
          icon: movingMarkerIcon!,
          rotation: rotation,
          infoWindow: const InfoWindow(title: 'Current Location'));

      CameraPosition cp = CameraPosition(target: pos, zoom: 17);
      rideMapController!.animateCamera(CameraUpdate.newCameraPosition(cp));

      markers.removeWhere((marker) => marker.markerId.value == 'moving');
      markers.add(movingMaker);

      oldPosition = pos;

      updateTripDetails();

      Map locationMap = {
        'latitude': myPosition!.latitude.toString(),
        'longitude': myPosition!.longitude.toString(),
      };
      rideRef!.child('driver_location').set(locationMap);
    });
  }

  void updateTripDetails() async {
    if (!isRequestingDirection.value) {
      isRequestingDirection.value = true;

      if (myPosition == null) {
        return;
      }

      var positionLatLng = LatLng(myPosition!.latitude, myPosition!.longitude);
      LatLng destinationLatLng;

      if (status.value == 'accepted') {
        destinationLatLng = tripDetails.location!;
      } else {
        destinationLatLng = tripDetails.destination!;
      }

      var directionDetails = await HelperMethods.getDirectionDetails(
          positionLatLng, destinationLatLng);

      durationString.value = directionDetails.durationText!;

      isRequestingDirection.value = false;
    }
  }

  Future<void> getDirection(
      LatLng pickupLatLng, LatLng destinationLatLng) async {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) => ProgressDialog(
              status: 'Please wait...',
            ));

    var thisDetails = await HelperMethods.getDirectionDetails(
        pickupLatLng, destinationLatLng);

    Get.back();

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> results =
        polylinePoints.decodePolyline(thisDetails.encodedPoints!);

    polylineCoordinates.clear();
    if (results.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      for (var point in results) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    polyLines.clear();

    Polyline polyline = Polyline(
      polylineId: const PolylineId('polyid'),
      color: const Color.fromARGB(255, 95, 109, 237),
      points: polylineCoordinates,
      jointType: JointType.round,
      width: 4,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
    );
    polyLines.add(polyline);

    // make polyline to fit into the map

    LatLngBounds bounds;

    if (pickupLatLng.latitude > destinationLatLng.latitude &&
        pickupLatLng.longitude > destinationLatLng.longitude) {
      bounds =
          LatLngBounds(southwest: destinationLatLng, northeast: pickupLatLng);
    } else if (pickupLatLng.longitude > destinationLatLng.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(pickupLatLng.latitude, destinationLatLng.longitude),
          northeast:
              LatLng(destinationLatLng.latitude, pickupLatLng.longitude));
    } else if (pickupLatLng.latitude > destinationLatLng.latitude) {
      bounds = LatLngBounds(
        southwest: LatLng(destinationLatLng.latitude, pickupLatLng.longitude),
        northeast: LatLng(pickupLatLng.latitude, destinationLatLng.longitude),
      );
    } else {
      bounds =
          LatLngBounds(southwest: pickupLatLng, northeast: destinationLatLng);
    }

    rideMapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));

    Marker pickupMarker = Marker(
      markerId: const MarkerId('pickup'),
      position: pickupLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );

    Marker destinationMarker = Marker(
      markerId: const MarkerId('destination'),
      position: destinationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    markers.add(pickupMarker);
    markers.add(destinationMarker);

    Circle pickupCircle = Circle(
      circleId: const CircleId('pickup'),
      strokeColor: Colors.green,
      strokeWidth: 3,
      radius: 12,
      center: pickupLatLng,
      fillColor: AppColors.success,
    );

    Circle destinationCircle = Circle(
      circleId: const CircleId('destination'),
      strokeColor: AppColors.primary,
      strokeWidth: 3,
      radius: 12,
      center: destinationLatLng,
      fillColor: AppColors.primary,
    );

    circles.add(pickupCircle);
    circles.add(destinationCircle);
  }

  void startTimer() {
    const interval = Duration(seconds: 1);
    timer = Timer.periodic(interval, (timer) {
      durationCounter++;
    });
  }

  void endTrip() async {
    timer!.cancel();

    HelperMethods.showProgressDialog(Get.context);

    var currentLatLng = LatLng(myPosition!.latitude, myPosition!.longitude);

    var directionDetails = await HelperMethods.getDirectionDetails(
        tripDetails.location!, currentLatLng);

    Get.back();

    int fares = HelperMethods.estimateFares(directionDetails, durationCounter);

    rideRef!.child('fares').set(fares.toString());

    rideRef!.child('status').set('ended');

    ridePositionStream!.cancel();

    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) => CollectPayment(
        paymentMethod: tripDetails.paymentMethod,
        fares: fares,
      ),
    );

    topUpEarnings(fares);
  }

  void topUpEarnings(int fares) {
    DatabaseReference earningsRef = FirebaseDatabase.instance
        .ref()
        .child('drivers/${currentFirebaseUser!.uid}/earnings');
    earningsRef.once().then((snapshot) {
      if (snapshot.snapshot.value != null) {
        double oldEarnings = double.parse(snapshot.snapshot.value.toString());

        double adjustedEarnings = (fares.toDouble() * 0.85) + oldEarnings;

        earningsRef.set(adjustedEarnings.toStringAsFixed(2));
      } else {
        double adjustedEarnings = (fares.toDouble() * 0.85);
        earningsRef.set(adjustedEarnings.toStringAsFixed(2));
      }
    });
  }
}
