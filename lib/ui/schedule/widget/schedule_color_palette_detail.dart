import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';

// color picker 내 색깔 버튼
class ScheduleColorPaletteDetail extends StatelessWidget {
  final Color colorName;
  final ScheduleController scheduleController = Get.find<ScheduleController>();

  ScheduleColorPaletteDetail({
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
        color: colorName,
      ),
      child: MaterialButton(
        onPressed: () {
          scheduleController.color.value = colorName;
          Get.back();
        },
      ),
    );
  }
}
