import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:schedule_with/assets/colors/color.dart';

class TodoGroupIndicator extends StatelessWidget {
  final int totalTodo;
  final int doneTodo;

  const TodoGroupIndicator({
    super.key,
    required this.totalTodo,
    required this.doneTodo,
  });

  @override
  Widget build(BuildContext context) {
    return groupTodoIndicator();
  }


  // 그룹 구성원 달성률
  Widget groupTodoIndicator() {

    // 달성률 계산
    double percent = doneTodo / totalTodo;

    return CircularPercentIndicator(
      radius: 30.0,
      lineWidth: 4.0,
      percent: percent,
      center: Text("${totalTodo}",
          style: TextStyle(
              color: mainBrown,
              fontSize: 16, fontWeight: FontWeight.bold)),
      progressColor: mainBrown,
      backgroundColor: Colors.white,
    );
  }
}


