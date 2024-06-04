import 'package:flutter/material.dart';
import 'todo_controller.dart';
import '../widget/calendar_widget.dart';
import 'todo_item.dart';

class TodoListTab extends StatelessWidget {
  final List<TodoItemData> todoItems;
  final void Function(TodoItemData) onTodoEdit;
  final String selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final void Function(TodoItemData, bool?) onCheckboxChanged;

  const TodoListTab({
    super.key,
    required this.todoItems,
    required this.onTodoEdit,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: CalendarWidget(onDateSelected: onDateSelected), // 캘린더 위젯 추가
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('$selectedDate', style: const TextStyle(fontSize: 16)),
        ),
        Expanded(
          flex: 2,
          child: ListView.builder(
            itemCount: todoItems.length,
            itemBuilder: (context, index) {
              final todoItem = todoItems[index];
              return TodoItem(
                todoItemData: todoItem,
                onCheckboxChanged: (bool? value) {
                  onCheckboxChanged(todoItem, value);
                },
                onEdit: () => onTodoEdit(todoItem),
              );
            },
          ),
        ),
      ],
    );
  }
}
