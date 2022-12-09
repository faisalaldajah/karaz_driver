import 'package:get/get.dart';
import 'package:karaz_driver/screens/history/historyController.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(() => HistoryController());
  }
}
