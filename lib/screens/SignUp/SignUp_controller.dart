// ignore_for_file: file_names

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:karaz_driver/Services/AuthenticationService/Core/manager.dart';
import 'package:karaz_driver/screens/splash/splash_binding.dart';
import 'package:karaz_driver/screens/splash/splash_view.dart';

class SignUpController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Rx<TextEditingController> fullNameController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  AuthenticationManager authManager = Get.find();
  final GlobalKey<FormState> registrationKey = GlobalKey<FormState>();

  Rx<File> personalImageFile = File('').obs;
  Rx<File> driverLicenseImage = File('').obs;
  Rx<File> driverCarFrontImage = File('').obs;
  Rx<File> driverCarBackImage = File('').obs;
  Rx<File> driverCarLicenseImage = File('').obs;
  List<File> listFiles = [];

  RxBool showPassword = true.obs;
  RxBool eightCharacter = false.obs,
      characterCase = false.obs,
      numberOfDigit = false.obs;

  Future<void> registerUser() async {
    authManager.commonTools.showLoading();
    try {
      final UserCredential drivers =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );

      Get.back();
      if (drivers.user != null) {
        DatabaseReference newUserRef = FirebaseDatabase.instance
            .ref()
            .child('drivers/${drivers.user!.uid}');
        Map userMap = {
          'fullname': fullNameController.value.text,
          'email': emailController.value.text,
          'phone': phoneController.value.text,
        };
        newUserRef.set(userMap);
        Get.to(() => const SplashView(), binding: SplashBinding());
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      authManager.commonTools.showFailedSnackBar(e.code);
    }
  }

  Future<void> selectFile(int index) async {
    List<Asset> profilePic1 = <Asset>[].obs;
    await MultiImagePicker.pickImages(
      maxImages: 1,
      enableCamera: true,
      selectedAssets: profilePic1,
      cupertinoOptions: const CupertinoOptions(
        takePhotoIcon: 'chat',
      ),
      materialOptions: const MaterialOptions(
        actionBarColor: '#339A58',
        statusBarColor: '#339A58',
        allViewTitle: 'All Photos',
        useDetailsView: false,
        selectCircleStrokeColor: '#339A58',
      ),
    ).then((value) async {
      var bytes = await value[0].getByteData();
      String dir = (await getApplicationDocumentsDirectory()).path;
      await authManager.commonTools
          .writeToFile(bytes, '$dir/${value[0].name}.jpg');
      File tempFile = File('$dir/${value[0].name}.jpg');
      if (index == 6) {
        personalImageFile.value = tempFile;

        listFiles.add(personalImageFile.value);
      } else if (index == 2) {
        {
          driverLicenseImage.value = tempFile;

          listFiles.add(driverLicenseImage.value);
        }
      } else if (index == 3) {
        {
          driverCarFrontImage.value = tempFile;

          listFiles.add(driverCarFrontImage.value);
        }
      } else if (index == 4) {
        {
          driverCarBackImage.value = tempFile;

          listFiles.add(driverCarBackImage.value);
        }
      } else if (index == 5) {
        {
          driverCarLicenseImage.value = tempFile;

          listFiles.add(driverCarLicenseImage.value);
        }
      }
    });
  }
}
