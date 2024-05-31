import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';

class PayTitleField extends StatelessWidget {
  final TextEditingController titleController;

  const PayTitleField({Key? key, required this.titleController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: grey2))),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text('타이틀', style: TextStyle(fontSize: 14)),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: titleController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: '제목을 입력해 주세요.',
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