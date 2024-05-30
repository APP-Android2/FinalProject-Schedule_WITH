import 'package:flutter/material.dart';
import '../view/todo_main_screen.dart';
import '../widget/calendar_widget.dart';

class TodoListTab extends StatelessWidget {
  final List<TodoItemData> todoItems;
  final void Function(TodoItemData) onTodoEdit;
  final String selectedDate;

  const TodoListTab({
    super.key,
    required this.todoItems,
    required this.onTodoEdit,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: CalendarWidget(onDateSelected: (DateTime ) {  },), // 캘린더 위젯 추가
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),

          child: Text('2024 년 5월 24 일', style: const TextStyle(fontSize: 16)),
        ),
        Expanded(
          flex: 2,
          child: ListView.builder(
            itemCount: todoItems.length,
            itemBuilder: (context, index) {
              final todoItem = todoItems[index];
              return ListTile(
                title: Text(todoItem.content),
                subtitle: Text(todoItem.date),
                onTap: () => onTodoEdit(todoItem),
              );
            },
          ),
        ),
      ],
    );
  }
}
