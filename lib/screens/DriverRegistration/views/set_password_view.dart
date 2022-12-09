// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';
import 'package:karaz_driver/screens/DriverRegistration/controllers/delivery_registration_controller.dart';
import 'package:karaz_driver/widgets/CustomizedTextField.dart';
import 'package:karaz_driver/widgets/GradientButton.dart';
import 'package:karaz_driver/widgets/PasswordRoleChecker.dart';

class SetPasswordView extends GetView<RegistrationController> {
  final GlobalKey<FormState> registrationKey = GlobalKey<FormState>();
  SetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: registrationKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              const SizedBox(height: 20),
              Text(
                'Set Password'.tr,
                style: Get.textTheme.headline6,
              ),
              CustomizedTextField(
                formatter: [
                  LengthLimitingTextInputFormatter(16),
                  FilteringTextInputFormatter.deny(RegExp(r'\s'))
                ],
                onChanged: (value) {
                  String number = r'^(?=.*?[0-9])';
                  RegExp numberregExp = RegExp(number);
                  String letter = r'^(?=.*?[A-Z])(?=.*?[a-z])';
                  String sympol = r'(?=.*?[!@#\$&*~%])';
                  RegExp regExp = RegExp(sympol);
                  RegExp letterregExp = RegExp(letter);
                  if (value.length >= 8) {
                    controller.eightCharacter.value = true;
                  } else {
                    controller.eightCharacter.value = false;
                  }
                  if (letterregExp.hasMatch(controller.newPassword.text)) {
                    controller.characterCase.value = true;
                  } else {
                    controller.characterCase.value = false;
                  }
                  if (controller.repeatNewPassword.text == value) {
                    controller.samePassword.value = true;
                  } else {
                    controller.samePassword.value = false;
                  }
                  if ((numberregExp.hasMatch(controller.newPassword.text) &&
                      regExp.hasMatch(controller.newPassword.text))) {
                    controller.numberOfDigit.value = true;
                  } else {
                    controller.numberOfDigit.value = false;
                  }

                  if ((controller.newPassword.text ==
                          controller.repeatNewPassword.value.text) &&
                      (controller.newPassword.text.isNotEmpty &&
                          controller.repeatNewPassword.text.isNotEmpty)) {
                    controller.samePassword.value = true;
                  } else {
                    controller.samePassword.value = false;
                  }
                },
                suffix: IconButton(
                  onPressed: () {
                    controller.showFirstPassword.value =
                        !controller.showFirstPassword.value;
                  },
                  color: controller.showFirstPassword.value
                      ? AppColors.primary
                      : AppColors.grey,
                  icon: Icon(!controller.showFirstPassword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                ),
                obscureText: !controller.showFirstPassword.value,
                textFieldController: controller.newPassword,
                title: '',
                hint: 'New Password',
                textInputType: TextInputType.text,
                validator: (value) => controller.authManager.commonTools
                    .passwordValidate(value, controller.newPassword),
                icon: IconButton(
                  icon: controller.hidePassword.value
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                  onPressed: () {
                    controller.hidePassword.value =
                        !controller.hidePassword.value;
                  },
                ),
              ),
              CustomizedTextField(
                formatter: [
                  LengthLimitingTextInputFormatter(16),
                  FilteringTextInputFormatter.deny(RegExp(r'\s'))
                ],
                validator: (value) => controller.authManager.commonTools
                    .passwordValidate(value, controller.repeatNewPassword),
                suffix: IconButton(
                  onPressed: () {
                    controller.showSecondPasssword.value =
                        !controller.showSecondPasssword.value;
                  },
                  color: controller.showSecondPasssword.value
                      ? AppColors.primary
                      : AppColors.grey,
                  icon: Icon(!controller.showSecondPasssword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                ),
                obscureText: !controller.showSecondPasssword.value,
                textFieldController: controller.repeatNewPassword,
                title: '',
                hint: 'Confirm Password',
                textInputType: TextInputType.text,
                onChanged: (value) {
                  if ((controller.newPassword.text ==
                          controller.repeatNewPassword.value.text) &&
                      (controller.newPassword.text.isNotEmpty &&
                          controller.repeatNewPassword.text.isNotEmpty)) {
                    controller.samePassword.value = true;
                  } else {
                    controller.samePassword.value = false;
                  }
                },
                icon: IconButton(
                  icon: controller.hidePassword.value
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                  onPressed: () {
                    controller.hidePassword.value =
                        !controller.hidePassword.value;
                  },
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              PasswordRoleChecker(
                content: 'At least 8 characters.',
                roleCheck: controller.eightCharacter.value,
              ),
              const SizedBox(height: 8.0),
              PasswordRoleChecker(
                content: 'Uppercase(A-Z), lowercase (a-z).',
                roleCheck: controller.characterCase.value,
              ),
              const SizedBox(height: 8.0),
              PasswordRoleChecker(
                content: 'Digits (0-9) & special character (\$,%,@..).',
                roleCheck: controller.numberOfDigit.value,
              ),
              const SizedBox(height: 8.0),
              PasswordRoleChecker(
                content: 'Your password is matched.',
                roleCheck: controller.samePassword.value,
              ),
              const SizedBox(height: 15.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svg/Icon open-info.svg',
                    width: 8,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: Get.width * 0.7,
                    child: Text(
                      'By tapping continue below, you agree to our terms and conditions.'
                          .tr,
                      style: Get.textTheme.headline6,
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              GradientButton(
                  title: 'Done'.tr,
                  onPressed: () async {
                    print(controller.phoneController.value.text);
                    bool response = await controller.registerUser();
                    if (response) {
                      FirebaseStorage storage = FirebaseStorage.instance;
                      //////////////////////////////////////////////////////
                      DatabaseReference addCarRef = FirebaseDatabase.instance
                          .ref()
                          .child(
                              'drivers/${controller.driversData!.user!.uid}');
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
                          await (await controller
                                  .driverCarFrontImageUploadTask!)
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
                        'approveDriver': false,
                        'carColor': controller.vehicleCarColor.value.text,
                        'carNumber': controller.plateNumber.value.text,
                        'carType': controller.carType.value.text,
                        'socialAgentNumber':
                            controller.nationalIDnumber.value.text,
                        // 'taxiType': controller.taxiType.value,
                        'carFactory': controller.carFactory.value.text,
                        'driversIsAvailable': false,
                      };
                      print(userData);
                      addCarRef.set(userData);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
