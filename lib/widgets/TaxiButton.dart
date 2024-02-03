import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/Utilities/fonts.dart';
import 'package:karaz_driver/theme/app_colors.dart';

class TaxiButton extends StatelessWidget {
  final String? title;
  final Color? color;
  final VoidCallback onPressed;

  const TaxiButton({Key? key, this.title, required this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            title!,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: AppFonts.jfFlat,
              color: AppColors.defaultBlack,
            ),
          ),
        ),
      ),
    );
  }
}
