import 'package:flutter/material.dart';
import '../view/todo_main_screen.dart';

class TodoItem extends StatelessWidget {
  final TodoItemData todoItemData;
  final ValueChanged<bool?> onCheckboxChanged;

  const TodoItem({
    super.key,
    required this.todoItemData,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(

          );
  }
}
