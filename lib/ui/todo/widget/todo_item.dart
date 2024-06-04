import 'package:flutter/material.dart';
import 'todo_controller.dart';

class TodoItem extends StatelessWidget {
  final TodoItemData todoItemData;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback onEdit;

  const TodoItem({
    super.key,
    required this.todoItemData,
    required this.onCheckboxChanged,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todoItemData.isCompleted,
        onChanged: onCheckboxChanged,
        activeColor: Colors.orange,
        side: BorderSide(color: Colors.orange),
      ),
      title: Text(todoItemData.content),
      subtitle: Text(todoItemData.date),
      onTap: onEdit,
    );
  }
}
