import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';

class ShowImageByFile extends StatelessWidget {
  const ShowImageByFile({Key? key, required this.url}) : super(key: key);
  final File url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        iconTheme: const IconThemeData(color: AppColors.black),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.backgroundColor,
        ),
        child: Image.file(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
