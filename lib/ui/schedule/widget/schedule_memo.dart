import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';

class ScheduleMemo extends StatelessWidget {
  final TextEditingController titleController;
  final String hintText;

  const ScheduleMemo({
    Key? key,
    required this.titleController,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: grey2))),
        child: TextField(
          controller: titleController,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 16, color: grey3),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
