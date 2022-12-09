import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';
import 'package:karaz_driver/screens/DriverRegistration/controllers/delivery_registration_controller.dart';
import 'package:karaz_driver/widgets/ShowImageByFile.dart';

class CarLicenseCopy extends GetView<RegistrationController> {
  const CarLicenseCopy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      dashPattern: const [5, 5],
      color: Get.theme.focusColor,
      strokeWidth: 2,
      child: Obx(
        () => InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: Get.width * 0.3,
              height: Get.height * 0.13,
              decoration: const BoxDecoration(color: AppColors.greyWhite),
              child: controller.driverCarLicenseImage.value.path.isNotEmpty
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            controller.driverCarLicenseImage.value,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: InkWell(
                              onTap: () async {
                                controller.driverCarLicenseImage.value =
                                    File('');
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(5.0),
                                child: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 30,
                                  child: Icon(
                                    Icons.delete,
                                    color: AppColors.white,
                                    size: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () async {
                                Get.to(() => ShowImageByFile(
                                    url: controller
                                        .driverCarLicenseImage.value));
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(5.0),
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.lightGreen,
                                    size: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Get.theme.focusColor,
                        ),
                        Text(
                          'Upload Image'.tr,
                          style: Get.textTheme.bodyMedium!.copyWith(
                              color: Get.theme.focusColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'acopyofthecarlicense'.tr,
                    style: Get.textTheme.headline3,
                  ),
                ),
                content: Text(
                  'Choose photo/file'.tr,
                  style: Get.textTheme.headline5,
                ),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(
                      'photos'.tr,
                      style: Get.textTheme.headline6!
                          .copyWith(color: CupertinoColors.activeBlue),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      controller.selectFile(5);
                    },
                  ),
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(
                      'files'.tr,
                      style: Get.textTheme.headline6!
                          .copyWith(color: CupertinoColors.activeBlue),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: [
                          'jpg',
                          'pdf',
                          'png',
                          'jpeg',
                        ],
                      );

                      if (result != null) {
                        controller.driverCarLicenseImage.value =
                            File(result.files.single.path!);
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text('cancel'.tr,
                        style: Get.textTheme.headline6!
                            .copyWith(color: CupertinoColors.activeBlue)),
                    onPressed: () async {
                      Get.back();
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    ).paddingOnly(top: 12, left: 1);
  }
}
