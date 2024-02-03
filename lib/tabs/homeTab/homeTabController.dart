import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karaz_driver/theme/app_colors.dart';
import 'package:karaz_driver/globalvariabels.dart';
import 'package:karaz_driver/helpers/helpermethods.dart';
import 'package:karaz_driver/helpers/pushnotificationservice.dart';
import 'package:karaz_driver/widgets/ConfirmSheet.dart';

class HomeTabController extends GetxController {
  GoogleMapController? mapController;
  final Completer<GoogleMapController> completer = Completer();
  RxBool isAvailable = false.obs;
  var geoLocator = Geolocator();
  RxString availabilityTitle = 'Go Online'.tr.obs;

  Rx<Color> availabilityColor = AppColors.primary.obs;
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
        availabilityColor.value = AppColors.primary;
        availabilityTitle.value = 'Go Online'.tr;
      } else {
        availabilityColor.value = AppColors.red;
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

  void enableLocation() {
    showModalBottomSheet(
      isDismissible: false,
      context: Get.context!,
      builder: (context) => ConfirmSheet(
        title:
            (!isAvailable.value) ? 'Go Online'.tr : 'Go Offline'.tr,
        subtitle: (!isAvailable.value)
            ? 'You are about to become available to receive trip requests'.tr
            : 'you will stop receiving new trip requests'.tr,
        onPressed: () {
          if (!isAvailable.value) {
            goOnline();
            getLocationUpdates();
            availabilityColor.value = AppColors.red;
            availabilityTitle.value = 'Go Offline'.tr;
            isAvailable.value = true;
            driversIsAvailableRef.set(isAvailable.value);
            Get.back();
          } else {
            goOffline();
            Get.back();
            availabilityColor.value = AppColors.primary;
            availabilityTitle.value = 'Go Online'.tr;
            isAvailable.value = false;

            driversIsAvailableRef.set(isAvailable.value);
          }
        },
      ),
    );
  }
}
