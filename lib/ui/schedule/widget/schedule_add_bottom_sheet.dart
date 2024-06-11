import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';
import 'package:schedule_with/ui/schedule/widget/bottom_sheet_detail_color_button.dart';
import 'package:schedule_with/ui/schedule/widget/bottom_sheet_detail_end_time.dart';
import 'package:schedule_with/ui/schedule/widget/bottom_sheet_detail_public.dart';
import 'package:schedule_with/ui/schedule/widget/bottom_sheet_detail_start_date.dart';
import 'package:schedule_with/ui/schedule/widget/bottom_sheet_detail_start_time.dart';
import 'package:schedule_with/ui/schedule/widget/bottom_sheet_detail_switch_button.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_alert.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_color_picker.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_date_picker_end_dt.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_date_picker_start_dt.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_memo.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_public_alert.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_time_picker_end_tm.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_time_picker_start_tm.dart';
import 'package:schedule_with/widget/main_button.dart';

import 'bottom_sheet_detail_end_date.dart';

// 스케쥴 추가 바텀 시트 위젯
class AddScheduleBottomSheet extends StatelessWidget {
  // 컨트롤러 사용 선언
  final ScheduleController scheduleController = Get.find<ScheduleController>();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  // 시작날짜 변경 여부 확인
  var isStartDt = false;
  // 종료날짜 변경 여부 확인
  var isEndDt = false;

  @override
  Widget build(BuildContext context) {


    return Obx(() {
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
            Divider(),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(children: [
                  // 일정 타이틀
                  ScheduleMemo(
                    titleController: scheduleController.titleEditingController,
                    hintText: '스케줄 타이틀을 입력해주세요.', minLines: 1, maxLines: 1),
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

                    },
                  ),
                  // 메모 입력
                  ScheduleMemo(
                    titleController: scheduleController.contentEditingController,
                    hintText: '추가 메모 사항이 있으시다면 입력해 주세요.', minLines: 3, maxLines: 5),
                ])
            ),
            Spacer(),
            // 등록하기 버튼
            Container(
              // 버튼 양옆 여백
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: MainButton(
                  text: '등록하기',
                  onPressed: () {

                    print('${scheduleController.selectedStartDt.value}, 시작날짜');
                    print('${scheduleController.selectedEndDt.value}, 종료날짜');
                    print('${scheduleController.selectedStartTm.value}, 시작시간');
                    print('${scheduleController.selectedEndTm.value}, 종료시간');



                    // 추후 알람에 추가되는 로직 넣어야 됨

                    // 입력받은 데이터를 Entity 저장
                    scheduleController.addSchedule();
                    Get.back();
                    Get.snackbar(
                        '등록 완료',
                        '스케줄이 등록되었습니다',
                        duration: Duration(seconds: 1),
                    // snackPosition: SnackPosition.BOTTOM
                    );
                    // 필드 초기화
                    scheduleController.resetFields();

                  },
                  color: mainOrange),

            ),
            Padding(padding: EdgeInsets.only(bottom: 30))
          ])),
    );
    });
  }
}

// 바텀 시트 제목 설정
class BottomSheetTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 45,
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          // leading 빈공간 여백
          SizedBox(width: 50),
          Container(
            alignment: Alignment.center,
            height: 45,
            child: Text(
              "스케줄 추가",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.dialog(ScheduleAlert(
                  msg: '작성을 취소하시겠습니까?', YesMsg: '예', NoMsg: "아니오"));
            },
            icon: Icon(Icons.close),
          ),
        ]));
  }
}