import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karaz_driver/Utilities/general.dart';
import 'package:karaz_driver/widgets/primary_button/primary_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:karaz_driver/theme/app_colors.dart';
import 'package:karaz_driver/tabs/homeTab/homeTabController.dart';
import 'package:karaz_driver/widgets/PermissionLocation.dart';

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
            target: LatLng(cureentAddress.value.latitude!,
                cureentAddress.value.longitude!),
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
          color: AppColors.defaultBlack,
        ),
        Obx(
          () => Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryButton(
                title: controller.availabilityTitle.value,
                backgroundColor: controller.availabilityColor.value,
                onTap: () async {
                  if (await Permission
                      .locationWhenInUse.serviceStatus.isEnabled) {
                    controller.enableLocation();
                  } else {
                    showDialog(
                      context: Get.context!,
                      barrierDismissible: false,
                      builder: (BuildContext context) =>
                          const PermissionLocation(),
                    );
                  }
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
