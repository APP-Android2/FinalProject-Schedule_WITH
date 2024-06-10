import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';


// 바텀 시트에 보이도록 할 색상
class UserSelectedColor extends StatelessWidget {
  final Color colorName;

  UserSelectedColor({
    required this.colorName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: colorName,
      ),
    );
  }
}
