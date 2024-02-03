import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/theme/app_colors.dart';
import 'package:karaz_driver/globalvariabels.dart';
import 'package:karaz_driver/screens/wallet/walletController.dart';
import 'package:karaz_driver/widgets/Dialogs.dart';
import 'package:karaz_driver/widgets/GradientButton.dart';

class AmountDetail extends GetView<WalletController> {
  AmountDetail({Key? key, required this.amount}) : super(key: key);
  final String amount;

  final TextEditingController transNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 90,
              width: double.infinity,
            ),
            const Text(
              'قم بتعبئة رقم الحوالة حتى يتم تعبئة الرصيد',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(40),
              child: TextField(
                controller: transNumberController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: 'رقم الحوالة',
                    labelStyle: TextStyle(
                      fontSize: 14.0,
                    ),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'في حال لم يتم تعبئة الرصيد خلال 12 ساعة يحق لك المطالبة بالمبلغ الذي حولته على نفس الرقم',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),
            GradientButton(
              title: 'تأكيد',
              onPressed: addAmount,
            )
          ],
        ),
      ),
    );
  }

  void addAmount() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) => const Dialogs(),
    );
    if (transNumberController.text.length < 5) {
      //showSnackBar('Please provide a valid number');
      return;
    } else {
      DatabaseReference amountRef = FirebaseDatabase.instance
          .ref()
          .child('drivers/${currentFirebaseUser!.uid}/amount');
      Map userAmount = {
        'transNumber': transNumberController.text,
        'amount': amount,
        'status': 'not approved'
      };

      amountRef.set(userAmount);
    }
  }
}
