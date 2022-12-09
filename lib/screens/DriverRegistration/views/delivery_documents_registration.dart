import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/Services/translation_service.dart';
import 'package:karaz_driver/screens/DriverRegistration/controllers/delivery_registration_controller.dart';
import 'package:karaz_driver/screens/DriverRegistration/widgets/documents/car_front_image.dart';
import 'package:karaz_driver/screens/DriverRegistration/widgets/documents/car_license_copy.dart';
import 'package:karaz_driver/screens/DriverRegistration/widgets/documents/car_rear_image.dart';
import 'package:karaz_driver/screens/DriverRegistration/widgets/documents/driving_license_copy.dart';
import 'package:karaz_driver/screens/splash/splash_binding.dart';
import 'package:karaz_driver/screens/splash/splash_view.dart';
import 'package:karaz_driver/widgets/myButton_widget.dart';

import '../widgets/documents/personal_image_doc.dart';

class DeliveryDocumentsRegistration extends GetView<RegistrationController> {
  final GlobalKey<FormState> documentsForm = GlobalKey<FormState>();

  DeliveryDocumentsRegistration({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: documentsForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Documents'.tr,
              style: Get.textTheme.headline6!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
          Text('${'Personal image'.tr}*',
              style: Get.textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )).paddingOnly(top: 25),
          const PersonalImageDoc(),
          Text(
            '(Must have a white background &without any filter)'.tr,
            style: Get.textTheme.headline6!.copyWith(
              height: 1.5,
              color: Get.theme.focusColor,
            ),
          ).paddingOnly(top: 12),
          Text('${'acopyofthedrivinglicense'.tr}*',
                  style: Get.textTheme.headline6!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold))
              .paddingOnly(top: 25),
          const DrivingLicenseCopy(),
          Text('${'clearfrontimageforthevehicle'.tr}*',
                  style: Get.textTheme.headline6!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold))
              .paddingOnly(top: 25),
          const CarFrontImage(),
          Text('${'clearrearimageforthevehicle'.tr}*',
                  style: Get.textTheme.headline6!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold))
              .paddingOnly(top: 25),
          const CarRearImage(),
          Text('${'acopyofthecarlicense'.tr}*',
                  style: Get.textTheme.headline6!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold))
              .paddingOnly(top: 25),
          const CarLicenseCopy(),
          const SizedBox(height: 10),
          Align(
            alignment: TranslationService().isLocaleArabic()
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
            child: MyButtonWidget(
                color: Get.theme.focusColor,
                text: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next'.tr,
                      style: Get.textTheme.headline5!
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
                width: Get.width * 0.4,
                onPressed: () async {
                  if (controller.personalImageFile.value.path.isEmpty) {
                    controller.authManager.commonTools
                        .showFailedSnackBar('choosePersonalImage');
                    return;
                  }
                  if (controller.driverLicenseImage.value.path.isEmpty) {
                    controller.authManager.commonTools
                        .showFailedSnackBar('plesaseSelectLicenseID');
                    return;
                  }
                  if (controller.driverCarFrontImage.value.path.isEmpty) {
                    controller.authManager.commonTools.showFailedSnackBar(
                        'PleaseSelectAClearFrontImageOfTheVehicle');
                    return;
                  }
                  if (controller.driverCarBackImage.value.path.isEmpty) {
                    controller.authManager.commonTools.showFailedSnackBar(
                        'PleaseSelectAClearRearImageOfTheVehicle');
                    return;
                  }
                  if (controller.driverCarLicenseImage.value.path.isEmpty) {
                    controller.authManager.commonTools
                        .showFailedSnackBar('plesaseSelectVehicleLicenseID');
                    return;
                  }
                  bool response = await controller.registerUser();
                  if (response) {
                    FirebaseStorage storage = FirebaseStorage.instance;
                    //////////////////////////////////////////////////////
                    DatabaseReference addCarRef = FirebaseDatabase.instance
                        .ref()
                        .child('drivers/${controller.driversData!.user!.uid}');
                    controller.personalImageUploadTask = storage
                        .ref()
                        .child(
                            'drivers/${Uri.file(controller.personalImageFile.value.path).pathSegments.last}.jpg')
                        .putFile(controller.personalImageFile.value);
                    String personalImageUploadTaskUrl =
                        await (await controller.personalImageUploadTask!)
                            .ref
                            .getDownloadURL()
                            .catchError((e) {
                      log(e.toString());
                    });
                    /////////////////////////////////////////////////////
                    controller.driverLicenseImageUploadTask = storage
                        .ref()
                        .child(
                            'drivers/${Uri.file(controller.driverLicenseImage.value.path).pathSegments.last}.jpg')
                        .putFile(controller.driverLicenseImage.value);
                    String driverLicenseImageUploadTaskUrl =
                        await (await controller.driverLicenseImageUploadTask!)
                            .ref
                            .getDownloadURL()
                            .catchError((e) {
                      log(e.toString());
                    });
                    ////////////////////////////////////////////////////
                    controller.driverCarFrontImageUploadTask = storage
                        .ref()
                        .child(
                            'drivers/${Uri.file(controller.driverCarFrontImage.value.path).pathSegments.last}.jpg')
                        .putFile(controller.driverCarFrontImage.value);
                    String driverCarFrontImageUploadTaskUrl =
                        await (await controller.driverCarFrontImageUploadTask!)
                            .ref
                            .getDownloadURL()
                            .catchError((e) {
                      log(e.toString());
                    });
                    /////////////////////////////////////////////////////
                    controller.driverCarBackImageUploadTask = storage
                        .ref()
                        .child(
                            'drivers/${Uri.file(controller.driverCarBackImage.value.path).pathSegments.last}.jpg')
                        .putFile(controller.driverCarBackImage.value);
                    String driverCarBackImageUploadTaskUrl =
                        await (await controller.driverCarBackImageUploadTask!)
                            .ref
                            .getDownloadURL()
                            .catchError((e) {
                      log(e.toString());
                    });
                    /////////////////////////////////////////////////////
                    controller.driverCarLicenseImageUploadTask = storage
                        .ref()
                        .child(
                            'drivers/${Uri.file(controller.driverCarLicenseImage.value.path).pathSegments.last}.jpg')
                        .putFile(controller.driverCarLicenseImage.value);
                    String driverCarLicenseImageUploadTaskUrl =
                        await (await controller
                                .driverCarLicenseImageUploadTask!)
                            .ref
                            .getDownloadURL()
                            .catchError((e) {
                      log(e.toString());
                    });
                    ////////////////////////////////////////////////////

                    Map userData = {
                      'amount': {
                        'amount': '0',
                        'currentAmount': '0',
                        'status': 'wait',
                        'transNumber': '0'
                      },
                      'fullname': controller.fullNameController.value.text,
                      'email': controller.emailController.value.text,
                      'phone': controller.phoneController.value.text,
                      'approveDriver': false,
                      'carColor': controller.vehicleCarColor.value.text,
                      'carNumber': controller.plateNumber.value.text,
                      'carType': controller.carType.value.text,
                      'socialAgentNumber':
                          controller.nationalIDnumber.value.text,
                      // 'taxiType': controller.taxiType.value,
                      'carFactory': controller.carFactory.value.text,
                      'driversIsAvailable': false,
                      'personalImageUrl': personalImageUploadTaskUrl,
                      'driverLicenseImageUrl': driverLicenseImageUploadTaskUrl,
                      'driverCarFrontImageUrl':
                          driverCarFrontImageUploadTaskUrl,
                      'driverCarBackImageUrl': driverCarBackImageUploadTaskUrl,
                      'driverCarLicenseImageUrl':
                          driverCarLicenseImageUploadTaskUrl,
                      'id': '',
                      'tripStatusID': 'off',
                      'raiting': '0',
                    };
                    addCarRef.set(userData);
                    Get.to(() => const SplashView(), binding: SplashBinding());
                  }
                }),
          ).paddingOnly(top: 32),
        ],
      ),
    );
  }
}
