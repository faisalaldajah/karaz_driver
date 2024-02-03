import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/Utilities/app_constent.dart';
import 'package:karaz_driver/Utilities/general.dart';
import 'package:karaz_driver/datamodels/address/addresses.dart';
import 'package:karaz_driver/datamodels/trip_details/trip_data_details.dart';

class AddressController extends GetxController {
  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
  }

  Future<void> getCurrentLocation() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission != LocationPermission.always ||
        locationPermission != LocationPermission.whileInUse) {
      await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    cureentAddress.value.latitude = position.latitude;
    cureentAddress.value.longitude = position.longitude;
  }

  Future<TripDataDetails> getDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) async {
    TripDataDetails tripDataDetails = TripDataDetails();
    String url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$startLatitude,$startLongitude&origins=$endLatitude,$endLongitude&key=${AppConstants.googleApiKey}';
    try {
      var response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        tripDataDetails = TripDataDetails.fromJson(json.decode(response.body));
        return tripDataDetails;
      } else {
        return tripDataDetails;
      }
    } catch (e) {
      // appTools.showErrorMessage(e.toString(), Get.context!);
      return tripDataDetails;
    }
  }
}
