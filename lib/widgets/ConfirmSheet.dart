import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/theme/app_colors.dart';
import 'package:karaz_driver/widgets/TaxiButton.dart';

class ConfirmSheet extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final VoidCallback onPressed;

  const ConfirmSheet(
      {Key? key, this.title, this.subtitle, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15.0, // soften the shadow
            spreadRadius: 0.5, //extend the shadow
            offset: Offset(
              0.7, // Move to right 10  horizontally
              0.7, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      height: 220,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 22,
                  fontFamily: 'Brand-Bold',
                  color: AppColors.primaryBG),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.primaryBG),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TaxiButton(
                    title: 'back'.tr,
                    color: AppColors.primaryBG,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TaxiButton(
                    onPressed: onPressed,
                    color: AppColors.black,
                    title: 'confirm'.tr,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
