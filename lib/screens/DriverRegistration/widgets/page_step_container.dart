import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageStepContainer extends StatelessWidget {
  final int? step, currentStep;
  const PageStepContainer({Key? key, this.step, this.currentStep})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: step == currentStep ? Get.theme.focusColor : Colors.grey,
      ),
      child: Center(
        child: Text(
          step.toString(),
          style: TextStyle(
              color: step == currentStep ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
