import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/ui/todo/widget/todo_edit_bottom_sheet.dart';
import '../../../assets/colors/color.dart';
import '../widget/calendar_cell_custom.dart';
import '../controller/todo_controller.dart';
import '../widget/todo_add_bottom_sheet.dart';

class TodoMainScreen extends StatefulWidget {
  const TodoMainScreen({super.key});

  @override
  State<TodoMainScreen> createState() => _TodoMainScreenState();
}

class _TodoMainScreenState extends State<TodoMainScreen> {
  final TodoController todoController = Get.put(TodoController());
  final CustomCalendarController calendarController = Get.put(CustomCalendarController());
  final DateFormat formatter = DateFormat('yyyy년 MM월 dd일');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 215,
            child: CalendarCellCustom(),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Text("${formatter.format(calendarController.selectedDate.value)}");
                }),
                Obx(() {
                  var todosForDate = todoController.getTodosForDate(calendarController.selectedDate.value);
                  double completionPercentage = todosForDate.isEmpty
                      ? 0.0
                      : todosForDate.where((todo) => todo.check.value).length / todosForDate.length * 100;
                  return Text("${completionPercentage.toStringAsFixed(0)}%", style: TextStyle(color: mainOrange));
                }),
              ],
            ),
          ),
          Expanded(child: Obx(() {
            var todosForDate = todoController.getTodosForDate(calendarController.selectedDate.value);
            return ListView.builder(
              itemCount: todosForDate.length,
              itemBuilder: (_, index) {
                var todo = todosForDate[index];
                return ListTile(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return TodoEditBottomSheet(title: todo.title,calendarController: calendarController,);
                        },
                    );
                  },
                  leading: Obx(() {
                    return Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      ),
                      checkColor: Colors.white,
                      activeColor: Colors.white,
                      fillColor: todo.check.value ? MaterialStatePropertyAll(mainOrange) : MaterialStatePropertyAll(Colors.white),
                      side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(width: 1.0, color: mainOrange),
                      ),
                      value: todo.check.value,
                      onChanged: (value) {
                        todoController.toggleTodoCheck(todo);
                      },
                    );
                  }),
                  title: Text(todo.title)
                );
              },
            );
          })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return TodoAddBottomSheet();
            },
          );
        },
        backgroundColor: mainOrange,
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
