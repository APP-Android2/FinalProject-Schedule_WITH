import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CalendarWidget({super.key, required this.onDateSelected});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  // 현재 달력 범위를 벗어나는 날짜 클릭시 테두리 색을 다르게 설정하기 위한 변수
  bool isCurrentMonth = true;
  // 캘린더 컨트롤러
  CalendarController _calendarController = CalendarController();

  // 선택된 셀의 날짜 확인
  void _onCalendarTap(CalendarTapDetails details) {
    // 선택한 요소의 인덱스 (0 = 헤더 , 1 = 요일 , 2 = 셀)
    var onTapElement = details.targetElement.index;
    // 선택된 날짜
    var selectedDate = details.date;
    // 달력상 날짜
    var calendarMonth = _calendarController.displayDate?.month;
    if (onTapElement == 2) {
      // UI 변경
      setState(() {
        if (selectedDate?.month == calendarMonth) {
          isCurrentMonth = true;
        } else {
          isCurrentMonth = false;
        }
        widget.onDateSelected(selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SfCalendar(
        view: CalendarView.month,
        controller: _calendarController,
        onTap: _onCalendarTap,
        // 임시 데이터
        dataSource: getDataSource(),
        allowedViews: const [
          CalendarView.month,
          CalendarView.week,
        ],
        backgroundColor: Colors.transparent,
        todayHighlightColor: mainBrown,
        todayTextStyle: TextStyle(color: Colors.white),
        showDatePickerButton: true,
        showTodayButton: true,
        cellBorderColor: grey3,
        headerDateFormat: 'yyyy년 MM월',
        headerHeight: 50,
        headerStyle: const CalendarHeaderStyle(
          backgroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: isCurrentMonth ? mainOrange : Colors.transparent, width: 2),
        ),
        monthViewSettings: MonthViewSettings(numberOfWeeksInView: 6),
        timeSlotViewSettings: TimeSlotViewSettings(timeInterval: Duration(hours: 2)),
      ),
    );
  }

  getDataSource() {}
}
