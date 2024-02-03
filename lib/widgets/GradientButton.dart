import 'package:flutter/material.dart';
import 'package:karaz_driver/theme/app_colors.dart';

class GradientButton extends StatelessWidget {
  final String? title;
  final VoidCallback onPressed;

  const GradientButton({Key? key, this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // ignore: prefer_const_literals_to_create_immutables
            colors: [
              AppColors.primary,
              AppColors.primary,
            ]),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title!,
          style: const TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }
}
