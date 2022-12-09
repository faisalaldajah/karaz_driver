// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

const int kCooldownLong_ms = 3000;
const int kCooldownShort_ms = 1200;

// ignore: must_be_immutable
class MyButtonWidget extends StatelessWidget {
  MyButtonWidget(
      {Key? key,
      required this.color,
      required this.text,
      this.onPressed,
      this.cooldown,
      this.counter,
      this.width,
      this.cooldownStarted})
      : super(key: key);

  final Color color;
  final Widget text;
  final VoidCallback? onPressed;
  final double? width;
  int? counter = 0;
  double? cooldown = 0;
  int? cooldownStarted = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width * 0.8,
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      decoration: const BoxDecoration(),
      child: TapDebouncer(
        cooldown: const Duration(milliseconds: kCooldownShort_ms),
        onTap: () async {
          startCooldownIndicator(kCooldownShort_ms);
         onPressed!();
        },
        builder: (_, TapDebouncerFunc? onTap) {
          return MaterialButton(
            elevation: 0,
            height: 60,
            onPressed: onTap,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: text,
          );
        },
      ),
    );
  }

  void incrementCounter() {
    counter! + (counter! + 1);
  }

  void startCooldownIndicator(int timeMs) {
    cooldownStarted = DateTime.now().millisecondsSinceEpoch;
    updateCooldown(timeMs);
  }

  void updateCooldown(int timeMs) {
    final int current = DateTime.now().millisecondsSinceEpoch;
    int delta = current - cooldownStarted!;
    if (delta > timeMs) {
      delta = timeMs;
    }
  }
}
