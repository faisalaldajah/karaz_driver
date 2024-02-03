import 'package:get/get.dart';
import 'package:karaz_driver/widgets/my_country_code/country_code_method.dart';

class CountryCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CountryCodeMethod>(() => CountryCodeMethod());
  }
}
