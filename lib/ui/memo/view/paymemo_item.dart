import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/assets/colors/color.dart';

import '../../../entity/paymemo_tbl.dart';

class PayMemoProvider with ChangeNotifier {
  PayMemo _payMemo;

  PayMemoProvider(this._payMemo);

  PayMemo get payMemo => _payMemo;

  void toggleCompleted() {
    _payMemo.isCompleted = !_payMemo.isCompleted;
    notifyListeners();
  }
}

class PayMemoItem extends StatelessWidget {
  final PayMemo paymemo;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const PayMemoItem({
    Key? key,
    required this.paymemo,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: paymemo,
        builder: (context, _) {
          Color statusColor = paymemo.isCompleted ? mainOrange : mainBrown;
          List<String> amounts = paymemo.amount.split(' | ');
          String totalAmount = amounts[0];
          String personalAmount = amounts[1];

          return Container(
            padding: EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormat('yyyy-MM-dd').format(paymemo.mod_dt), style: TextStyle(fontSize: 10, color: grey4)),
                          Text(paymemo.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -5),
                    child: Container(
                      width: 60,
                      height: 20,
                      decoration: BoxDecoration(
                        color: paymemo.isCompleted ? mainOrange : mainBrown,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: statusColor, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          paymemo.isCompleted ? '정산완료' : '정산중',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            height: 1.0,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('금액', style: TextStyle(fontSize: 12)),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "$totalAmount",
                                style: TextStyle(color: grey4, fontSize: 12),
                              ),
                              TextSpan(
                                text: " | $personalAmount",
                                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

