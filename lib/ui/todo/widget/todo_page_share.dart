import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/ui/todo/widget/todo_item_data.dart';
import '../../../assets/colors/color.dart';

class TodoSharePage extends StatelessWidget {
  final List<TodoItemData> todosForSelectedDate;
  final double completionRate;
  final DateTime selectedDate;

  const TodoSharePage({
    Key? key,
    required this.todosForSelectedDate,
    required this.completionRate,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int completedCount = todosForSelectedDate.where((item) => item.isCompleted).length;
    int totalCount = todosForSelectedDate.length;
    int remainingCount = totalCount - completedCount;

    String formattedDate = DateFormat('yyyy년 MM월 dd일').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로 이동 화살표 버튼 제거
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0), // AppBar 높이 줄이기
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'xXxX 님의 ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold, // Bold 처리
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'WITH',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: mainOrange,
                          ),
                        ),
                        TextSpan(
                          text: ' 기록',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold, // Bold 처리
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Image.asset(
                'lib/assets/image/logo.png',
                height: 20,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Divider(color: grey2),
            SizedBox(height: 20.0),
            Expanded(
              flex: 3,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CustomPaint(
                    painter: DonutProgressPainter(completionRate, mainOrange),
                    child: Center(
                      child: Text(
                        '${(completionRate * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: mainOrange,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Divider(color: grey2, thickness: 1),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('TODO', style: TextStyle(fontSize: 16, color: Colors.black)),
                    Text('$totalCount', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    Text('완료', style: TextStyle(fontSize: 16, color: Colors.black)),
                    Text('$completedCount', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: mainOrange)),
                  ],
                ),
                Column(
                  children: [
                    Text('미완료', style: TextStyle(fontSize: 16, color: Colors.black)),
                    Text('$remainingCount', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Divider(color: grey2, thickness: 1, indent: 16, endIndent: 16),
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: todosForSelectedDate.length,
                itemBuilder: (context, index) {
                  final item = todosForSelectedDate[index];
                  return ListTile(
                    leading: Checkbox(
                      value: item.isCompleted,
                      onChanged: null, // 이미 완료된 TODO는 수정 불가
                      activeColor: mainOrange,
                      checkColor: Colors.white,
                      side: BorderSide(color: mainOrange), // 체크박스 테두리 색상
                    ),
                    title: Text(item.content),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DonutProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  DonutProgressPainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    double thickness = 15;
    double radius = size.width / 2;

    Paint backgroundPaint = Paint()
      ..color = grey2
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    Paint foregroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = thickness;

    canvas.drawCircle(Offset(radius, radius), radius - thickness / 2, backgroundPaint);
    double arcAngle = 2 * 3.141592653589793 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius - thickness / 2),
      -3.141592653589793 / 2,
      arcAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
