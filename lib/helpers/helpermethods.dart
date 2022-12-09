import 'dart:developer' as dev;
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:karaz_driver/datamodels/directiondetails.dart';
import 'package:karaz_driver/datamodels/driver.dart';
import 'package:provider/provider.dart';
import 'package:karaz_driver/helpers/requesthelper.dart';
import 'package:karaz_driver/widgets/ProgressDialog.dart';

import '../dataprovider.dart';
import '../globalvariabels.dart';

class HelperMethods {
  static void getCurrentUserInfo() async {
    currentFirebaseUser = FirebaseAuth.instance.currentUser;
    String userid = currentFirebaseUser!.uid;
    DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child('drivers/$userid');
    userRef.once().then((snapshot) {
      if (snapshot.snapshot.value != null) {
        dynamic data = snapshot.snapshot.value;
        //dev.log(snapshot.snapshot.value.toString());
        Amount amount = Amount(
            amount: data['amount']['amount'],
            currentAmount: data['amount']['currentAmount'],
            status: data['amount']['status'],
            transNumber: data['amount']['transNumber']);
        Driver driver = Driver(
          amount: amount,
          approveDriver: data['approveDriver'],
          carColor: data['carColor'],
          carFactory: data['carFactory'],
          carNumber: data['carNumber'],
          carType: data['carType'],
          driverCarBackImageUrl: data['driverCarBackImageUrl'],
          driverCarFrontImageUrl: data['driverCarFrontImageUrl'],
          driverCarLicenseImageUrl: data['driverCarLicenseImageUrl'],
          driverLicenseImageUrl: data['driverLicenseImageUrl'],
          driversIsAvailable: data['driversIsAvailable'],
          email: data['email'],
          fullname: data['fullname'],
          id: userid,
          personalImageUrl: data['personalImageUrl'],
          phone: data['phone'],
          socialAgentNumber: data['socialAgentNumber'],
          token: data['token'],
          tripStatusID: data['tripStatusID'],
          raiting: data['raiting'],
        );
        currentDriverInfo = driver;
        //dev.log(currentDriverInfo!.raiting.toString());
      }
      var values = [
        {'userId': 1, 'rating': 4.5},
        {'userId': 2, 'rating': 4.0},
        {'userId': 3, 'rating': 3.5},
        {'userId': 4, 'rating': 3.0}
      ];

      var result = values.map((m) => m['rating']).reduce((a, b) => a! + b!)! /
          values.length;
      dev.log(result.toString());
    });
  }

  static Future<DirectionDetails> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=$mapKey';
    var response = await RequestHelper.getRequest(url);
    if (response == 'failed') {
      return response;
    }
    DirectionDetails directionDetails = DirectionDetails();
    directionDetails.durationText =
        response['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durationValue =
        response['routes'][0]['legs'][0]['duration']['value'];
    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['distance']['value'];
    directionDetails.encodedPoints =
        response['routes'][0]['overview_polyline']['points'];
    return directionDetails;
  }

  static int estimateFares(DirectionDetails details, int durationValue) {
    // per km = $0.3,
    // per minute = $0.2,
    // base fare = $3,
    //TODO
    double baseFare = 0.6;
    double distanceFare = (details.distanceValue! / 1000) * 0.21;
    double timeFare = (durationValue / 60);
    double totalFare = baseFare + distanceFare + timeFare;
    return totalFare.truncate();
  }

  static double generateRandomNumber(int max) {
    var randomGenerator = Random();
    int randInt = randomGenerator.nextInt(max);

    return randInt.toDouble();
  }

  static void showProgressDialog(context) {
    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Please wait',
      ),
    );
  }

  static void getHistoryInfo() {
    DatabaseReference earningRef = FirebaseDatabase.instance
        .ref()
        .child('drivers/${currentFirebaseUser!.uid}/earnings');

    earningRef.once().then((snapshot) {
      if (snapshot.snapshot.value != null) {
        String earnings = snapshot.snapshot.value.toString();
        Provider.of<AppData>(Get.context!, listen: false).updateEarnings(earnings);
      }
    });

    DatabaseReference historyRef = FirebaseDatabase.instance
        .ref()
        .child('drivers/${currentFirebaseUser!.uid}/history');
    historyRef.once().then((snapshot) {
      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic> values =
            snapshot.snapshot.value as Map<dynamic, dynamic>;
        int tripCount = values.length;

        // update trip count to data provider
        Provider.of<AppData>(Get.context!, listen: false).updateTripCount(tripCount);

        List<String> tripHistoryKeys = [];
        values.forEach((key, value) {
          tripHistoryKeys.add(key);
        });

        // update trip keys to data provider
        Provider.of<AppData>(Get.context!, listen: false)
            .updateTripKeys(tripHistoryKeys);

        getHistoryData(Get.context!);
      }
    });
  }

  static void getHistoryData(context) {
    var keys = Provider.of<AppData>(context, listen: false).tripHistoryKeys;

    for (String key in keys) {
      DatabaseReference historyRef =
          FirebaseDatabase.instance.ref().child('rideRequest/$key');

      historyRef.once().then((snapshot) {
        if (snapshot.snapshot.value != null) {
          var history = snapshot.snapshot.value;
          print(history);
          // Provider.of<AppData>(context, listen: false)
          //     .updateTripHistory(history);

          //print(history.destination);
        }
      });
    }
  }

  static String formatMyDate(String datestring) {
    DateTime thisDate = DateTime.parse(datestring);
    String formattedDate =
        '${DateFormat.MMMd().format(thisDate)}, ${DateFormat.y().format(thisDate)} - ${DateFormat.jm().format(thisDate)}';

    return formattedDate;
  }
}
