import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';
import 'package:karaz_driver/globalvariabels.dart';
import 'package:karaz_driver/helpers/helpermethods.dart';
import 'package:karaz_driver/screens/NewTrip/NewTripController.dart';
import 'package:karaz_driver/widgets/TaxiButton.dart';
import 'package:url_launcher/url_launcher.dart';

class NewTripView extends GetView<NewTripController> {
  const NewTripView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              padding: EdgeInsets.only(bottom: controller.mapPaddingBottom),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              mapToolbarEnabled: true,
              trafficEnabled: true,
              mapType: MapType.normal,
              circles: controller.circles,
              markers: controller.markers,
              polylines: controller.polyLines,
              initialCameraPosition: googlePlex,
              onMapCreated: (GoogleMapController googleMapController) async {
                controller.googleMapController.complete(googleMapController);
                controller.rideMapController = googleMapController;
                controller.mapPaddingBottom = (Platform.isIOS) ? 255 : 260;
                var currentLatLng = LatLng(
                    currentPosition!.latitude, currentPosition!.longitude);
                var pickupLatLng = controller.tripDetails.location;
                await controller.getDirection(currentLatLng, pickupLatLng!);
                controller.getLocationUpdates();
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ),
                    )
                  ],
                ),
                height: Platform.isIOS ? 300 : 280,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          controller.durationString.value,
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Brand-Bold',
                              color: AppColors.colorAccentPurple),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                // Container(
                                //   decoration: BoxDecoration(
                                //   shape: BoxShape.circle,
                                //   color: AppColors.primary,
                                //   image: DecorationImage(image: NetworkImage('tr'))
                                // ),
                                // ),
                                Text(
                                  controller.tripDetails!.riderName!,
                                  style: Get.textTheme.headline2,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.call,
                                    color: AppColors.white,
                                  ),
                                  onPressed: () async {
                                    await launchUrl(Uri.parse(
                                        'tel:${controller.tripDetails.riderPhone}'));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
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
                                controller.tripDetails.pickupAddress!,
                                style: const TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
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
                                controller.tripDetails.destinationAddress!,
                                style: const TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TaxiButton(
                          title: controller.buttonTitle.value,
                          color: controller.buttonColor.value,
                          onPressed: () async {
                            if (controller.status.value == 'accepted') {
                              controller.status.value = 'arrived';
                              rideRef!.child('status').set(('arrived'));

                              controller.buttonTitle.value = 'START TRIP';
                              controller.buttonColor.value =
                                  AppColors.colorAccent1;

                              HelperMethods.showProgressDialog(context);
                              await controller.getDirection(
                                  controller.tripDetails.location!,
                                  controller.tripDetails.destination!);
                              Get.back();
                            } else if (controller.status.value == 'arrived') {
                              controller.status.value = 'ontrip';
                              rideRef!.child('status').set('ontrip');
                              controller.buttonTitle.value = 'END TRIP';
                              controller.buttonColor.value = Colors.red;
                              controller.startTimer();
                            } else if (controller.status.value == 'ontrip') {
                              controller.endTrip();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
