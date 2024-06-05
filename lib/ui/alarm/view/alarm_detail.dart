// import 'package:adoptive_calendar/adoptive_calendar.dart';
// adoptive_calendar: ^0.1.4

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/widget/bottom_sheet_text_button.dart';
import 'package:schedule_with/ui/alarm/widget/alarm_detail_text_field.dart';
import 'package:schedule_with/widget/main_alert.dart';
import 'package:schedule_with/widget/main_button.dart';
import 'package:schedule_with/widget/date_picker.dart';

import '../widget/alarm_detail_switch_button.dart';
import '../widget/select_time.dart';

class AlarmDetail extends StatefulWidget {
  const AlarmDetail({super.key});

  @override
  State<AlarmDetail> createState() => _AlarmDetailState();
}

class _AlarmDetailState extends State<AlarmDetail> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0.0,
        child: Container(
          // 바텀 시트 높이 조절
            height: MediaQuery.of(context).size.height * 0.7,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                // 바텀시트 타이틀
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 50),
                    Container(
                      alignment: Alignment.center,
                      height: 45,
                      child:
                      Text(
                        "알람 추가",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){
                      // Get.back();
                      Get.dialog(
                          barrierDismissible: false,
                          MainAlert(msg: "등록을 취소하시겠습니까?", YesMsg: "예", NoMsg: "아니요",));
                    },
                      icon: Icon(Icons.close,
                        color: grey4,
                      ),
                    ),
                  ],
                ),
                // 날짜 피커
                Column(
                  children: [
                    // 타임 픽커
                    SelectTime(),
                  ],
                ),
                AlarmDetailTextField(titleText: '타이틀', textHint: '알람',),
                BottomSheetDetailButton(titleText: '날짜', detailText: '없음', detailTextColor: grey3,
                  onTap: (){
                    Navigator.pop(context); // Close first
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (context) =>   DatePicker(
                        back_page: AlarmDetail(),
                        title: "날짜",
                      ),
                    );
                  },
                ),
                BottomSheetDetailButton(titleText: '알림음', detailText: '기본 알림음', detailTextColor: Colors.black),
                BottomSheetDetailButton(titleText: '반복', detailText: '없음', detailTextColor: grey3),
                AlarmDetailSwitchButton(titleText: '다시알림', alarmIsChecked: false,),
                AlarmDetailSwitchButton(titleText: '스케줄에 추가', alarmIsChecked: false,),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: MainButton(text: "확인", onPressed: (){}, color: mainOrange),
                ),
              ],
            )
        )
    );
  }
}




