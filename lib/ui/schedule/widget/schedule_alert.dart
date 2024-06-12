import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/login/view/login_main.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';
import 'package:schedule_with/ui/schedule/view/schedule_main.dart';

class ScheduleAlert extends StatefulWidget {
  final msg;
  final YesMsg;
  final NoMsg;

  const ScheduleAlert({super.key,
    this.msg,
    this.YesMsg,
    this.NoMsg
  });

  @override
  State<ScheduleAlert> createState() => _ScheduleAlertState();
}

class _ScheduleAlertState extends State<ScheduleAlert> {
  final ScheduleController _scheduleController = Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white.withOpacity(0),
      child:
      Column(
        children: [
          // 야매로 띄우기
          SizedBox(height: 330),
          // 질문
          Container(
            alignment: Alignment.center,
            width: 500,
            // height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Text(widget.msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          // 긍정 버튼
          Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                color: mainBrown
            ),
            child: MaterialButton(
              onPressed: () {
                // 파이어베이스에서 해당 스케줄 데이터 삭제 되어야 함
                Get.offAll(ScheduleMain());
                // 입력값 초기화
                _scheduleController.resetFields();
              },
              child: Text(widget.YesMsg,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          //버튼 사이 공간
          SizedBox(height: 12),
          //부정버튼
          Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: mainOrange
            ),
            child: MaterialButton(
              onPressed: () {
                Get.back();
              },
              child: Text(widget.NoMsg,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
