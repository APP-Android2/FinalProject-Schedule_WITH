import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../domain/repository/sample_data.dart';

class MainCalendarMonth extends StatefulWidget {
  const MainCalendarMonth({super.key});

  @override
  State<MainCalendarMonth> createState() => _MainCalendarMonthState();
}

// 월간, 주간 캘린더
class _MainCalendarMonthState extends State<MainCalendarMonth> {
  bool isCurrentMonth = true;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // 캘린더가 차지할 높이
        height: 600,
        child: SfCalendar(
          // 최초 표시형식 (월)
          view: CalendarView.month,
          // 임시 데이터 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 나중에 삭제 해야됨
          dataSource: getDataSource(),
          // 변경 가능한 표시형식 (월, 주)
          allowedViews: const [
            CalendarView.month,
            CalendarView.week,
          ],
          // 배경색
          backgroundColor: Colors.transparent,
          // 오늘 날짜 강조색
          todayHighlightColor: grey3,
          todayTextStyle: TextStyle(color: Colors.white),
          // 연월 고르는 버튼 활성화
          showDatePickerButton: true,
          // 오늘 날짜로 돌아가는 버튼
          showTodayButton: true,
          cellBorderColor: grey3,
          // 달력 헤더 스타일 설정
          headerDateFormat: 'yyyy년 MM월',
          headerHeight: 50,
          headerStyle: const CalendarHeaderStyle(
              backgroundColor: Colors.white,
              textStyle: TextStyle(
                fontSize: 14,
                // fontWeight: FontWeight.bold,
                color: Colors.black,
              )),

            // 특정 날짜 선택시 셀 스타일 설정
            selectionDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                    color: isCurrentMonth ? mainOrange : Colors.transparent, width: 2)
            ),
            // 달력 표시
            monthViewSettings: MonthViewSettings(
              // 나타낼 주 수
              numberOfWeeksInView: 6,
            ),
            // week 설정
            timeSlotViewSettings: TimeSlotViewSettings(
              // 시간 표시 간격
              timeInterval: Duration(hours: 2),
          ),
        )
    );
  }
}




