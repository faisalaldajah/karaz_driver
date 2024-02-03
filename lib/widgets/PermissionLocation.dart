import 'package:flutter/material.dart';
import 'package:karaz_driver/theme/app_colors.dart';

class PermissionLocation extends StatelessWidget {
  const PermissionLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.only(top: 300, left: 25, right: 25, bottom: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const Text(
            'تحذير',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          const Text(
            'الرجاء تفعيل تحديد الموقع',
            style: TextStyle(fontSize: 23),
          ),
          const SizedBox(height: 20),
          Image.asset('images/desticon1.png'),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.primary,
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
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
