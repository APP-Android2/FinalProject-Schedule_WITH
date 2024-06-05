import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';
import 'package:schedule_with/ui/schedule/widget/bottom_sheet_detail_color_button.dart';
import 'package:schedule_with/ui/schedule/widget/bottom_sheet_detail_switch_button.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_alert.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_color_picker.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_memo.dart';
import 'package:schedule_with/widget/bottom_sheet_detail_button.dart';
import 'package:schedule_with/widget/date_picker.dart';
import 'package:schedule_with/widget/main_alert.dart';
import 'package:schedule_with/widget/main_two_button.dart';
import 'package:schedule_with/widget/time_picker.dart';

// 스케쥴 추가 바텀 시트 위젯
class AddScheduleBottomSheet extends StatelessWidget {
  final ScheduleController scheduleController = Get.put(ScheduleController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
          height: MediaQuery.of(context).size.height* 0.75,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(children: [
            // 바텀시트 제목
            BottomSheetTitle(),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(children: [
                  // 타이틀 입력부분
                  ScheduleMemo(
                    titleController: _titleController,
                    hintText: '스케줄 타이틀을 입력해주세요.'),
                  // 시작날짜 선택 버튼
                  BottomSheetDetailTextButton(
                      titleText: '시작 날짜',
                      detailText: RxString(DateFormat('yyyy-MM-dd').format(scheduleController.selectedDateTime.value)),
                      detailTextColor: grey4,
                      onTap: () {
                        Get.back(); // Close first
                        Get.bottomSheet(DatePicker(
                          back_page: AddScheduleBottomSheet(),
                          title: '날짜',
                        ));
                      }),
                  // 마침날짜 선택 버튼
                  BottomSheetDetailTextButton(
                      titleText: '마침 날짜',
                      detailText: scheduleController.selectedDateTime,
                      detailTextColor: grey4,
                      onTap: () {
                        // scheduleController.test('gsd');
                        Get.back(); // Close first
                        Get.bottomSheet(DatePicker(
                          back_page: AddScheduleBottomSheet(),
                          title: '날짜',
                        ));
                      }),
                  // 시작 시간 선택 버튼
                  BottomSheetDetailTextButton(
                      titleText: '시작 시간',
                      detailText: scheduleController.selectedDateTime,
                      detailTextColor: grey4,
                      onTap: () {
                        // scheduleController.test('gsd');
                        Get.back();
                        Get.bottomSheet(TimePicker(
                            back_page: AddScheduleBottomSheet(), title: '시간'));
                      }),
                  // 마침 시간 선택 버튼
                  BottomSheetDetailTextButton(
                      titleText: '마침 시간',
                      detailText: scheduleController.selectedDateTime,
                      detailTextColor: grey4,
                      onTap: () {
                        Get.back();
                        Get.bottomSheet(TimePicker(
                            back_page: AddScheduleBottomSheet(), title: '시간'));
                      }),
                  // 공개 여부 선택
                  BottomSheetDetailTextButton(
                      titleText: '공개 여부',
                      detailTextColor: grey4,
                      detailText: scheduleController.visibility,
                      onTap: () {
                        Get.dialog(
                            barrierDismissible: false,
                            ScheduleAlert(
                                msg: "공개여부 설정",
                                showAll: "전체공개",
                                showTitle: "일부공개",
                                showNothing: "비공개"));
                      }),
                  // 색상 선택
                  BottomSheetDetailColorButton(
                      titleText: '색상',
                      detailColor: scheduleController.selectedColor,
                      onTap: () {
                        Get.dialog(
                            barrierDismissible: false,
                            ScheduleColorPicker(msg: "색상"));
                      }),
                  // 스위치 버튼
                  BottomSheetDetailSwitchButton(titleText: '알람에 추가'),
                  // 메모 입력
                  ScheduleMemo(
                    titleController: _contentController,
                    hintText: '추가 메모 사항이 있으시다면 입력해 주세요.'),

                ])
            ),
            Spacer(),
            // 삭제하기, 수정하기 버튼
            MainTwoButton(
                leftText: '삭제 하기',
                leftColor: mainBrown,
                leftOnPressed: () {
                  Get.dialog(
                      MainAlert(msg:'일정을 삭제하시겠습니까?', YesMsg:'예', NoMsg: '아니오'));
                },
                rightText: '수정 완료',
                rightColor: mainOrange,
                rightOnPressed: () {
                  Get.dialog(
                      MainAlert(msg:'수정사항을 취소하시겠습니까?', YesMsg:'예', NoMsg: '아니오'));
                }),

          ])),
    );
  }
}

// 바텀 시트 제목 설정
class BottomSheetTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 50),
        Container(
          alignment: Alignment.center,
          height: 45,
          child:
          Text(
            "스케줄 추가",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.close),
        ),
      ],
    );
  }
}
