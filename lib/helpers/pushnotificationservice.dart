import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karaz_driver/datamodels/tripdetails.dart';
import 'package:karaz_driver/widgets/NotificationDialog.dart';
import 'package:karaz_driver/globalvariabels.dart';
import 'package:karaz_driver/widgets/ProgressDialog.dart';

class PushNotificationService {
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  int num = 0;

  // ignore: missing_return
  Future<String?> getToken() async {
    String? token = await fcm.getToken();
    // print('token: $token');

    DatabaseReference tokenRef = FirebaseDatabase.instance
        .ref()
        .child('drivers/${currentFirebaseUser!.uid}/token');
    tokenRef.set(token);

    fcm.subscribeToTopic('alldrivers');
    fcm.subscribeToTopic('allusers');
    return token;
  }

  String getRideID(RemoteMessage message) {
    String rideID = '';
    rideID = message.data['ride_id'];
    print('rideID $rideID');
    return rideID;
  }

  void fetchRideInfo(String rideID) {
    print(rideID);
    num++;
    //print(num);
    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Fetching details',
      ),
    );
    DatabaseReference rideRef =
        FirebaseDatabase.instance.ref().child('rideRequest/$rideID');
    rideRef.once().then(
      (snapshot) {
        Get.back();
        print(snapshot.snapshot.value);
        dynamic data = snapshot.snapshot.value;
        if (snapshot.snapshot.value != null) {
          print('mhsafbdjhasbdjb');
          double pickupLat =
              double.parse(data['location']['latitude'].toString());
          double pickupLng =
              double.parse(data['location']['longitude'].toString());
          String pickupAddress = data['pickup_address'].toString();
          double destinationLat =
              double.parse(data['destination']['latitude'].toString());
          double destinationLng =
              double.parse(data['destination']['longitude'].toString());
          String destinationAddress = data['destination_address'];
          String paymentMethod = data['payment_method'];
          String riderName = data['rider_name'];
          String riderPhone = data['rider_phone'];
          TripDetails tripDetails = TripDetails();
          tripDetails.rideID = rideID;
          tripDetails.pickupAddress = pickupAddress;
          tripDetails.destinationAddress = destinationAddress;
          tripDetails.location = LatLng(pickupLat, pickupLng);
          tripDetails.destination = LatLng(destinationLat, destinationLng);
          tripDetails.paymentMethod = paymentMethod;
          tripDetails.riderName = riderName;
          tripDetails.riderPhone = riderPhone;

          showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (BuildContext context) => NotificationDialog(
              tripDetails: tripDetails,
            ),
          );
        }
      },
    );
  }
}
