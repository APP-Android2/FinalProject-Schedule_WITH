import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart'; // CircularPercentIndicator가 이 패키지에 속해있을 것입니다.
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/group/widget/group_todo_indicator.dart';

class ShowGroupTodoPercent extends StatelessWidget {
  final int itemCount;

  const ShowGroupTodoPercent({
    super.key,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      // 펼쳐진 상태로 보임
      initiallyExpanded: true,
      shape: Border(bottom: BorderSide(color: grey2)),
      minTileHeight: 40,
      title: Text(
        '구성원 TODO(%)',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      collapsedIconColor: grey1,
      children: [
        Padding(padding: EdgeInsets.all(4)),
        SizedBox(
          height: 100,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(6),
            child: Row(
              children: List.generate(
                itemCount,
                    (index) => GroupTodoItem(),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(4)),
      ],
    );
  }
}

// 구성원 투두 item
class GroupTodoItem extends StatelessWidget {
  GroupTodoItem({super.key});

  // 오늘 투두의 총 개수
  final int totalTodo = 10;

  // 오늘 완료한 투두 개수
  final int doneTodo = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
          Expanded(
              child: Container(
            // 달성률 퍼센트 인디케이터
                width: 70,
            child: TodoGroupIndicator(totalTodo: totalTodo, doneTodo: doneTodo),
          )),
          SizedBox(height: 10),
          Container(
            child: Text(
              '친구이름',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
  }
}