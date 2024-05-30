import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../assets/color/color.dart';
// import '../domain/repository/sample_data.dart';

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
          scheduleViewSettings: ScheduleViewSettings(
            dayHeaderSettings: DayHeaderSettings(
              dayFormat: 'EEEE',
              width: 70
            )
          ),
          view: CalendarView.day,
          // 샘플 데이터 불러오기
          // dataSource: getDataSource(),
          todayTextStyle: TextStyle(color: Colors.white),
          todayHighlightColor: mainOrange,
          cellBorderColor: grey3,
          headerDateFormat: '000',
          // 헤더 사이즈 0으로 둬서 없애기
          headerHeight: 0,
          backgroundColor: Colors.transparent,
          ),
    );
  }
}
