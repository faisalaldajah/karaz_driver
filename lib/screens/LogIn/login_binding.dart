import 'package:get/get.dart';
import 'package:karaz_driver/Services/AuthenticationService/Core/manager.dart';
import 'package:karaz_driver/screens/LogIn/login_controller.dart';

class LogInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogInController>(() => LogInController());
    Get.lazyPut<AuthenticationManager>(() => AuthenticationManager());
  }
}
