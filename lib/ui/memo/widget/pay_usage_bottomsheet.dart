import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/widget/main_two_button.dart';

class BottomSheetWidget extends StatefulWidget {
  final Function(String usage, String cost, bool isAddition) onAdd;

  BottomSheetWidget({Key? key, required this.onAdd}) : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  TextEditingController usageController = TextEditingController();
  TextEditingController costController = TextEditingController();
  String transactionType = "expense";

  bool fieldsAreEmpty() {
    return usageController.text.isEmpty && costController.text.isEmpty;
  }

  void _addTransaction(bool isIncome) {
    String sign = isIncome ? "" : "-";
    transactionType = isIncome ? "income" : "expense";
    widget.onAdd(usageController.text, sign + costController.text, isIncome);
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          height: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: grey4,),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text('사용 내역', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(width: 48),
                ],
              ),
              UsageAddField(usageAddFieldController: usageController),
              CostFieldUnderline(costController: costController),
              Spacer(flex: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: MainTwoButton(
                  leftText: '+ 수입내역', leftColor: mainBrown, leftOnPressed: () => _addTransaction(true),
                  rightText: '- 사용내역', rightColor: mainOrange, rightOnPressed: () => _addTransaction(false),
                ),
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class CostFieldUnderline extends StatelessWidget {
  final TextEditingController costController;

  const CostFieldUnderline({Key? key, required this.costController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: grey2))),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text('금액', style: TextStyle(fontSize: 14)),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: costController,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: '금액을 입력해 주세요.',
                  hintStyle: TextStyle(fontSize: 14, color: grey3),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UsageAddField extends StatefulWidget {
  final TextEditingController usageAddFieldController;

  const UsageAddField({Key? key, required this.usageAddFieldController}) : super(key: key);

  @override
  _UsageAddFieldState createState() => _UsageAddFieldState();
}

class _UsageAddFieldState extends State<UsageAddField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: grey2)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text('내역', style: TextStyle(fontSize: 14)),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: widget.usageAddFieldController,
                textAlign: TextAlign.right,
                style: TextStyle(decorationThickness: 0),
                decoration: InputDecoration(
                  hintText: '내역을 입력해 주세요.',
                  hintStyle: TextStyle(fontSize: 14, color: grey3),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

