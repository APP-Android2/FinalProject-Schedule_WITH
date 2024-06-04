import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/assets/colors/color.dart';

class TodoShareWithoutList extends StatelessWidget {
  final double completionRate;
  final int totalCount;
  final int completedCount;
  final int remainingCount;
  final DateTime selectedDate;

  const TodoShareWithoutList({
    Key? key,
    required this.completionRate,
    required this.totalCount,
    required this.completedCount,
    required this.remainingCount,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy년 MM월 dd일').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontWeight: FontWeight.bold,
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
                          fontWeight: FontWeight.bold,
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
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: grey2,
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
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
            Divider(
              color: grey2,
              thickness: 1,
              height: 16,
              endIndent: 16,
              indent: 16,
            ),// 점선으로 대체예정
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
