import 'package:get/get.dart';
import 'package:karaz_driver/screens/wallet/walletController.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletController>(() => WalletController());
  }
}
