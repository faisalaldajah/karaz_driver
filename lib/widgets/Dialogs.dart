import 'package:flutter/material.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';
import 'package:karaz_driver/screens/mainPage/mainpage.dart';

class Dialogs extends StatelessWidget {
  final String? status;
  const Dialogs({Key? key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.only(top: 300, left: 25, right: 25, bottom: 180),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'انتظر حتى يتم تعبئة الرصيد في حسابك',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Image.asset(
            'images/taxi.png',
            height: 50,
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.colorAccent1,
                borderRadius: BorderRadius.circular(15)),
            child: TextButton(
              child: const Text(
                'حسنا',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  MainPage.id,
                  (route) => false,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
