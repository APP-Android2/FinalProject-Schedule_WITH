import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/entity/schedule_tbl.dart';
import 'package:schedule_with/entity/sfcalendar_custom_appointment.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';
import 'package:schedule_with/ui/schedule/widget/appointment_builder.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_edit_bottom_sheet.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class MainCalendarMonth extends StatefulWidget {
  const MainCalendarMonth({super.key});

  @override
  State<MainCalendarMonth> createState() => _MainCalendarMonthState();
}

// 월간, 주간 캘린더
class _MainCalendarMonthState extends State<MainCalendarMonth> {
  // 스케줄 컨트롤러
  final ScheduleController _scheduleController = Get.find<ScheduleController>();

  // 캘린더 컨트롤러
  final CalendarController _calendarController = CalendarController();

  // 월별 -> 일별 전환시 현재 시간으로 이동
  final DateTime _jumpToTime = DateTime.now();

  // 현재 달력 범위를 벗어나는 날짜 클릭시 테두리 색을 다르게 설정하기 위한 변수
  bool isCurrentMonth = true;
  var currentView = CalendarView.month;

  // 알람 설정 여부에 따라 스케쥴 타이틀 앞에 아이콘 표시
  var isAlarm = false;

  @override
  void initState() {
    super.initState();
    _scheduleController.onInit();
    // _scheduleController.fetchListenSchedules();
    print('캘린더 초기화');
  }

  // 선택된 셀의 날짜 확인
  void _onCalendarTap(CalendarTapDetails details) {
    // 선택한 요소의 인덱스 (0 = 헤더 , 1 = 요일 , 2 = 셀)
    var onTapElement = details.targetElement.index;
    var userSelectMonth = _calendarController.selectedDate?.month;
    var calendarMonth = _calendarController.displayDate?.month;

    // 캘린더의 셀 선택시, 스케줄 시작날짜, 마침날짜 값을 선택한 날짜로 초기화
    if (details.targetElement == CalendarElement.calendarCell) {
      _scheduleController.selectedStartDt.value =
      _calendarController.selectedDate!;
      _scheduleController.selectedEndDt.value =
      _calendarController.selectedDate!;
    } else {}
    // 캘린더 셀 선택시 현재 월인지 확인
    if (onTapElement == 2) {
      // UI 변경
      setState(() {
        if (userSelectMonth == calendarMonth) {
          isCurrentMonth = true;
        } else {
          isCurrentMonth = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return SizedBox(
            // 캘린더가 차지할 높이
            height: MediaQuery
                .of(context)
                .size
                .height * 0.70,
            // DataPicker 테마 설정 시 라이브러리 별도로 필요하여 추가해줌
            child: SfDateRangePickerTheme(
              data: SfDateRangePickerThemeData(
                backgroundColor: Colors.white,
                viewHeaderBackgroundColor: Colors.white,
                headerBackgroundColor: grey1,
              ),
              // 캘린더
              child: SfCalendar(
                // dataSource가 변경될 때 캘린더를 자동으로 업데이트
                dataSource: _scheduleController.dataSource,
                // 최초 표시형식 (월)
                view: currentView,
                initialSelectedDate: _jumpToTime,
                initialDisplayDate: _jumpToTime,
                controller: _calendarController,
                onTap: _onCalendarTap,
                // 변경 가능한 표시형식 (월, 주)
                allowedViews: const [
                  CalendarView.month,
                  CalendarView.week,
                ],
                // 배경색
                backgroundColor: Colors.white,
                // 오늘 날짜 강조색
                todayHighlightColor: Colors.transparent,
                todayTextStyle: TextStyle(color: Colors.black87),
                // 연월 고르는 버튼 활성화
                showDatePickerButton: true,
                // 오늘 날짜로 돌아가는 버튼
                showTodayButton: true,
                cellBorderColor: grey3,
                // 달력 헤더 스타일 설정
                viewHeaderStyle: ViewHeaderStyle(
                    dayTextStyle: TextStyle(color: Colors.black)),
                headerDateFormat: 'yyyy년 MM월',
                headerHeight: 50,
                headerStyle: CalendarHeaderStyle(
                    backgroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    )),
                // 특정 날짜 선택시 셀 스타일 설정
                selectionDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: isCurrentMonth ? mainOrange : Colors.transparent,
                    width: 2,
                  ),
                ),
                // month 설정
                cellEndPadding: 0,
                monthViewSettings: MonthViewSettings(
                  monthCellStyle: MonthCellStyle(
                    todayBackgroundColor: grey2
                  ),
                  numberOfWeeksInView: 6, // 달력에 나타낼 주 수
                  appointmentDisplayMode:
                  MonthAppointmentDisplayMode.appointment, // 약속 제목 표시
                  appointmentDisplayCount: 3, // 셀 하나에 약속 표시 갯수
                ),
                appointmentBuilder: buildAppointmentWidget,
                // week 설정
                timeSlotViewSettings: TimeSlotViewSettings(
                    timeRulerSize: 50,
                    timeTextStyle:
                    TextStyle(color: grey4, fontWeight: FontWeight.bold),
                    timeIntervalHeight: 100,
                    // timeIntervalWidth: 200,
                    timelineAppointmentHeight: 30,
                    timeInterval: Duration(hours: 1),
                    timeFormat: 'a h:mm',
                    minimumAppointmentDuration: Duration(hours: 1)
                ),
              ),
            ),
          );
        },
        )
      ],
    );
  }
}
