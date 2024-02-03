import 'package:get/get.dart';
import 'package:karaz_driver/screens/onbording/onbording_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}
