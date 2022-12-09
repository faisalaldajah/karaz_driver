import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';
import 'package:karaz_driver/Utilities/Constants/Strings/AppStyles.dart';

class UI {
  static GetSnackBar successSnackBar(
      {String title = 'success', String? message, int duration = 3}) {
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headline4!.merge(const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.w500))),
      messageText: Text(message!,
          style: Get.textTheme.headline6!.merge(const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.w500))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      icon: const Icon(Icons.check_circle_outline,
          size: 32, color: AppColors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: duration),
    );
  }

  static BoxShadow boxShadow = BoxShadow(
    blurRadius: 4,
    color: AppColors.grey.withOpacity(0.1),
    offset: const Offset(0, 0),
    spreadRadius: 3,
  );

  static GetSnackBar errorSnackBar(
      {String title = 'failed', String? message, int duration = 5}) {
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headline4!.merge(const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.w500))),
      messageText: Text(message!,
          style: Get.textTheme.headline6!.merge(const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.w500))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: const Icon(Icons.remove_circle_outline,
          size: 32, color: AppColors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: duration),
    );
  }

  static Color parseColor(String hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll('#', '0xFF')))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  static InputDecoration getInputDecoration(
      {String hintText = '', IconData? iconData, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      errorMaxLines: 3,
      errorStyle: Get.theme.textTheme.bodyText2!
          .copyWith(fontWeight: FontWeight.w500, color: Colors.red),
      hintStyle: Get.theme.textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w500, color: AppColors.black.withOpacity(0.8)),
      prefixIcon: iconData != null
          ? Icon(iconData, color: Get.theme.focusColor).marginOnly(right: 14)
          : const SizedBox(),
      prefixIconConstraints: iconData != null
          ? const BoxConstraints.expand(width: 38, height: 38)
          : const BoxConstraints.expand(width: 0, height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.all(0),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
    );
  }

  static GetSnackBar notificationBar(RemoteMessage message,
      {int duration = 30}) {
    return GetSnackBar(
      isDismissible: true,
      // onTap: (v) {
      //   Get.back();
      //   CommonTools().getOnTapFunction(
      //       type: int.parse(message.data['MessageType']),
      //       transId: message.data['TransId']);
      // },
      titleText: Text(message.notification!.title ?? '',
          style: Get.textTheme.headline6!.merge(const TextStyle(
              color: AppColors.black, fontWeight: FontWeight.w500))),
      messageText: Text(message.notification!.body ?? '',
          style: Get.textTheme.bodyText2!.merge(
              TextStyle(color: AppColors.grey.withOpacity(0.5), height: 1.5))),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10.0),
      backgroundColor: AppColors.backgroundColor,
      boxShadows: [AppStyles.primaryShadow],
      icon: Container(
        padding: const EdgeInsets.only(right: 8),
        child: Stack(
          children: [
            Container(
              width: Get.width * 0.14,
              height: Get.width * 0.14,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://images.pexels.com/photos/927523/pexels-photo-927523.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                      ),
                      fit: BoxFit.cover)),
            ),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
      borderRadius: AppStyles.borderRadius,
      duration: const Duration(seconds: 3),
    );
  }
}
