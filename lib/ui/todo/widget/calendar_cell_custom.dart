import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/main.dart';
import 'package:schedule_with/ui/group/widget/my_todo_indicator.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_edit_bottom_sheet.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../controller/todo_controller.dart';

// GetX 컨트롤러
class CustomCalendarController extends GetxController {
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
  final CustomCalendarController customCalendarController = Get.find<CustomCalendarController>();

  // 현재 표시되는 날짜 (보이는 날짜의 중간)
  void _onViewChanged(ViewChangedDetails details) {
    DateTime displayDate = details.visibleDates[details.visibleDates.length ~/ 2];
    customCalendarController.updateMonth(displayDate.month);
  }

  // 선택된 셀의 날짜 확인
  void _onCalendarTap(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      customCalendarController.updateSelectedDate(details.date!);

      // 약속이 있으면 스케줄 수정 바텀 시트를 띄운다
      var todayAppoint = details.appointments?.isNotEmpty ?? false;

      if (todayAppoint) {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return EditScheduleBottomSheet();
          },
        );
      } else {
        // 약속이 없을 때의 동작 추가 (필요한 경우)
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SfCalendar(
        onViewChanged: _onViewChanged,
        onTap: _onCalendarTap,
        view: CalendarView.month,
        viewHeaderHeight: -1,
        cellBorderColor: grey1,
        backgroundColor: Colors.transparent,
        todayHighlightColor: mainOrange,
        todayTextStyle: TextStyle(color: Colors.white),
        headerDateFormat: 'yyyy년 MM월',
        showDatePickerButton: true,
        monthViewSettings: MonthViewSettings(
          numberOfWeeksInView: 2,
        ),
        showTodayButton: true,
        headerHeight: 50,
        headerStyle: const CalendarHeaderStyle(
          backgroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        selectionDecoration: BoxDecoration(
          color: Colors.transparent, // 셀 선택 시 배경색 없애기
          border: Border.all(
            color: mainOrange,
            width: 2,
          ),
        ),
        monthCellBuilder: (BuildContext buildContext, MonthCellDetails details) {
          return Obx(() {
            return CustomMonthCell(
              details: details,
              currentMonth: customCalendarController.currentMonth.value,
              selectedDate: customCalendarController.selectedDate.value,
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
  final TodoController todoController = Get.find<TodoController>();

  CustomMonthCell({
    super.key,
    required this.details,
    required this.currentMonth,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    bool isCurrentMonthCell = (details.date.month == currentMonth);
    bool isSelectedDate = (details.date == selectedDate);
    return GestureDetector(
      onTap: () {
        todoController.selectedDate.value = details.date;
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelectedDate && !isCurrentMonthCell
                ? Colors.transparent
                : grey2,
            width: 0.6,
          ),
          color: isSelectedDate ? Colors.transparent : Colors.white, // 선택된 날짜의 배경색을 투명하게 설정

        ),
        // 날짜 및 투두 달성률 설정
        child: Stack(
          children: [
            // 날짜 설정
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                '${details.date.day}',
                style: TextStyle(
                  color: isCurrentMonthCell ? Colors.black : Colors.grey,
                ),
              ),
            ),
            // 투두 달성률 설정
            Obx(() {
              var todosForDate = todoController.getTodosForDate(details.date);
              int totalTodo = todosForDate.length;
              int doneTodo = todosForDate.where((todo) => todo.check.value).length;
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: totalTodo > 0
                      ? MyTodoIndicator(
                    totalTodo: totalTodo,
                    doneTodo: doneTodo,
                  )
                      : SizedBox(),
                )
              );
            }),
          ],
        ),
      ),
    );
  }
}
