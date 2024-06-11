import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_edit_bottom_sheet.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class MainCalendarDay extends StatefulWidget {
  const MainCalendarDay({super.key});

  @override
  State<MainCalendarDay> createState() => _MainCalendarDayState();
}

// 일간 상세일정
class _MainCalendarDayState extends State<MainCalendarDay> {
  var isCurrentMonth;

  // 스케줄 컨트롤러
  final ScheduleController _scheduleController = Get.find<ScheduleController>();

  // 캘린더 컨트롤러
  final CalendarController _calendarController = CalendarController();

  final DateTime _jumpToTime = DateTime.now();

// 선택된 셀의 날짜 확인
  void _onCalendarTap(CalendarTapDetails details) {
    var todayAppoint = details.appointments?.isNotEmpty ?? false;
    // 선택한 요소의 인덱스 (0 = 헤더 , 1 = 요일 , 2 = 셀)

    // 테스트
    print(details.targetElement);

    // 약속 있으면 스케줄 수정 바텀시트 띄움
    if (todayAppoint == true) {
      showModalBottomSheet(
          // 바텀 시트 높이 지정하려면 isScrollControlled: true,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return EditScheduleBottomSheet();
          });
    } else {
      // 약속이 없을 때의 동작 추가 (필요한 경우)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        // 캘린더가 차지할 높이 비율 조정
        height: 500,
        child: SfCalendarTheme(
          // 스타일 설정
          data: SfCalendarThemeData(
            timeIndicatorTextStyle: TextStyle(color: mainBrown),
            selectionBorderColor: mainOrange,
          ),
          // 월 달력 세팅
          child: SfCalendar(
            onTap: _onCalendarTap,
            // 달력 표시형식
            view: CalendarView.day,
            // 데이터 불러오기
            dataSource: _scheduleController.dataSource,
            // 약속 텍스트 설정
            appointmentTextStyle: TextStyle(color: mainBrown, ),
            allowDragAndDrop: true,
            // 현재 시간 으로 이동
            initialSelectedDate: _jumpToTime,
            // 헤더 설정
            headerDateFormat: '000',
            // 헤더 사이즈 0으로 둬서 없애기
            headerHeight: 0,
            // 색깔 설정
            cellBorderColor: grey3,
            backgroundColor: Colors.transparent,
            todayHighlightColor: Colors.transparent,
            todayTextStyle: TextStyle(color: Colors.black),
            // 타임 슬롯
            timeZone: 'Asia/Seoul',
            timeSlotViewSettings: TimeSlotViewSettings(
              timeIntervalHeight: 50,
                timeInterval: Duration(hours: 1),
                timeFormat: 'a h:mm',
                // 최소 기간일 때 약속높이 임의 설정
                minimumAppointmentDuration: Duration(hours: 1)),
            // 달력 표시 형식
            scheduleViewSettings: ScheduleViewSettings(
              dayHeaderSettings:
                  DayHeaderSettings(dayFormat: 'EEEE', width: 70),
            ),
          ),
        ),
      );
    });
  }
}
