import 'package:get/get.dart';
import 'package:karaz_driver/screens/NewTrip/NewTripController.dart';

class NewTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewTripController>(() => NewTripController());
  }
}
