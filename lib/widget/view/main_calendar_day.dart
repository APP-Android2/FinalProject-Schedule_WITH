import 'package:flutter/material.dart';
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
        height: MediaQuery.of(context).size.height * 0.4,
        child: SfCalendar(
            view: CalendarView.day
        )
    );
  }
}
