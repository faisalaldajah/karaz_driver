import 'package:get/get.dart';
import 'package:karaz_driver/tabs/ratings/ratingsController.dart';

class RatingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RatingsController>(() => RatingsController());
  }
}
