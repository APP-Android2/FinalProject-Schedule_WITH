import 'package:flutter/material.dart';
import 'package:get/get.dart';


// 색상 버튼 1개
class ScheduleColorButton extends StatefulWidget {
  final Color colorName;

  const ScheduleColorButton({
    required this.colorName,
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleColorButton> createState() => _ScheduleColorButtonState();
}

class _ScheduleColorButtonState extends State<ScheduleColorButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: widget.colorName
      ),
      child: MaterialButton(
        onPressed: () {
          print('색깔버튼');
          Get.back();
        },
      ),
    );
  }
}


// 전체 색상 버튼 묶음
class ColorButtonSet extends StatefulWidget {
  const ColorButtonSet({super.key});

  @override
  State<ColorButtonSet> createState() => _ColorButtonSetState();
}

class _ColorButtonSetState extends State<ColorButtonSet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            SizedBox(width: 12, height: 24),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12, height: 12),
                  ScheduleColorButton(colorName: Color(0xFFFF9E9E)),
                  SizedBox(width: 12, height: 12),
                  ScheduleColorButton(colorName: Color(0xFFFFD39E)),
                  SizedBox(width: 12, height: 12),
                  ScheduleColorButton(colorName: Color(0xFFFFFB94)),
                  SizedBox(width: 12, height: 12)
                ]
            ),
            SizedBox(width: 12, height:12),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12, height: 12),
                  ScheduleColorButton(colorName: Color(0xFFA5FB97)),
                  SizedBox(width: 12, height: 12),
                  ScheduleColorButton(colorName: Color(0xFF9EDCFF)),
                  SizedBox(width: 12, height: 12),
                  ScheduleColorButton(colorName: Color(0xFF84A6FF)),
                  SizedBox(width: 12, height: 12)
                ]
            )
            ,        SizedBox(width: 12, height:12),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12, height: 12),
                  ScheduleColorButton(colorName: Color(0xFFC99EFF)),
                  SizedBox(width: 12, height: 12),
                  ScheduleColorButton(colorName: Color(0xFFFFB6DD)),
                  SizedBox(width: 12, height: 12),
                  ScheduleColorButton(colorName: Color(0xFFC2C2C2)),
                  SizedBox(width: 12, height: 12)
                ]
            )
          ],
      ),
    );
  }
}
