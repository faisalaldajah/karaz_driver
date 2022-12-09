import 'package:flutter/material.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';
import 'package:karaz_driver/datamodels/history.dart';
import 'package:karaz_driver/helpers/helpermethods.dart';

class HistoryTile extends StatelessWidget {
  final History? history;
  const HistoryTile({Key? key, this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/pickicon.png',
                    height: 16,
                    width: 16,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Expanded(
                      child: Text(
                    history!.historyTripDetail!.pickUpAddress!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'JD ${history!.historyTripDetail!.price}',
                    style: const TextStyle(
                      fontFamily: 'Brand-Bold',
                      fontSize: 16,
                      color: AppColors.colorPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.asset(
                    'images/desticon.png',
                    height: 16,
                    width: 16,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    history!.historyTripDetail!.destinationAddress!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                HelperMethods.formatMyDate(history!.historyTripDetail!.time!),
                style: const TextStyle(color: AppColors.colorTextLight),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
