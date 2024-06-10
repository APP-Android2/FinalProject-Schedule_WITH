import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/widget/calendar_cell_custom.dart';
import '../widget/todo_controller.dart';
import '../widget/select_share_option.dart';
import '../widget/todo_add_bottom_sheet.dart';
import '../widget/todo_edit_bottom_sheet.dart';
import '../widget/todo_item_data.dart';

class TodoMainScreen extends StatefulWidget {
  const TodoMainScreen({super.key});

  @override
  _TodoMainScreenState createState() => _TodoMainScreenState();
}

class _TodoMainScreenState extends State<TodoMainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime? selectedDate;
  bool isEditing = false;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TodoController _todoController = Get.put(TodoController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 1;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _dateController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      _dateController.text = DateFormat('yyyy-MM-dd').format(date);
    });
  }

  void onTodoAdd() {
    if (selectedDate != null) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => TodoAddBottomSheet(
          dateController: _dateController,
          contentController: _contentController,
          onSave: () {
            String dateString = DateFormat('yyyy-MM-dd').format(selectedDate!);
            _todoController.addTodoItem(dateString, _contentController.text);
            _contentController.clear();
            Navigator.of(context).pop();
            setState(() {}); // 상태를 새로고침하여 UI 업데이트
          },
        ),
      );
    }
  }

  void onTodoEdit(TodoItemData todoItemData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => TodoEditBottomSheet(
        todoItemData: todoItemData,
        onCancel: () {
          Navigator.of(context).pop();
        },
        onSave: (oldDate, updatedTodoItem) {
          setState(() {
            _todoController.updateTodoItem(oldDate, updatedTodoItem);
          });
          Navigator.of(context).pop(); // 수정 바텀 시트 닫기
        },
        onDelete: () {
          setState(() {
            _todoController.deleteTodoItem(todoItemData.date, todoItemData);
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void onDownload() {
    if (selectedDate != null) {
      String dateString = DateFormat('yyyy-MM-dd').format(selectedDate!);
      List<TodoItemData> todosForSelectedDate = _todoController.getTodoItemsForDate(dateString);

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => SelectShareOption(
          todosForSelectedDate: todosForSelectedDate,
          completionRate: _todoController.calculateCompletionRate(dateString),
          selectedDate: selectedDate!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          CalendarCellCustom(),
          if (selectedDate != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        DateFormat('yyyy년 MM월 dd일').format(selectedDate!),
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(Icons.download, color: grey3),
                        onPressed: onDownload,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Obx(() {
                        double completionRate = selectedDate != null
                            ? _todoController.calculateCompletionRate(DateFormat('yyyy-MM-dd').format(selectedDate!))
                            : 0.0;
                        return Text(
                          ' ${(completionRate * 100).toStringAsFixed(0)}%',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainOrange),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          Expanded(
            child: Obx(() {
              List<TodoItemData> todosForSelectedDate = [];
              if (selectedDate != null) {
                String dateString = DateFormat('yyyy-MM-dd').format(selectedDate!);
                todosForSelectedDate = _todoController.getTodoItemsForDate(dateString);
              }

              return ListView.builder(
                itemCount: todosForSelectedDate.length,
                itemBuilder: (context, index) {
                  TodoItemData todoItem = todosForSelectedDate[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0), // 상하 간격 조정
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 0, right: 16.0), // ListTile의 패딩 조정
                      leading: Checkbox(
                        value: todoItem.isCompleted,
                        onChanged: (bool? value) {
                          setState(() {
                            todoItem.isCompleted = value ?? false;
                            _todoController.updateTodoItem(todoItem.date, todoItem);
                          });
                        },
                        activeColor: mainOrange, // 체크박스 색상
                        side: BorderSide(color: mainOrange), // 체크박스 테두리 색상
                      ),
                      title: Text(
                        todoItem.content,
                        style: TextStyle(fontSize: 14), // 텍스트 크기 조정
                      ),
                      onTap: () {
                        onTodoEdit(todoItem); // TODO 편집 기능 추가
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTodoAdd,
        backgroundColor: mainOrange,
        shape: CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
