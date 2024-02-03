import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:karaz_driver/Services/translation_service.dart';
import 'package:karaz_driver/theme/app_colors.dart';
import 'package:karaz_driver/Utilities/Constants/UI.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonTools {
  TextEditingController otpController = TextEditingController();
  void notifcationBarInApp(RemoteMessage message, {int duration = 3}) {
    Get.showSnackbar(UI.notificationBar(message, duration: duration));
  }

  String? passwordValidate(String? value, TextEditingController controller) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (controller.text.isEmpty) {
      return value = 'this field is required'.tr;
    } else if (controller.text.length < 8) {
      return value = 'invalid password'.tr;
    } else if (regExp.hasMatch(controller.text) == false) {
      return value = 'please enter valid password'.tr;
    } else {
      value = null;
    }
    return value;
  }

  String? emailValidate(String? value, TextEditingController controller) {
    if (controller.text.isEmpty) {
      return value = 'this field is required'.tr;
    } else if (!controller.text.contains('@') ||
        !controller.text.contains('.com')) {
      return value = 'please enter vaild email'.tr;
    } else {
      value = null;
    }
    return value;
  }

  String? nameValidate(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    } else if (controller.text.length < 2) {
      return 'pleaseEnterVaildName'.tr;
    }
    return null;
  }

  String? usernameValidate(TextEditingController controller) {
    String pattern = r'^(?=.*?[a-z])';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(controller.text) == false) {
      return 'this field is required'.tr;
    }
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    } else if (controller.text.length < 3) {
      return 'pleaseEnterVaildName'.tr;
    }
    return null;
  }

  String? phoneNumberValidate(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    }
    if (controller.text
        .contains(RegExp('[a-zA-Zا-ي?=.*!@#\$%^&*(),.?:{}|<>]'))) {
      return 'should be contains numbers only'.tr;
    } else if (controller.text.startsWith('0') == false) {
      return 'phone number must start with 0'.tr;
    } else if (controller.text.length != 10) {
      return 'phone number must be 10 numbers'.tr;
    }
    return null;
  }

  String? expiryDateValidate(TextEditingController controller) {
    if (controller.text.isEmpty) {
      'this field is required'.tr;
    } else if (controller.text.length < 3) {
      'pleaseEnterVaildName'.tr;
    } else if (controller.text
        .contains(RegExp('[a-zA-Zا-ي?=.*!@#\$%^&*(),.?:{}|<>]'))) {
      return 'should be contains numbers only'.tr;
    } else {
      return null;
    }
    return null;
  }

  String? dateValidate(String? value, TextEditingController controller) {
    if (controller.text.isEmpty) {
      value = 'this field is required'.tr;
    } else {
      value = null;
    }
    return value;
  }

  String? idNumberValidate(String? value, TextEditingController controller) {
    if (value == null || value.isEmpty) {
      return value = 'this field is required'.tr;
    }
    if (value.contains(RegExp('[a-zA-Zا-ي?=.*!@#\$%^&*(),.?:{}|<>]'))) {
      return value = 'should be contains numbers only'.tr;
    } else if (value.length != 10) {
      return value = 'id number must be 10 numbers'.tr;
    } else {
      value = null;
    }
    return value;
  }

  String? billCostValidate(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    }
    if (double.tryParse(controller.text) == null) {
      return 'should be contains numbers only'.tr;
    }
    return null;
  }

  String otpValidation(value) {
    final currentotp = otpController.text;
    if (currentotp.isEmpty) {
      value = 'this field is required'.tr;
    } else if (currentotp.length > 6) {
      value = 'this filed should be 6 digits';
    } else {
      value = null;
    }
    return value;
  }

  String? offerPriceValidate(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    }
    if (double.tryParse(controller.text) == null) {
      return 'should be contains numbers only'.tr;
    }
    return null;
  }

  String? billReasonValidate(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    }
    return null;
  }

  String? plateLetterCarValidate(
      String? value, TextEditingController controller) {
    if (controller.text.isEmpty) {
      return value = 'this field is required'.tr;
    } else if (controller.text.length < 3) {
      return value = 'enterValidData'.tr;
    } else if (controller.text.contains(RegExp('[?=.*!@#\$%^&*(),.?:{}|<>]'))) {
      return 'should contains letters only'.tr;
    }
    return value = null;
  }

  String? plateNumberCarValidate(
      String? value, TextEditingController controller) {
    if (controller.text.isEmpty) {
      return value = 'this field is required'.tr;
    } else if (controller.text.length < 4) {
      return value = 'enterValidData'.tr;
    } else if (value!.contains(RegExp('[a-zA-Zا-ي?=.*!@#\$%^&*(),.?:{}|<>]'))) {
      return value = 'should be contains numbers only'.tr;
    }

    return value = null;
  }

  String? neighborhoodValidate(
      String? value, TextEditingController controller) {
    if (controller.text.isEmpty) {
      return value = 'this field is required'.tr;
    }

    return value = null;
  }

  String? buildingNumberValidate(
      String? value, TextEditingController controller) {
    if (controller.value.text.isEmpty || controller.value.text == '') {
      value = 'this field is required'.tr;
      return value;
    } else {
      value = null;
    }
    return null;
  }

  String? requiredFieldValidate(TextEditingController controller) {
    if (controller.value.text.isEmpty || controller.value.text == '') {
      return 'this field is required'.tr;
    }
    return null;
  }

  String? bankAccountNumberValidate(
      String? value, TextEditingController controller, int textLength) {
    if (controller.text.isEmpty ||
        controller.text.isEmpty ||
        controller.text.trim() == '') {
      return 'this field is required'.tr;
    } else if (controller.text.length < textLength && textLength == 24) {
      return 'enterValidIban'.tr;
    } else if (controller.text.length < textLength && textLength == 8) {
      return 'enterValidAccountNumber'.tr;
    }

    return null;
  }

  String? bankIbantNumberValidate(
      String? value, TextEditingController controller, int textLength) {
    if (controller.text.isEmpty ||
        controller.text.isEmpty ||
        controller.text.trim() == '') {
      return 'this field is required'.tr;
    } else if (controller.text.length < textLength && textLength == 24) {
      return 'enterValidIban'.tr;
    } else if (controller.text.length < textLength && textLength == 8) {
      return 'enterValidAccountNumber'.tr;
    } else if (controller.text.contains('SA') == false) {
      return 'start with SA'.tr;
    }

    return null;
  }

  String? validatePinputOtp(TextEditingController controller) {
    String pattern = r'^(?=.*?[0-9])';
    RegExp regExp = RegExp(pattern);
    regExp.hasMatch(controller.text);
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    } else if (regExp.hasMatch(controller.text) == false) {
      return 'inValidOtp'.tr;
    }
    return null;
  }

  void showSuccessSnackBar(String message, {int duration = 3}) {
    Get.showSnackbar(UI.successSnackBar(
        title: 'success', message: message.tr, duration: duration));
  }

  void showFailedSnackBar(String message) {
    Get.showSnackbar(UI.errorSnackBar(
      title: 'failed',
      message: message.tr,
    ));
  }

  void showLoading() {
    Get.dialog(
      Center(
        child: Container(
          width: Get.width * 0.25,
          height: Get.width * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: AppColors.black.withOpacity(0.5),
          ),
          child: Center(
              child: Theme(
                  data: ThemeData(
                      cupertinoOverrideTheme: const CupertinoThemeData(
                          brightness: Brightness.dark)),
                  child: const CupertinoActivityIndicator(
                    radius: 15.0,
                  ))),
        ),
      ),
      barrierColor: Colors.transparent,
      barrierDismissible: false,
    );
  }

  void showLoadingCustom(double backgroundOpacity, Widget widget) {
    Get.dialog(
        Center(
          child: widget,
        ),
        barrierDismissible: true,
        barrierColor: AppColors.white.withOpacity(backgroundOpacity));
  }

  Future<bool> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      // Future.error('Location services are disabled.')
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Future.error('Location permissions are denied')
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Future.error('Location permissions are permanently denied, we cannot request permissions.')
      return false;
    }

    print('10');

    return true;
  }

  // Future<LocationData> determinePosition() async {
  //   print('6');

  //   bool checkPer = await checkPermission();
  //   Position? position;

  //   if (checkPer) {
  //     print('12');

  //     position = await Geolocator.getCurrentPosition(
  //         timeLimit: const Duration(seconds: 10),
  //         desiredAccuracy: LocationAccuracy.low);
  //   }

  //   print('77');

  //   return LocationData(localPosition: position);
  // }

  void unFocusKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  int createRandom() {
    int randomID;
    Random random = Random();
    int randomFirst = random.nextInt(1000000000) + 1000000;
    int randomSecond = random.nextInt(100000) + randomFirst;
    randomID = randomFirst + randomSecond;
    return randomID;
  }

  void showWarningDialogMutliButtons(
      BuildContext context,
      String title,
      String message,
      String fbTitle,
      String sbTitle,
      Color fbColor,
      Color sbColor,
      VoidCallback fbFunction,
      VoidCallback sbFunction) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            title,
            style: Get.textTheme.displaySmall!.copyWith(color: AppColors.black),
          ),
        ),
        content: Text(
          message,
          style: Get.textTheme.titleLarge!.copyWith(color: AppColors.black),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: fbFunction,
            child: Text(
              fbTitle,
              style: Get.textTheme.titleLarge!
                  .copyWith(color: fbColor, fontWeight: FontWeight.w500),
            ),
          ),
          CupertinoDialogAction(
            onPressed: sbFunction,
            child: Text(
              sbTitle,
              style: Get.textTheme.titleLarge!
                  .copyWith(color: sbColor, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  void showWarningDialogSingleButton(
      BuildContext context,
      String title,
      String message,
      String buttonTitle,
      Color buttonTitleColor,
      VoidCallback buttonFunction) {
    showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            title,
            style: Get.textTheme.displaySmall!.copyWith(color: AppColors.black),
          ),
        ),
        content: Text(
          message,
          style: Get.textTheme.bodyMedium!.copyWith(color: AppColors.black),
          maxLines: 3,
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: buttonFunction,
            child: Text(
              buttonTitle,
              style: Get.textTheme.titleLarge!.copyWith(
                  color: buttonTitleColor, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  String getVerboseDateTimeRep(String date) {
    var dateUTC = DateTime.parse('${date.replaceAll('/', '-')}Z').toUtc();

    var dateTime = dateUTC.toLocal();

    DateTime now = DateTime.now().toUtc();
    bool isArabic = TranslationService().isLocaleArabic();

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inMinutes < 2) {
      return isArabic ? 'الان' : 'Just Now';
    }

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inMinutes >= 2 &&
        now.difference(dateTime).inMinutes < 60) {
      int diff = now.difference(dateTime).inMinutes;

      return TranslationService().isLocaleArabic()
          ? 'قبل $diff دقيقة'
          : '$diff minutes ago';
    }

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inHours >= 1 &&
        now.difference(dateTime).inHours < 2) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل ساعة' : '$diff hour ago';
    }

    if (now.difference(dateTime).inHours >= 2 &&
        now.difference(dateTime).inHours < 3) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل ساعتين' : '$diff hours ago';
    }

    if (now.difference(dateTime).inHours >= 3 &&
        now.difference(dateTime).inHours <= 10) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل $diff ساعات' : '$diff hours ago';
    }

    if (now.difference(dateTime).inHours > 10 &&
        now.difference(dateTime).inHours <= 24) {
      return isArabic ? 'اليوم' : 'Today';
    }

    if (now.difference(dateTime).inHours > 24 &&
        now.difference(dateTime).inHours <= 48) {
      return isArabic ? 'أمس' : 'Yesterday';
    }

    if (now.difference(dateTime).inDays >= 2 &&
        now.difference(dateTime).inDays <= 6) {
      int diff = now.difference(dateTime).inDays;

      return isArabic ? 'قبل $diff أيام' : '$diff days ago';
    }

    if (now.difference(dateTime).inDays >= 7 &&
        now.difference(dateTime).inDays < 30) {
      int diff = now.difference(dateTime).inDays ~/ 7;

      return isArabic ? 'قبل $diff أسبوع' : '$diff weeks ago';
    }

    if (now.difference(dateTime).inDays > 29 &&
        (now.difference(dateTime).inDays ~/ 30).toInt() < 12) {
      double diff = now.difference(dateTime).inDays / 30;

      int months = diff.toInt();

      return isArabic ? '$months شهر' : '$months month';
    }

    if ((now.difference(dateTime).inDays ~/ 30).toInt() >= 12) {
      double diff = now.difference(dateTime).inDays / 365;

      int years = diff.toInt();

      return isArabic ? '$years س' : '$years y';
    } else {
      return '${intl.DateFormat.yMMMMd().format(dateTime)} - ${intl.DateFormat.jm().format(dateTime)}';
    }
  }

  String getVerboseDateTimeRepFB(DateTime dateTime) {
    DateTime now = DateTime.now().toUtc();
    bool isArabic = TranslationService().isLocaleArabic();

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inMinutes < 2) {
      return isArabic ? 'الان' : 'Just Now';
    }

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inMinutes >= 2 &&
        now.difference(dateTime).inMinutes < 60) {
      int diff = now.difference(dateTime).inMinutes;

      return TranslationService().isLocaleArabic()
          ? 'قبل $diff دقيقة'
          : '$diff minutes ago';
    }

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inHours >= 1 &&
        now.difference(dateTime).inHours < 2) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل ساعة' : '$diff hour ago';
    }

    if (now.difference(dateTime).inHours >= 2 &&
        now.difference(dateTime).inHours < 3) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل ساعتين' : '$diff hours ago';
    }

    if (now.difference(dateTime).inHours >= 3 &&
        now.difference(dateTime).inHours <= 10) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل $diff ساعات' : '$diff hours ago';
    }

    if (now.difference(dateTime).inHours > 10 &&
        now.difference(dateTime).inHours <= 24) {
      return isArabic ? 'اليوم' : 'Today';
    }

    if (now.difference(dateTime).inHours > 24 &&
        now.difference(dateTime).inHours <= 48) {
      return isArabic ? 'أمس' : 'Yesterday';
    }

    if (now.difference(dateTime).inDays >= 2 &&
        now.difference(dateTime).inDays <= 6) {
      int diff = now.difference(dateTime).inDays;

      return isArabic ? 'قبل $diff أيام' : '$diff days ago';
    }

    if (now.difference(dateTime).inDays >= 7 &&
        now.difference(dateTime).inDays < 30) {
      int diff = now.difference(dateTime).inDays ~/ 7;

      return isArabic ? 'قبل $diff أسبوع' : '$diff weeks ago';
    }

    if (now.difference(dateTime).inDays > 29 &&
        (now.difference(dateTime).inDays ~/ 30).toInt() < 12) {
      double diff = now.difference(dateTime).inDays / 30;

      int months = diff.toInt();

      return isArabic ? '$months شهر' : '$months month';
    }

    if ((now.difference(dateTime).inDays ~/ 30).toInt() >= 12) {
      double diff = now.difference(dateTime).inDays / 365;

      int years = diff.toInt();

      return isArabic ? '$years س' : '$years y';
    } else {
      return '${intl.DateFormat.yMMMMd().format(dateTime)} - ${intl.DateFormat.jm().format(dateTime)}';
    }
  }

  void openURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  int getRandomSmallNumberFromList() {
    var list = [1, 2, 3, 4, 5, 7];
    return getRandomElement(list);
  }

  T getRandomElement<T>(List<T> list) {
    final random = Random();
    var i = random.nextInt(list.length);
    return list[i];
  }
}
