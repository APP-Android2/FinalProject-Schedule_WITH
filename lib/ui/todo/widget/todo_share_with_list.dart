import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/todo/widget/todo_item_data.dart';
import 'todo_controller.dart';
import '../view/todo_main_screen.dart';

class TodoShareWithList extends StatelessWidget {
  final List<TodoItemData> todosForSelectedDate;
  final double completionRate;
  final DateTime selectedDate;

  const TodoShareWithList({
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
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                itemCount: todosForSelectedDate.length,
                itemBuilder: (context, index) {
                  final item = todosForSelectedDate[index];
                  return ListTile(
                    leading: Checkbox(
                      value: item.isCompleted,
                      onChanged: null,
                      activeColor: mainOrange,
                      checkColor: Colors.white,
                      side: BorderSide(color: mainOrange),
                    ),
                    title: Text(item.content),
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            Divider(color: grey2),// 점선으로 대체예정
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
                Column(
                  children: [
                    Text('달성률', style: TextStyle(fontSize: 16, color: Colors.black)),
                    Text('${(completedCount / totalCount * 100).toStringAsFixed(0)}%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: mainOrange)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
