import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class MainCalendarDay extends StatefulWidget {
  const MainCalendarDay({super.key});

  @override
  State<MainCalendarDay> createState() => _MainCalendarDayState();
}



// 일간 상세일정
class _MainCalendarDayState extends State<MainCalendarDay> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 캘린더가 차지할 높이 비율 조정
      height: 500,
        child: SfCalendar(
          view: CalendarView.day,
          // 시간 표시 형식
          timeSlotViewSettings: TimeSlotViewSettings(
            timeInterval: Duration(hours: 1), timeFormat: 'a h',
            // 종일 일정 패널 배경색
            // allDayPanelColor: Colors.transparent
          ),
          // 달력 표시 형식
          scheduleViewSettings: ScheduleViewSettings(
            dayHeaderSettings: DayHeaderSettings(
              dayFormat: 'EEEE',
              width: 70
            )
          ),
          // 샘플 데이터 불러오기
          todayTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          todayHighlightColor: Colors.transparent,
          cellBorderColor: grey3,
          headerDateFormat: '000',
          // 헤더 사이즈 0으로 둬서 없애기
          headerHeight: 0,
          backgroundColor: Colors.transparent,
          ),
    );
  }
}
