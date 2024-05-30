import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../assets/colors/color.dart';
import '../widget/calendar_tab.dart';
import '../widget/calendar_widget.dart';
import '../widget/todo_app_bar.dart';
import '../widget/todo_edit_bottom_sheet.dart';
import '../widget/todo_page_share.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoMainScreen(),
    );
  }
}

class TodoMainScreen extends StatefulWidget {
  const TodoMainScreen({super.key});

  @override
  _TodoMainScreenState createState() => _TodoMainScreenState();
}

class _TodoMainScreenState extends State<TodoMainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime? selectedDate;
  bool isEditing = false;

  final Map<String, List<TodoItemData>> _todoItemsByDate = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 1;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void onTodoAdd() {
    if (selectedDate != null) {
      String dateString = DateFormat('yyyy-MM-dd').format(selectedDate!);
      setState(() {
        if (_todoItemsByDate[dateString] == null) {
          _todoItemsByDate[dateString] = [];
        }
        _todoItemsByDate[dateString]!.add(TodoItemData(
          date: dateString,
          content: '   ',
        ));
      });
    }
  }

  void onTodoEdit(TodoItemData todoItemData) {
    setState(() {
      isEditing = true;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => TodoEditBottomSheet(
        todoItemData: todoItemData,
        onCancel: () {
          Navigator.of(context).pop();
          setState(() {
            isEditing = false;
          });
        },
        onSave: (updatedTodoItem) {
          setState(() {
            String dateString = todoItemData.date;
            int index = _todoItemsByDate[dateString]!.indexOf(todoItemData);
            if (index != -1) {
              _todoItemsByDate[dateString]![index] = updatedTodoItem;
            }
            isEditing = false;
          });
          Navigator.of(context).pop();
        },
        onDelete: () {
          setState(() {
            String dateString = todoItemData.date;
            _todoItemsByDate[dateString]!.remove(todoItemData);
            isEditing = false;
          });
          Navigator.of(context).pop();
        },
      ),
    ).whenComplete(() {
      setState(() {
        isEditing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<TodoItemData> todosForSelectedDate = [];
    if (selectedDate != null) {
      String dateString = DateFormat('yyyy-MM-dd').format(selectedDate!);
      todosForSelectedDate = _todoItemsByDate[dateString] ?? [];
    }

    double completionRate = 0.0;
    if (todosForSelectedDate.isNotEmpty) {
      int completedCount = todosForSelectedDate.where((item) => item.isCompleted).length;
      completionRate = completedCount / todosForSelectedDate.length;
    }

    return GestureDetector(
      onTap: isEditing
          ? () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Are you sure you want to cancel editing?'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          isEditing = false;
                        });
                      },
                      child: Text('Confirm'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Continue Editing'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
          : null,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TodoAppBar(tabController: _tabController),
        body: Column(
          children: [
            CalendarWidget(onDateSelected: onDateSelected),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TodoSharePage(
                                  todosForSelectedDate: todosForSelectedDate,
                                  completionRate: completionRate,
                                  selectedDate: selectedDate!,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          ' ${(completionRate * 100).toStringAsFixed(0)}%',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainOrange),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  CalendarTab(),
                  ListView.builder(
                    itemCount: todosForSelectedDate.length,
                    itemBuilder: (context, index) {
                      final item = todosForSelectedDate[index];
                      return ListTile(
                        leading: Checkbox(
                          value: item.isCompleted,
                          onChanged: (bool? value) {
                            setState(() {
                              item.isCompleted = value ?? false;
                            });
                          },
                          activeColor: mainOrange,
                          checkColor: Colors.white,
                          side: BorderSide(color: mainOrange),
                        ),
                        title: Text(item.content),
                        onTap: () => onTodoEdit(item),
                      );
                    },
                  ),
                  Center(child: Text('메모 탭 (아직 구현되지 않음)')),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onTodoAdd,
          backgroundColor: mainOrange.withOpacity(0.7),
          shape: CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class TodoItemData {
  String date;
  String content;
  bool isCompleted;

  TodoItemData({
    required this.date,
    required this.content,
    this.isCompleted = false,
  });
}
