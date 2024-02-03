import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karaz_driver/Utilities/general.dart';
import 'package:karaz_driver/screens/UnRegistration.dart';
import 'package:karaz_driver/screens/mainPage/mainpage.dart';

User? currentFirebaseUser;

const CameraPosition googlePlex = CameraPosition(
  target: LatLng(31.954066, 35.931066),
  zoom: 14.4746,
);
String mapKey = 'AIzaSyALY906rdwqFYGffSyDo-j3OOAPdGUoscA';

StreamSubscription<Position>? homeTabPositionStream;

StreamSubscription<Position>? ridePositionStream;

String? driverCarStyle;

Position? currentPosition;

DatabaseReference? rideRef;

StreamSubscription<Position>? positionStream;

DatabaseReference driversIsAvailableRef = FirebaseDatabase.instance
    .ref()
    .child('drivers/${currentFirebaseUser!.uid}/driversIsAvailable');

void getCurrentDriverInfo(context) async {
  // ignore: await_only_futures
  currentFirebaseUser = FirebaseAuth.instance.currentUser!;
  DatabaseReference driverRef = FirebaseDatabase.instance
      .ref()
      .child('drivers/${currentFirebaseUser!.uid}');
  driverRef.once().then((snapshot) {
    if (snapshot.snapshot.value != null) {
      //currentDriverInfo = Driver.fromSnapshot(snapshot);
      if (currentDriverInfo.value.approveDriver == false) {
        Navigator.pushNamedAndRemoveUntil(
            context, UnRegistration.id, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, MainPage.id, (route) => false);
      }
    }
  });
}

DatabaseReference tripRequestRef = FirebaseDatabase.instance
    .ref()
    .child('drivers/${currentFirebaseUser!.uid}/newtrip');
DatabaseReference tripStatusID = FirebaseDatabase.instance
    .ref()
    .child('drivers/${currentFirebaseUser!.uid}/tripStatusID');
DatabaseReference driversAvailable = FirebaseDatabase.instance
    .ref()
    .child('driversAvailable/${currentFirebaseUser!.uid}');

Future<void> goOnline() async {
  positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.bestForNavigation,
  )).listen((Position position) {
    currentPosition = position;
    tripStatusID.set('on');
    Map<String, Object> location = {
      'tripID': 'waiting',
      'location': {'lat': position.latitude, 'long': position.longitude}
    };
    driversAvailable.set(location);
  });
  tripRequestRef.set('waiting');
  // tripRequestRef.onValue.listen((event) {
  //   print(event.snapshot.value);
  // });
}

void goOffline() {
  if (tripRequestRef.path.isNotEmpty) {
    tripRequestRef.onDisconnect();
  }
  tripStatusID.set('off');
  driversAvailable.remove();
  //positionStream!.cancel();
  tripRequestRef.remove();
}


