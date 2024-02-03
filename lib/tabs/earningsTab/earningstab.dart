import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:karaz_driver/theme/app_colors.dart';
import 'package:karaz_driver/screens/history/historypage.dart';
import 'package:karaz_driver/tabs/earningsTab/EarningsController.dart';
import 'package:karaz_driver/widgets/BrandDivier.dart';
import '../../dataprovider.dart';

class EarningsView extends GetView<EarningsController> {
  const EarningsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.primary,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 70, bottom: 30),
            child: Column(
              children: [
                Text(
                  'Total Earnings'.tr,
                  style: Get.textTheme.displayLarge!
                      .copyWith(color: AppColors.white, fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'JD ${Provider.of<AppData>(context).earnings}',
                  style: Get.textTheme.displayLarge!
                      .copyWith(color: AppColors.white, fontSize: 40),
                )
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HistoryPage()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            child: Row(
              children: [
                Image.asset(
                  'images/taxi.png',
                  width: 70,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Trips',
                  style: Get.textTheme.headlineMedium,
                ),
                Expanded(
                    child: Text(
                  Provider.of<AppData>(context).tripCount.toString(),
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontSize: 18),
                )),
              ],
            ),
          ),
        ),
        const BrandDivider(),
      ],
    );
  }
}
