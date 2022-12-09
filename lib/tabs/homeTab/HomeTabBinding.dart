import 'package:get/get.dart';
import 'package:karaz_driver/tabs/homeTab/homeTabController.dart';

class HomeTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeTabController>(() => HomeTabController());
  }
}
