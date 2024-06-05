import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/group/widget/my_todo_indicator.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_edit_bottom_sheet.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// GetX 컨트롤러
class CalendarController extends GetxController {
  var currentMonth = DateTime.now().month.obs;
  var selectedDate = DateTime.now().obs;

  void updateMonth(int month) {
    currentMonth.value = month;
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }
}

class CalendarCellCustom extends StatefulWidget {
  CalendarCellCustom({super.key});

  @override
  State<CalendarCellCustom> createState() => _CalendarCellCustomState();
}

class _CalendarCellCustomState extends State<CalendarCellCustom> {
  // GetX Controller 초기화
  final CalendarController calendarControllerGetX =
  Get.put(CalendarController());

  // 현재 표시되는 날짜 (보이는 날짜의 중간)
  void _onViewChanged(ViewChangedDetails details) {
    DateTime displayDate =
    details.visibleDates[details.visibleDates.length ~/ 2];
    calendarControllerGetX.updateMonth(displayDate.month);
  }

  // 선택된 셀의 날짜 확인
  void _onCalendarTap(CalendarTapDetails details) {
    // 약속이 있으면 스케줄 수정 바텀 시트를 띄운다
    var todayAppoint = details.appointments?.isNotEmpty ?? false;
    print(details.targetElement);

    if (details.targetElement.name == CalendarElement.calendarCell) {
      Get.back();
    }

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
    return SizedBox(
      child: SfCalendar(
        // 캘린더 스타일 설정
        onViewChanged: _onViewChanged,
        onTap: _onCalendarTap,
        // controller: _calendarController,
        view: CalendarView.month,
        viewHeaderHeight: -1,
        cellBorderColor: grey1,
        backgroundColor: Colors.transparent,
        todayHighlightColor: mainOrange,
        todayTextStyle: TextStyle(color: Colors.white),
        headerDateFormat: 'yyyy년 MM월',
        showDatePickerButton: true,
        // showNavigationArrow: true,
        // allowViewNavigation: true,
        // allowedViews: [
        //   CalendarView.month,
        //   // CalendarView.timelineMonth,
        // ],
        monthViewSettings: MonthViewSettings(
          // 캘린더에 몇 주 표시할지
          numberOfWeeksInView: 2
          // showTrailingAndLeadingDates: false
        ),
        timeSlotViewSettings: TimeSlotViewSettings(),
        showTodayButton: true,
        headerHeight: 50,
        headerStyle: const CalendarHeaderStyle(
          backgroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        // 특정 날짜 선택시 셀 스타일 설정
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: mainOrange,
            width: 2,
          ),
        ),
        // 커스텀 셀
        monthCellBuilder:
            (BuildContext buildContext, MonthCellDetails details) {
          return Obx(() {
            return CustomMonthCell(
              details: details,
              currentMonth: calendarControllerGetX.currentMonth.value,
              selectedDate: calendarControllerGetX.selectedDate.value,
            );
          });
        },
      ),
    );
  }
}



// 캘린더 셀 내용에 달성률 indicator 넣기 위해 커스터마이징
class CustomMonthCell extends StatelessWidget {
  final MonthCellDetails details;
  final int currentMonth;
  final DateTime selectedDate;

  CustomMonthCell({
    super.key,
    required this.details,
    required this.currentMonth,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    bool isCurrentMonthCell = (details.date.month == currentMonth);
    bool isSelectedDate = details.date == selectedDate;
    bool isCurrentMonthSelected = selectedDate.month == currentMonth;

    return
      Column(children: [
        Container(
          height: 70,
          // 셀 테두리 색상 설정
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelectedDate && !isCurrentMonthSelected
                  ? Colors.transparent
                  : grey2,
              width: 0.6,
            ),
          ),
          child: SizedBox(
            // 달력 셀 높이
              height: 10,
              child: Column(
                children: [
                  // 날짜 텍스트 위 여백
                  SizedBox(height: 5),
                  Text(
                    details.date.day.toString(),
                    style: TextStyle(
                      color: isCurrentMonthCell ? Colors.black87 : grey4,
                    ),
                  ),
                  SizedBox(height: 4),
                  // 셀 내부에 들어갈 내용
                  Container(
                    height: 30,
                    alignment: Alignment.center,
                    // 현재 달만 indicator 보이도록 함
                    child: isCurrentMonthCell
                        ? MyTodoIndicator(totalTodo: 10, doneTodo: 8)
                        : SizedBox(),
                  )
                ],
              )),
        )
      ]);
  }
}


