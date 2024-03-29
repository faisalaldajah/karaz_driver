import 'package:get/get.dart';
import 'package:karaz_driver/Services/AuthenticationService/Core/manager.dart';
import 'package:karaz_driver/screens/DriverRegistration/controllers/delivery_registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(
      () => RegistrationController(),
    );
    Get.lazyPut<AuthenticationManager>(
      () => AuthenticationManager(),
    );
  }
}
