import 'package:flutter/material.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';
import 'package:karaz_driver/screens/wallet/AmountDetail.dart';

class AddAmount extends StatelessWidget {
  const AddAmount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorAccent1,
        title: const Center(
          child: Text('إختر الحزمة التي تريد'),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'اختر المبلغ الذي تريد تحويله',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                const Text(
                  '5 , 10 , 15 , 20',
                  style: TextStyle(fontSize: 22),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'أولا عليك أن تقوم بتحويل المبلغ المراد شحنه الى محفظة زين كاش التي تحمل رقم ',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '0796829494',
                  style: TextStyle(fontSize: 22),
                ),
                const Text(
                  'او محفظه دينارك على الرقم',
                  style: TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 10),
                const Text(
                  '0780367070',
                  style: TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'ثانيا سوف تأتيك رسالة تحتوي على رقم للحوالة',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'إختر الحزمة التي تريدها في الاسفل',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                PriceBtn(
                  cardPrice: '5',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AmountDetail(
                          amount: '5',
                        ),
                      ),
                    );
                  },
                ),
                PriceBtn(
                  cardPrice: '10',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AmountDetail(
                          amount: '10',
                        ),
                      ),
                    );
                  },
                ),
                PriceBtn(
                  cardPrice: '15',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AmountDetail(
                          amount: '15',
                        ),
                      ),
                    );
                  },
                ),
                PriceBtn(
                  cardPrice: '20',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AmountDetail(
                          amount: '20',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PriceBtn extends StatelessWidget {
  const PriceBtn({Key? key, this.cardPrice, required this.onPressed})
      : super(key: key);
  final String? cardPrice;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorBackground,
        borderRadius: BorderRadius.circular(10),
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          const BoxShadow(
            blurRadius: 2,
            spreadRadius: 0.3,
            color: AppColors.colorLightGray,
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 30),
      width: 190,
      height: 130,
      child: Center(
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: AppColors.colorBackground,
            borderRadius: BorderRadius.circular(90),
            border: Border.all(width: 3, color: AppColors.colorAccent),
          ),
          child: Center(
            child: TextButton(
              onPressed: () => onPressed,
              child: Text(
                '$cardPrice JD',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
