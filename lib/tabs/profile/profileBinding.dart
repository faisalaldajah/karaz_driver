import 'package:get/get.dart';
import 'package:karaz_driver/tabs/profile/profileController.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileContrller>(() => ProfileContrller());
  }
}
