import 'package:flutter/material.dart';
import 'package:schedule_with/ui/todo/view/todo_main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoMainScreen(),
    );
  }
}

