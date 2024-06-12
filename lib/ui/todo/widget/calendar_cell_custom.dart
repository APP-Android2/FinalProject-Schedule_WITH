import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../group/widget/my_todo_indicator.dart';
import '../controller/todo_controller.dart';

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
  final TodoController todoController = Get.find<TodoController>();

  // 현재 표시되는 날짜 (보이는 날짜의 중간)
  void _onViewChanged(ViewChangedDetails details) {
    DateTime displayDate = details.visibleDates[details.visibleDates.length ~/ 2];
    customCalendarController.updateMonth(displayDate.month);
  }

  // 선택된 셀의 날짜 확인
  void _onCalendarTap(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      customCalendarController.updateSelectedDate(details.date!);
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
          color: Colors.transparent,
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
        todoController.updateDt(details.date);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelectedDate && !isCurrentMonthCell
                ? Colors.transparent
                : grey2,
            width: 0.6,
          ),
          color: isSelectedDate ? Colors.transparent : Colors.white,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                '${details.date.day}',
                style: TextStyle(
                  color: isCurrentMonthCell ? Colors.black : Colors.grey,
                ),
              ),
            ),
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
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
