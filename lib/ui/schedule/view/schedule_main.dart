import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/widget/add_schedule_bottom_sheet.dart';
import 'package:schedule_with/widget/main_app_bar.dart';
import 'package:schedule_with/widget/main_tab_bar.dart';

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
        onPressed: (){
          showModalBottomSheet(
            // 바텀 시트 높이 지정하려면 isScrollControlled: true,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context){
                return AddScheduleBottomSheet();
              });
        },
        backgroundColor: mainOrange,
        child: Icon(Icons.add, color: Colors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

      ),

    );
  }
}
