import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MainCalendarMonth extends StatefulWidget{
  const MainCalendarMonth({super.key});

  @override
  State<MainCalendarMonth> createState() => _MainCalendarMonthState();
}

// 월간, 주간 캘린더
class _MainCalendarMonthState extends State<MainCalendarMonth> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // 캘린더가 차지할 높이 비율 조정
        height: MediaQuery.of(context).size.height * 0.6,
        child: SfCalendar(
          // 최초 표시형식 (월)
            view: CalendarView.month,
            // 배경
            backgroundColor: Colors.white,
            // 오늘 날짜 강조색
            todayHighlightColor: grey3,
            // 연월 고르는 버튼 활성화
            showDatePickerButton: true,
            // 오늘 날짜로 돌아가는 버튼
            showTodayButton: true,
            // 달력 헤더 스타일 설정
            headerDateFormat: 'yyyy년 MM월',
            headerStyle: const CalendarHeaderStyle(
                backgroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 14,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                )
            ),
            // 변경가능한 표시형식 (월, 주)
            allowedViews: const [
              CalendarView.month,
              CalendarView.week,
            ],

        )
    );
  }
}