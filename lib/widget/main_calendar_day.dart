import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class MainCalendarDay extends StatefulWidget {
  const MainCalendarDay({super.key});

  @override
  State<MainCalendarDay> createState() => _MainCalendarDayState();
}

// 스케줄 컨트롤러
final ScheduleController _scheduleController = Get.find<ScheduleController>();

final DateTime _jumpToTime = DateTime.now();



// 일간 상세일정
class _MainCalendarDayState extends State<MainCalendarDay> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 캘린더가 차지할 높이 비율 조정
      height: 500,
        child: SfCalendarTheme(
          data: SfCalendarThemeData(
            selectionBorderColor: mainOrange,
          ),
          child: SfCalendar(
            view: CalendarView.day,
            // 데이터 불러오기
            dataSource: _scheduleController.dataSource,
            // 시간 표시 형식
            initialSelectedDate: _jumpToTime,
            timeSlotViewSettings: TimeSlotViewSettings(
              timeInterval: Duration(hours: 1), timeFormat: 'a h',
            ),
            // 달력 표시 형식
            scheduleViewSettings: ScheduleViewSettings(
              dayHeaderSettings: DayHeaderSettings(
                dayFormat: 'EEEE',
                width: 70
              )
            ),
            todayTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            todayHighlightColor: Colors.transparent,
            cellBorderColor: grey3,
            headerDateFormat: '000',
            // 헤더 사이즈 0으로 둬서 없애기
            headerHeight: 0,
            backgroundColor: Colors.transparent,
            ),
        ),
    );
  }
}
