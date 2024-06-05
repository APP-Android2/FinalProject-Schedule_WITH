import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/ui/schedule/widget/calendar_cell_custom.dart';
import 'package:schedule_with/ui/todo/widget/todo_add_bottom_sheet.dart';
import '../../../assets/colors/color.dart';

class TodoMainScreen extends StatefulWidget {
  const TodoMainScreen({super.key});

  @override
  State<TodoMainScreen> createState() => _TodoMainScreenState();
}

class _TodoMainScreenState extends State<TodoMainScreen> {
  final List<Todo> _todoItems = [
    Todo(title: '할일1', description: '할일 설명1'),
    Todo(title: '할일2', description: '할일 설명2'),
    Todo(title: '할일3', description: '할일 설명3'),
    Todo(title: '할일4', description: '할일 설명4'),

  ];

  void _addTodoItem(String title, String description) {
    if (title.isNotEmpty && description.isNotEmpty) {
      setState(() {
        _todoItems.add(Todo(
          title: title,
          description: description,
        ));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 화면에서 캘린더가 차지할 크기 (0.60이하 overflow)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              // 달성률 캘린더
              child: CalendarCellCustom(),
            ),
            // 투두 리스트 넣을 부분
            _buildTodoList(),
          ],
        ),
      ),
      // 플로팅 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: mainOrange,
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }



  //
  Widget _buildTodoList() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text(_todoItems[index].title),
          subtitle: Text(_todoItems[index].description),
        );
      },
      itemCount: _todoItems.length,
    );
  }
}


// Todo
class Todo {
  final String title;
  final String description;

  Todo({
    required this.title,
    required this.description,
  });
}
