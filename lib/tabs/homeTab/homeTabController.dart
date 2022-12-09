import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';
import 'package:karaz_driver/globalvariabels.dart';
import 'package:karaz_driver/helpers/helpermethods.dart';
import 'package:karaz_driver/helpers/pushnotificationservice.dart';

class HomeTabController extends GetxController {
  GoogleMapController? mapController;
  final Completer<GoogleMapController> completer = Completer();
  RxBool isAvailable = false.obs;
  var geoLocator = Geolocator();
  RxString availabilityTitle = 'Go Online'.tr.obs;

  Rx<Color> availabilityColor = AppColors.colorAccent1.obs;
  void notificationData() {
    PushNotificationService pushNotificationService = PushNotificationService();

    pushNotificationService.getToken();
    HelperMethods.getHistoryInfo();
  }

  void getLocationUpdates() {
    Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
    )).listen((Position position) {
      currentPosition = position;
      LatLng pos = LatLng(position.latitude, position.longitude);
      mapController!.animateCamera(CameraUpdate.newLatLng(pos));
    });
  }

  @override
  void onInit() async {
    tripStatusID.once().then((value) {
      log(value.snapshot.value.toString());
      if (value.snapshot.value.toString() == 'off') {
        availabilityColor.value = AppColors.colorAccent1;
        availabilityTitle.value = 'Go Online'.tr;
      } else {
        availabilityColor.value = AppColors.colorRed1;
        availabilityTitle.value = 'Go Offline'.tr;
      }
    });
    notificationData();
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          String rideID = message.data['ride_id'];
          PushNotificationService().fetchRideInfo(rideID);
        }
      },
    );
    super.onInit();
  }
}
