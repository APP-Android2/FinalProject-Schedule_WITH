import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';


// 바텀 시트에 보이도록 할 색상
class DisplayColor extends StatelessWidget {
  final ScheduleController scheduleController = Get.find<ScheduleController>();
  final Color colorName;

  DisplayColor({
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
          color: colorName
      ),
    );
  }
}

// 색상 선택 다이얼로그에 표시할 색상 버튼
class ColorOption extends StatelessWidget {
  final ScheduleController scheduleController = Get.find<ScheduleController>();
  final Color colorName;

  ColorOption({
    required this.colorName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: colorName
      ),
      child: MaterialButton(
        onPressed: () {
          scheduleController.settingColor(colorName);
          Get.back();
        },
      ),
    );
  }
}


// 전체 색상 버튼 묶음
class ColorButtonSet extends StatelessWidget {
  const ColorButtonSet({super.key});

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
                  ColorOption(colorName: Color(0xFFFF9E9E)),
                  SizedBox(width: 12, height: 12),
                  ColorOption(colorName: Color(0xFFFFD39E)),
                  SizedBox(width: 12, height: 12),
                  ColorOption(colorName: Color(0xFFFFFB94)),
                  SizedBox(width: 12, height: 12)
                ]
            ),
            SizedBox(width: 12, height:12),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12, height: 12),
                  ColorOption(colorName: Color(0xFFA5FB97)),
                  SizedBox(width: 12, height: 12),
                  ColorOption(colorName: Color(0xFF9EDCFF)),
                  SizedBox(width: 12, height: 12),
                  ColorOption(colorName: Color(0xFF84A6FF)),
                  SizedBox(width: 12, height: 12)
                ]
            )
            ,        SizedBox(width: 12, height:12),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12, height: 12),
                  ColorOption(colorName: Color(0xFFC99EFF)),
                  SizedBox(width: 12, height: 12),
                  ColorOption(colorName: Color(0xFFFFB6DD)),
                  SizedBox(width: 12, height: 12),
                  ColorOption(colorName: Color(0xFFC2C2C2)),
                  SizedBox(width: 12, height: 12)
                ]
            )
          ],
      ),
    );
  }
}