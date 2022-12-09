import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:karaz_driver/Services/AuthenticationService/Core/manager.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';
import 'package:karaz_driver/globalvariabels.dart';
import 'package:karaz_driver/helpers/helpermethods.dart';
import 'package:karaz_driver/screens/LogIn/login_binding.dart';
import 'package:karaz_driver/screens/LogIn/loginpage.dart';
import 'package:karaz_driver/screens/mainPage/mainpage.dart';
import 'package:karaz_driver/tabs/homeTab/homeTabController.dart';

class SplashController extends GetxController {
  AuthenticationManager authManager = Get.find();

  @override
  void onInit() async {
    HelperMethods.getCurrentUserInfo();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
      authManager.commonTools.showFailedSnackBar('No internet connectivity');
    }
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    if (await Permission.location.isDenied) {
      Geolocator.requestPermission();
    }
    currentPosition = await getCurrentPosition();
    if (currentPosition != null) {
      Get.lazyPut<HomeTabController>(() => HomeTabController());
      Get.offAll(
        () => const MainPage(),
      );
    }
    super.onReady();
  }

  Future<Position> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    return position;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.to(() => const LoginPage(), binding: LogInBinding());
  }

  Scaffold waitingView() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: SvgPicture.asset(
          'images/karaz_logo.svg',
          width: Get.width * 0.4,
          height: Get.width * 0.4,
        ),
      ),
    );
  }
}
