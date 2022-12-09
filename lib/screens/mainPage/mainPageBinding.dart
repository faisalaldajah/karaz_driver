import 'package:get/get.dart';
import 'package:karaz_driver/screens/mainPage/mainPgeController.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(() => MainPageController());
  }
}
