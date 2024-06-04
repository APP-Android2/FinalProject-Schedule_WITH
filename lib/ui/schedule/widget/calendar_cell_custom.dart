import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarCellCustom extends StatefulWidget {
  const CalendarCellCustom({super.key});

  @override
  State<CalendarCellCustom> createState() => _CalendarCellCustomState();
}

class _CalendarCellCustomState extends State<CalendarCellCustom> {
  // 캘린더 컨트롤러
  final CalendarController _customCalendarController = CalendarController();
  int? currentMonth = DateTime.now().month;
  bool isTabCurrentMonth = true;

  // @override
  // void initState() {
  //   super.initState();
  //   // 초기 현재 월 설정
  //   currentMonth = DateTime.now().month;
  // }

  // 선택된 셀의 날짜 확인
  // void _onCalendarTap(CalendarTapDetails details) {
  //   // 선택한 요소의 인덱스 (0 = 헤더 , 1 = 요일 , 2 = 셀)
  //   var onTapElement = details.targetElement.index;
  //   // 선택된 날짜
  //   var userSelectMonth = _customCalendarController.selectedDate?.month;
  //   // 달력상 날짜
  //   var calendarMonth = _customCalendarController.displayDate?.month;
  //
  //   if (onTapElement == 2) {
  //     // UI 변경
  //     setState(() {
  //       if (userSelectMonth == calendarMonth) {
  //         isTabCurrentMonth = true;
  //       } else {
  //         isTabCurrentMonth = false;
  //       }
  //     });
  //   }
  // }

  // // 현재 표시되는 날짜 (보이는 날짜의 중간)
  // void _onViewChanged(ViewChangedDetails details) {
  //   DateTime displayDate = details.visibleDates[details.visibleDates.length ~/ 2];
  //   // 현재 표시되는 월 업데이트
  //   if (
  //
  //   )
  // }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: SfCalendar(
      // onTap: _onCalendarTap,
      // onViewChanged:_onViewChanged,
      controller: _customCalendarController,
      view: CalendarView.month,
      cellBorderColor: grey1,
      backgroundColor: Colors.transparent,
          todayHighlightColor: mainOrange,
          todayTextStyle: TextStyle(color: Colors.white),
      headerDateFormat: 'yyyy년 MM월',
      showNavigationArrow: true,
      showTodayButton: true,
      headerHeight: 50,
      headerStyle: const CalendarHeaderStyle(
        backgroundColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 14,
          // fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      // 특정 날짜 선택시 셀 스타일 설정
      selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color: isTabCurrentMonth ? mainOrange : Colors.transparent,
              width: 2)),
      // 커스텀 셀
      monthCellBuilder: (BuildContext buildContext, MonthCellDetails details) {
        return CustomMonthCell(
            details: details,
            currentMonth: _customCalendarController.displayDate?.month);
      },
    ));
  }
}

class CustomMonthCell extends StatelessWidget {
  final MonthCellDetails details;
  final int? currentMonth;

  CustomMonthCell({required this.details, required this.currentMonth});

  @override
  Widget build(BuildContext context) {
    bool isCurrentMonthCell = (details.date.month == currentMonth);

    return Container(
      // 셀 테두리 색상 설정
        decoration: BoxDecoration(
          border: Border.all(color: grey1, width: 1.0),
        ),
      child: Center(
      child: Column(
        children: [
          SizedBox(height: 4),
          Text(details.date.day.toString(),
              style:
                  TextStyle(color: isCurrentMonthCell ? Colors.black : grey4)),
          SizedBox(height: 10),
          Icon(Icons.event, color: isCurrentMonthCell ? grey4 : Colors.transparent),
        ],
      ),
    )
    );
  }
}
