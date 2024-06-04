import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'todo_controller.dart';
import 'todo_share_with_list.dart';
import 'todo_share_without_list.dart';
import '../view/todo_main_screen.dart';

class SelectShareOption extends StatelessWidget {
  final List<TodoItemData> todosForSelectedDate;
  final double completionRate;
  final DateTime selectedDate;

  const SelectShareOption({
    Key? key,
    required this.todosForSelectedDate,
    required this.completionRate,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(
              '공유하시겠습니까?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: mainBrown,
            ),
            child: MaterialButton(
              onPressed: () {
                Get.back();
                Get.to(() => TodoShareWithList(
                  todosForSelectedDate: todosForSelectedDate,
                  completionRate: completionRate,
                  selectedDate: selectedDate,
                ));
              },
              child: Text(
                'TODO 리스트 포함',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: mainOrange,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            child: MaterialButton(
              onPressed: () {
                Get.back();
                Get.to(() => TodoShareWithoutList(
                  completionRate: completionRate,
                  totalCount: todosForSelectedDate.length,
                  completedCount: todosForSelectedDate.where((item) => item.isCompleted).length,
                  remainingCount: todosForSelectedDate.length - todosForSelectedDate.where((item) => item.isCompleted).length,
                  selectedDate: selectedDate,
                ));
              },
              child: Text(
                'TODO 리스트 미포함',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
