import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/theme/app_colors.dart';
import 'package:karaz_driver/Utilities/Methods/tools.dart';
import 'package:karaz_driver/datamodels/tripdetails.dart';
import 'package:karaz_driver/globalvariabels.dart';
import 'package:karaz_driver/screens/NewTrip/NewTripBinding.dart';
import 'package:karaz_driver/screens/NewTrip/NewTripView.dart';
import 'package:karaz_driver/widgets/BrandDivier.dart';
import 'package:karaz_driver/widgets/ProgressDialog.dart';
import 'package:karaz_driver/widgets/TaxiButton.dart';

class NotificationDialog extends StatelessWidget {
  final TripDetails tripDetails;

  const NotificationDialog({Key? key, required this.tripDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 30.0,
            ),
            Image.asset(
              'images/taxi.png',
              width: 100,
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              'NEW TRIP REQUEST',
              style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 18),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'images/pickicon.png',
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Expanded(
                          child: Text(
                        tripDetails.pickupAddress!,
                        style: const TextStyle(fontSize: 18),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'images/desticon.png',
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Expanded(
                          child: Text(
                        tripDetails.destinationAddress!,
                        style: const TextStyle(fontSize: 18),
                      ))
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const BrandDivider(),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TaxiButton(
                      title: 'cancel'.tr,
                      color: AppColors.primary,
                      onPressed: () async {
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TaxiButton(
                      title: 'accept'.tr,
                      color: AppColors.success,
                      onPressed: () async {
                        checkAvailablity(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  void checkAvailablity(context) {
    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Accepting request',
      ),
    );
    DatabaseReference newRideRef = FirebaseDatabase.instance
        .ref()
        .child('drivers/${currentFirebaseUser!.uid}/newtrip');
    newRideRef.once().then((snapshot) {
      Get.back();
      Get.back();
      String thisRideID = '';
      if (snapshot.snapshot.value != null) {
        thisRideID = snapshot.snapshot.value.toString();
      } else {
        CommonTools().showFailedSnackBar('Ride not found');
      }
      if (thisRideID == tripDetails.rideID) {
        newRideRef.set('accepted');
        Get.to(() => const NewTripView(),
            binding: NewTripBinding(), arguments: tripDetails);
        goOffline();
      } else if (thisRideID == 'cancelled') {
        CommonTools().showFailedSnackBar('Ride has been cancelled');
      } else if (thisRideID == 'timeout') {
        CommonTools().showFailedSnackBar('Ride has timed out');
      } else {
        CommonTools().showFailedSnackBar('Ride not found');
      }
    });
  }
}
