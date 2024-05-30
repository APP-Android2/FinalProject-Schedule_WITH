import 'package:flutter/material.dart';
import 'package:schedule_with/widget/view/main_appbar.dart';
import 'package:schedule_with/widget/view/main_tab_bar.dart';

class ScheduleMain extends StatefulWidget {
  const ScheduleMain({super.key});

  @override
  State<ScheduleMain> createState() => _ScheduleMainState();
}

class _ScheduleMainState extends State<ScheduleMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: MainAppBar()),
      // 탭바
      body: MainTabBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 스케쥴 추가 화면으로 이동
          print("object");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
