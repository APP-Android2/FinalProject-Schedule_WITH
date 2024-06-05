import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:schedule_with/assets/colors/color.dart';

class MyTodoIndicator extends StatelessWidget {
  final int totalTodo;
  final int doneTodo;

  MyTodoIndicator({super.key,
    required this.totalTodo,
    required this.doneTodo
  });

  @override
  Widget build(BuildContext context) {
    return myTodoIndicator();
  }

  // 개인 월간 캘린더 셀에 들어갈 인디케이터
  Widget myTodoIndicator() {
    // int totalTodo = 10;
    // int doneTodo = 5;

    // 달성률만큼 indicator 색깔을 채운다
    double percent = doneTodo / totalTodo;
    // 표시할 숫자
    // int displayPercent = (percent * 100).toInt();

    // 달성률이 100% 인지 아닌지에 따라 색깔 분기
    Color progressColor = percent == 1 ? mainOrange : mainBrown;

    return CircularPercentIndicator(
      animation: true,
      radius: 15.0,
      lineWidth: 2.0,
      percent: percent,
      backgroundColor: Colors.white,
      center: Text(
        "${totalTodo}",
        style: TextStyle(
            color: progressColor,
            fontSize: 10, fontWeight: FontWeight.bold),
      ),
      progressColor: progressColor,
    );
  }
}
