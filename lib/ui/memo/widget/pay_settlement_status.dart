import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schedule_with/assets/color/color.dart';

class PaySettlementStatus extends StatefulWidget {
  const PaySettlementStatus({Key? key}) : super(key: key);

  @override
  _PaySettlementStatusState createState() => _PaySettlementStatusState();
}

class _PaySettlementStatusState extends State<PaySettlementStatus> {
  String _settlementStatus = 'processing';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
               border: Border(bottom: BorderSide(color: grey2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("정산 상태", style: TextStyle(fontSize: 14)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _settlementStatus = 'processing';
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                              height: 10,
                              child: Radio<String>(
                                value: 'processing',
                                groupValue: _settlementStatus,
                                onChanged: (value) {
                                  setState(() {
                                    _settlementStatus = value ?? 'processing';
                                  });
                                },
                                activeColor: mainBrown,
                                fillColor: MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                    if (states.contains(MaterialState.selected)) {
                                      return mainBrown;
                                    }
                                    return mainBrown.withOpacity(1);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("정산중", style: TextStyle(color: mainBrown, fontSize: 14)),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _settlementStatus = 'completed';
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                              height: 10,
                              child: Radio<String>(
                                value: 'completed',
                                groupValue: _settlementStatus,
                                onChanged: (value) {
                                  setState(() {
                                    _settlementStatus = value ?? 'completed';
                                  });
                                },
                                activeColor: mainOrange,
                                fillColor: MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                    if (states.contains(MaterialState.selected)) {
                                      return mainOrange;
                                    }
                                    return mainOrange.withOpacity(0.5);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("정산 완료", style: TextStyle(color: mainOrange, fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
