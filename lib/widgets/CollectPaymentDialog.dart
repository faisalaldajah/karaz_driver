// ignore_for_file: file_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/theme/app_colors.dart';
import 'package:karaz_driver/globalvariabels.dart';
import 'package:karaz_driver/widgets/BrandDivier.dart';
import 'package:karaz_driver/widgets/TaxiButton.dart';

class CollectPayment extends StatelessWidget {
  final String? paymentMethod;
  final int? fares;

  CollectPayment({this.paymentMethod, this.fares});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Text('${paymentMethod!.toUpperCase()} PAYMENT'),
            const SizedBox(
              height: 20,
            ),
            const BrandDivider(),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              '$fares JD',
              style: const TextStyle(fontFamily: 'Brand-Bold', fontSize: 50),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Amount above is the total fares to be charged to the rider',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 230,
              child: TaxiButton(
                title: (paymentMethod == 'cash') ? 'COLLECT CASH' : 'CONFIRM',
                color: AppColors.success,
                onPressed: () {
                  Get.back();
                  Get.back();
                  goOnline();
                },
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
