import 'package:get/get.dart';
import 'package:karaz_driver/tabs/earningsTab/EarningsController.dart';

class EarningsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EarningsController>(() => EarningsController());
  }
}
