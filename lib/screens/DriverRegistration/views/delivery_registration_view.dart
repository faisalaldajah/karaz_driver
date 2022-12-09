import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';
import 'package:karaz_driver/screens/DriverRegistration/controllers/delivery_registration_controller.dart';
import 'package:karaz_driver/screens/DriverRegistration/views/delivery_car_registration.dart';
import 'package:karaz_driver/screens/DriverRegistration/views/delivery_documents_registration.dart';
import 'package:karaz_driver/screens/DriverRegistration/widgets/page_step_container.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Registration'.tr,
                    style: Get.textTheme.headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Register as a delivery captain'.tr,
                    style: Get.textTheme.headline6!.copyWith(
                      color: Get.theme.hintColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Obx(
                () => Container(
                  height: Get.height * 0.1,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width: Get.width * 0.6,
                          child: const Divider(
                            thickness: 1.5,
                            color: AppColors.primary,
                          )),
                      SizedBox(
                        width: Get.width * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PageStepContainer(
                              step: 1,
                              currentStep: controller.pageStep.value,
                            ),
                            PageStepContainer(
                              step: 2,
                              currentStep: controller.pageStep.value,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => controller.pageStep.value == 1
                  ? DeliveryCarRegistration()
                  : controller.pageStep.value == 2
                      ? DeliveryDocumentsRegistration()
                      : const SizedBox())
            ],
          ),
        ));
  }
}
