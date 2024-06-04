import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';

class PaySettlementStatus extends StatefulWidget {
  final bool isComplete;
  final Function(bool) onStatusChanged;

  const PaySettlementStatus({Key? key, required this.isComplete, required this.onStatusChanged}) : super(key: key);

  @override
  _PaySettlementStatusState createState() => _PaySettlementStatusState();
}

class _PaySettlementStatusState extends State<PaySettlementStatus> {
  late bool _isComplete;

  @override
  void initState() {
    super.initState();
    _isComplete = widget.isComplete;
  }

  void _payupdateStatus(bool isComplete) {
    setState(() {
      _isComplete = isComplete;
      widget.onStatusChanged(isComplete);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
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
                        onTap: () => _payupdateStatus(false),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                              height: 10,
                              child: Radio<bool>(
                                value: false,
                                groupValue: _isComplete,
                                onChanged: (value) => _payupdateStatus(value ?? false),
                                activeColor: mainBrown,
                                fillColor: MaterialStateProperty.resolveWith<Color>(
                                      (states) => states.contains(MaterialState.selected) ? mainBrown : mainBrown.withOpacity(1),
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
                        onTap: () => _payupdateStatus(true),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                              height: 10,
                              child: Radio<bool>(
                                value: true,
                                groupValue: _isComplete,
                                onChanged: (value) => _payupdateStatus(value ?? true),
                                activeColor: mainOrange,
                                fillColor: MaterialStateProperty.resolveWith<Color>(
                                      (states) => states.contains(MaterialState.selected) ? mainOrange : mainOrange.withOpacity(0.5),
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