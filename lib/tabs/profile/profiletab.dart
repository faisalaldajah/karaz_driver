import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';
import 'package:karaz_driver/globalvariabels.dart';
import 'package:karaz_driver/screens/wallet/AddAmount.dart';
import 'package:karaz_driver/tabs/profile/profileController.dart';
import 'package:karaz_driver/widgets/GradientButton.dart';

class ProfileTab extends GetView<ProfileContrller> {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(color: AppColors.colorAccent1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentDriverInfo!.amount!.amount!,
                      style: Get.textTheme.headline1!
                          .copyWith(color: AppColors.white),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Current balance'.tr,
                      style: Get.textTheme.headline1!
                          .copyWith(color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              currentDriverInfo!.personalImageUrl!),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle),
                ),
                const SizedBox(height: 10),
                Text(
                  '${'Name'.tr}: ${currentDriverInfo!.fullname!}',
                  style: Get.textTheme.headline1!,
                ),
                const SizedBox(height: 20),
                Text(
                  '${'carType'.tr}: ${currentDriverInfo!.carType!}',
                  style: Get.textTheme.headline1!,
                ),
                const SizedBox(height: 20),
                Text(
                  '${'Car color'.tr}: ${currentDriverInfo!.carColor!}',
                  style: Get.textTheme.headline1!,
                ),
                const SizedBox(height: 50),
                GradientButton(
                  title: 'Recharge wallet'.tr,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddAmount(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                //   TextButton(
                //     onPressed: () {
                //       FirebaseAuth.instance.signOut();
                //       Get.offAll(() => const LoginPage(),
                //           binding: LogInBinding());
                //     },
                //     child: Text(
                //       'logout'.tr,
                //       style: Get.textTheme.headline2,
                //     ),
                //   )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
