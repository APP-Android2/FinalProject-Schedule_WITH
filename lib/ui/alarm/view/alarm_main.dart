import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/alarm/view/alarm_detail.dart';
import 'package:schedule_with/ui/alarm/view/alarm_screen.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:schedule_with/widget/main_alert.dart';

import '../../../widget/main_app_bar.dart';
import '../widget/alarm_item.dart';

class AlarmMain extends StatefulWidget {

  const AlarmMain({super.key});

  @override
  State<AlarmMain> createState() => _AlarmMainState();

}

class _AlarmMainState extends State<AlarmMain> {
  bool alarmIsChecked = false;


  final List<Alarm> alarm = [
    // ... Add your alarm data here (title, isChecked)
    Alarm(title: 'Wake up alarm', isChecked: true),
    Alarm(title: 'Meeting reminder', isChecked: false),
    Alarm(title: 'Meditate', isChecked: true),
  ];


  @override
  Widget build(BuildContext context) {
    // final List<UniqueKey> keys = List.generate(5, (index) => UniqueKey());
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MainAppBar()),
        body: Stack(
          children: [
            Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: alarm.length,
                itemBuilder: (BuildContext context, int index){
                  return SwipeActionCell(
                      key: ObjectKey(alarm[index]),
                      trailingActions: <SwipeAction>[
                        SwipeAction(
                          title: "삭제",
                          onTap: (CompletionHandler handler) async {
                            await handler(true);
                            alarm.removeAt(index);
                            setState(() {});
                          },
                          color:  mainBrown,
                        ),
                      ],
                      child: InkWell(
                        onTap: (){ showModalBottomSheet(
                        // 바텀 시트 높이 지정하려면 isScrollControlled: true,
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context){
                          return AlarmDetail();
                          });
                        },
                        child: AlarmItem(alarm: alarm[index])));
                },
              ),
            ),
            IconButton(
                onPressed: () {
                  Get.to(AlarmScreen());
                },
                icon: Icon(Icons.near_me_rounded)
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showModalBottomSheet(
              // 바텀 시트 높이 지정하려면 isScrollControlled: true,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context){
                return AlarmDetail();
              });
          },
          backgroundColor: mainOrange,
          child: Icon(Icons.add, color: Colors.white,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}

class _DeleteButtonPainter extends CustomPaint {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final padding = 16.0;
    final buttonSize = size.height - padding * 2;
    final radius = buttonSize / 2;
    final centerX = size.width / 2;
    final centerY = size.height - padding - radius;

    // Draw delete button
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
    canvas.drawLine(Offset(centerX - radius / 3, centerY), Offset(centerX + radius / 3, centerY), paint);
  }
}

class alarm {
  final String title; // Alarm title
  bool isChecked; // Whether the alarm is active or not

  alarm({required this.title, required this.isChecked});
}



