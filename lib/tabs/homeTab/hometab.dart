import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';
import 'package:karaz_driver/tabs/homeTab/homeTabController.dart';
import 'package:karaz_driver/widgets/AvailabilityButton.dart';
import 'package:karaz_driver/widgets/ConfirmSheet.dart';
import 'package:karaz_driver/widgets/PermissionLocation.dart';
import '../../globalvariabels.dart';

class HomeTabView extends GetView<HomeTabController> {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          padding: const EdgeInsets.only(top: 135),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: false,
          rotateGesturesEnabled: true,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target:
                LatLng(currentPosition!.latitude, currentPosition!.longitude),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController googleMapController) async {
            controller.completer.complete(googleMapController);
            controller.mapController = googleMapController;
          },
        ),
        Container(
          height: 135,
          width: double.infinity,
          color: AppColors.colorPrimary,
        ),
        Obx(
          () => Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AvailabilityButton(
                  title: controller.availabilityTitle.value,
                  color: controller.availabilityColor.value,
                  onPressed: () async {
                    if (await Permission
                        .locationWhenInUse.serviceStatus.isEnabled) {
                      showModalBottomSheet(
                        isDismissible: false,
                        context: context,
                        builder: (BuildContext context) => ConfirmSheet(
                          title: (!controller.isAvailable.value)
                              ? 'Go Online'.tr
                              : 'Go Offline'.tr,
                          subtitle: (!controller.isAvailable.value)
                              ? 'You are about to become available to receive trip requests'
                                  .tr
                              : 'you will stop receiving new trip requests'.tr,
                          onPressed: () {
                            if (!controller.isAvailable.value) {
                              goOnline();
                              controller.getLocationUpdates();
                              controller.availabilityColor.value =
                                  AppColors.colorRed1;
                              controller.availabilityTitle.value =
                                  'Go Offline'.tr;
                              controller.isAvailable.value = true;
                              driversIsAvailableRef
                                  .set(controller.isAvailable.value);
                              Get.back();
                            } else {
                              goOffline();
                              Get.back();
                              controller.availabilityColor.value =
                                  AppColors.colorAccent1;
                              controller.availabilityTitle.value =
                                  'Go Online'.tr;
                              controller.isAvailable.value = false;

                              driversIsAvailableRef
                                  .set(controller.isAvailable.value);
                            }
                          },
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) =>
                            const PermissionLocation(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
