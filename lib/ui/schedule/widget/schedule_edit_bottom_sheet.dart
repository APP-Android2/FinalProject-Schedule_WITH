import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';
import 'package:schedule_with/ui/schedule/widget/bottom_sheet_detail_color_button.dart';
import 'package:schedule_with/ui/schedule/widget/bottom_sheet_detail_switch_button.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_add_bottom_sheet.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_alert.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_color_picker.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_date_picker_end_dt.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_date_picker_start_dt.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_memo.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_public_alert.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_time_picker_end_tm.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_time_picker_start_tm.dart';
import 'package:schedule_with/widget/main_two_button.dart';

import 'bottom_sheet_detail_end_date.dart';
import 'bottom_sheet_detail_end_time.dart';
import 'bottom_sheet_detail_public.dart';
import 'bottom_sheet_detail_start_date.dart';
import 'bottom_sheet_detail_start_time.dart';

// 스케쥴 추가 바텀 시트 위젯
class EditScheduleBottomSheet extends StatelessWidget {
  final ScheduleController scheduleController = Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(children: [
          // 바텀시트 제목
          BottomSheetTitle(),
          Divider(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: ListView(
                children: [
                  // 일정 타이틀
                  ScheduleMemo(
                      titleController:
                          scheduleController.titleEditingController,
                      hintText: '스케줄 타이틀을 입력해주세요.',
                      minLines: 1,
                      maxLines: 1),
                  // 시작날짜 선택 버튼
                  BottomSheetDetailStartDate(
                      titleText: '시작 날짜',
                      // 현재 날짜가 초기값으로 뜨게 함
                      detailText: '',
                      // detailText: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      detailTextColor: grey4,
                      onTap: () {
                        // scheduleController.setStartDt(true);
                        Get.back();
                        Get.bottomSheet(ScheduleDatePickerStartDt(
                          back_page: AddScheduleBottomSheet(),
                          title: '날짜',
                        ));
                      }),
                  // 마침날짜 선택 버튼
                  BottomSheetDetailEndDate(
                      titleText: '마침 날짜',
                      detailText: '',
                      detailTextColor: grey4,
                      onTap: () {
                        // scheduleController.setEndDt(true);
                        Get.back();
                        Get.bottomSheet(ScheduleDatePickerEndDt(
                          back_page: AddScheduleBottomSheet(),
                          title: '날짜',
                        ));
                      }),
                  // 시작 시간 선택 버튼
                  BottomSheetDetailStartTime(
                      titleText: '시작 시간',
                      detailText: '',
                      // detailText: DateFormat('a hh:mm').format(DateTime.now()),
                      detailTextColor: grey4,
                      onTap: () {
                        Get.back();
                        Get.bottomSheet(ScheduleTimePickerStartTm(
                            back_page: AddScheduleBottomSheet(), title: '시간'));
                      }),
                  // 마침 시간 선택 버튼
                  BottomSheetDetailEndTime(
                      titleText: '마침 시간',
                      detailText: '',
                      detailTextColor: grey4,
                      onTap: () {
                        Get.back();
                        Get.bottomSheet(ScheduleTimePickerEndTm(
                            back_page: AddScheduleBottomSheet(), title: '시간'));
                      }),
                  // 공개 여부 선택
                  BottomSheetDetailPublic(
                      titleText: '공개 여부',
                      detailText: RxString(scheduleController.public.value),
                      detailTextColor: grey4,
                      onTap: () {
                        Get.dialog(
                            barrierDismissible: false,
                            SchedulePublicAlert(
                                msg: "공개여부 설정",
                                showAll: "전체공개",
                                showTitle: "일부공개",
                                showNothing: "비공개"));
                      }),
                  // 색상 선택
                  BottomSheetDetailColorButton(
                      titleText: '색상',
                      detailColor: scheduleController.color,
                      onTap: () {
                        Get.dialog(
                            barrierDismissible: false,
                            ScheduleColorPicker(msg: "색상"));
                      }),
                  // 스위치 버튼
                  BottomSheetDetailSwitchButton(
                    titleText: '알람에 추가',
                    onTap: () {
                      scheduleController.isAlarm.toggle();
                      // 추후 알람에 추가되는 로직 넣어야 됨
                    },
                  ),
                  // 메모 입력
                  ScheduleMemo(
                      titleController:
                          scheduleController.contentEditingController,
                      hintText: '추가 메모 사항이 있으시다면 입력해 주세요.',
                      minLines: 3,
                      maxLines: 5),
                  // 삭제하기, 수정하기 버튼
                  MainTwoButton(
                      leftText: '삭제 하기',
                      leftColor: mainBrown,
                      leftOnPressed: () {
                        Get.dialog(
                            ScheduleAlert(msg: '삭제 시 복구 되지 않습니다', NoMsg: '삭제취소', YesMsg: '삭제'));
                      },
                      rightText: '수정 완료',
                      rightColor: mainOrange,
                      rightOnPressed: () {
                        // 파이어베이스 데이터 수정 하는 코드 드가야됨
                        Get.back();
                        Get.snackbar(
                            '수정 완료',
                            '스케줄이 수정 되었습니다',
                            duration: Duration(seconds: 1));
                      }),
                ],
              ),
            ),
          )
        ]));
  }
}

// 바텀 시트 제목 설정
class BottomSheetTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.only(top: 10),
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.close),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '스케줄 수정',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 40),
      ],
    );
  }
}