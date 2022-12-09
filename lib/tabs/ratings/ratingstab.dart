import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/tabs/ratings/ratingsController.dart';

class RatingsTab extends GetView<RatingsController> {
  const RatingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Hello Ratings'));
  }
}
