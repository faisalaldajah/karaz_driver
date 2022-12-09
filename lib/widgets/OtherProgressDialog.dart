import 'package:flutter/material.dart';

class OtherProgressDialog extends StatelessWidget {
  final String? status;
  const OtherProgressDialog({Key? key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 100,
            child: Column(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      status!,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
