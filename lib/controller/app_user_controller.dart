import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/Utilities/app_constent.dart';
import 'package:karaz_driver/datamodels/address/addresses.dart';
import 'package:karaz_driver/datamodels/app_user/app_user.dart';
import 'package:karaz_driver/datamodels/driver.dart';

class AppUserController extends GetxController {
  void setUserDetails(AppUserData appUser) {}

  Future<Driver?> getUserDetails(String? id) async {
    DatabaseReference firebaseDatabase =
        FirebaseDatabase.instance.ref('${AppConstants.USER}/$id');
    DataSnapshot event = await firebaseDatabase.get();
    // Get.log(event.value.toString());
    dynamic data = event.value;
    if (data != null) {
      Driver appUser = Driver(
        email: data[AppConstants.email],
        fullname: data[AppConstants.fullName],
        phone: data[AppConstants.phoneNumber],
        id: id,
        personalImageUrl: '',
      );

      return appUser;
    }
    return null;
  }

  void setAddresUser(String id, AddressModel addressModel) {}
}
