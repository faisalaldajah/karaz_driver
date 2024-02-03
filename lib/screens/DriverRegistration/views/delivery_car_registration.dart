import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/Services/AuthenticationService/Core/manager.dart';
import 'package:karaz_driver/Services/translation_service.dart';
import 'package:karaz_driver/Utilities/tools/tools.dart';
import 'package:karaz_driver/theme/app_colors.dart';
import 'package:karaz_driver/screens/DriverRegistration/controllers/delivery_registration_controller.dart';
import 'package:karaz_driver/widgets/CustomizedTextField.dart';
import 'package:karaz_driver/widgets/PasswordRoleChecker.dart';
import 'package:karaz_driver/widgets/myButton_widget.dart';

class DeliveryCarRegistration extends GetView<RegistrationController> {
  final GlobalKey<FormState> carForm = GlobalKey<FormState>();

  DeliveryCarRegistration({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: carForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'details'.tr,
              style: Get.textTheme.titleLarge!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ).paddingOnly(top: 10),
            CustomizedTextField(
              formatter: [
                LengthLimitingTextInputFormatter(100),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Zا-ي ]'))
              ],
              textFieldController: controller.fullNameController.value,
              hint: 'fullname',
              textInputType: TextInputType.text,
              obscureText: false,
              validator: (value) => Get.find<AuthenticationManager>()
                  .commonTools
                  .nameValidate(controller.emailController.value),
            ),
            const SizedBox(height: 10),
            CustomizedTextField(
              formatter: [
                LengthLimitingTextInputFormatter(100),
                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              ],
              textFieldController: controller.nationalIDnumber.value,
              hint: 'nationalIDnumber',
              textInputType: TextInputType.number,
              obscureText: false,
              validator: (value) => Get.find<AuthenticationManager>()
                  .commonTools
                  .idNumberValidate(value, controller.emailController.value),
            ),
            const SizedBox(height: 10),
            CustomizedTextField(
              formatter: [
                LengthLimitingTextInputFormatter(100),
                FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-Z0-9@#&\$*-_%]'))
              ],
              textFieldController: controller.emailController.value,
              hint: 'email address',
              textInputType: TextInputType.emailAddress,
              obscureText: false,
              validator: (value) => Get.find<AuthenticationManager>()
                  .commonTools
                  .emailValidate(value, controller.emailController.value),
            ),
            const SizedBox(height: 10),
            CustomizedTextField(
              formatter: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              ],
              textFieldController: controller.phoneController.value,
              hint: 'Phone Number',
              textInputType: TextInputType.phone,
              obscureText: false,
              validator: (value) => Get.find<AuthenticationManager>()
                  .commonTools
                  .phoneNumberValidate(controller.phoneController.value),
            ),
            const SizedBox(height: 10),
            Text(
              'Car Details'.tr,
              style: Get.textTheme.titleLarge!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ).paddingOnly(top: 10),
            const SizedBox(height: 10),
            CustomizedTextField(
              formatter: [
                LengthLimitingTextInputFormatter(15),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Zا-ي]'))
              ],
              textFieldController: controller.carType.value,
              hint: 'carType',
              textInputType: TextInputType.text,
              obscureText: false,
              validator: (value) => Get.find<AuthenticationManager>()
                  .commonTools
                  .nameValidate(controller.phoneController.value),
            ),
            const SizedBox(height: 10),
            CustomizedTextField(
              formatter: [
                LengthLimitingTextInputFormatter(15),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Zا-ي0-9]'))
              ],
              textFieldController: controller.carModel.value,
              hint: 'carModel',
              textInputType: TextInputType.text,
              obscureText: false,
              validator: (value) =>
                  appTools.nameValidate(controller.phoneController.value),
            ),
            const SizedBox(height: 10),
            CustomizedTextField(
              formatter: [
                LengthLimitingTextInputFormatter(15),
                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              ],
              textFieldController: controller.carFactory.value,
              hint: 'manufacturingyear',
              textInputType: TextInputType.phone,
              obscureText: false,
              validator: (value) => appTools
                  .phoneNumberValidate(controller.phoneController.value),
            ),
            const SizedBox(height: 10),
            CustomizedTextField(
              formatter: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp('[0-9-]'))
              ],
              textFieldController: controller.plateNumber.value,
              hint: 'Vehicle plate numbers',
              textInputType: TextInputType.phone,
              obscureText: false,
              validator: (value) => appTools
                  .phoneNumberValidate(controller.phoneController.value),
            ),
            const SizedBox(height: 10),
            CustomizedTextField(
              formatter: [
                LengthLimitingTextInputFormatter(100),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Zا-ي ]'))
              ],
              textFieldController: controller.vehicleCarColor.value,
              hint: 'Vehicle car color',
              textInputType: TextInputType.text,
              obscureText: false,
              validator: (value) =>
                  appTools.nameValidate(controller.phoneController.value),
            ),
            const SizedBox(height: 10),
            Text(
              'Set Password'.tr,
              style: Get.textTheme.titleLarge,
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
              validator: (value) =>
                  appTools.passwordValidate(controller.newPassword),
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
              validator: (value) =>
                  appTools.passwordValidate(controller.repeatNewPassword),
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
                  'images/Icon open-info.svg',
                  width: 8,
                  color: AppColors.success,
                ),
                const SizedBox(width: 6),
                SizedBox(
                  width: Get.width * 0.7,
                  child: Text(
                    'By tapping continue below, you agree to our terms and conditions.'
                        .tr,
                    style: Get.textTheme.titleLarge,
                    maxLines: 4,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25.0,
            ),
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
                        style: Get.textTheme.headlineSmall!
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
                    // controller.pageStep.value = 2;
                    if (carForm.currentState!.validate()) {
                      controller.pageStep.value = 2;
                    }
                  }),
            ).paddingOnly(top: 32),
          ],
        ),
      ),
    );
  }
}
