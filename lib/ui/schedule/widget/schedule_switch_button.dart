import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';

class ScheduleSwitchButton extends StatefulWidget {

  ScheduleSwitchButton({Key? key}) : super(key: key);

  @override
  State<ScheduleSwitchButton> createState() => _ScheduleSwitchButtonState();
}

class _ScheduleSwitchButtonState extends State<ScheduleSwitchButton> {

  final ScheduleController scheduleController = Get.find<ScheduleController>();

  bool _value = false; // 1. value 변수 정의

  @override
  void initState() {
    super.initState();
    // alarmStatus 값 확인하여 스위치 온오프 초기 설정
    scheduleController.alarmStatus.value ? _value = true : _value = false;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: _value, // value 변수 사용
      onChanged: (newValue) {
        setState(() {
          _value = newValue; // onChanged 콜백에서 value 업데이트
        });
      },
      activeColor: mainOrange, // 사용할 색상 가져오기
    );
  }
}