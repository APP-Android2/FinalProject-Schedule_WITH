import 'package:flutter/material.dart';
import 'package:schedule_with/ui/schedule/widget/long_appoint.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_add_bottom_sheet.dart';
import 'package:schedule_with/ui/todo/view/todo_main_screen.dart';
import 'package:schedule_with/widget/main_calendar_day.dart';
import 'package:schedule_with/widget/main_calendar_month.dart';

import '../assets/colors/color.dart';
import '../ui/memo/view/memo_main.dart';

class MainTabBar extends StatefulWidget {
  const MainTabBar({super.key});

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 탭의 수에 따라 length 값을 조정
    _tabController =
        TabController(length: 3, vsync: this); // 탭의 수에 따라 length 값을 조정
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          // 색상 설정
          controller: _tabController,
          indicatorColor: mainOrange,
          labelColor: Colors.white,
          unselectedLabelColor: grey4,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          indicator: BoxDecoration(color: mainOrange),
          indicatorSize: TabBarIndicatorSize.tab,
          // 탭 제목
          tabs: <Widget>[
            Tab(text: '캘린더'),
            Tab(text: 'TODO'),
            Tab(text: '메모'),
          ],
        ),
        Expanded(
          // 각 탭바에 나타낼 View
          child: TabBarView(
          physics: NeverScrollableScrollPhysics(), // 스와이프 비활성화 설정
          controller: _tabController,
          children: [
            // 탭1 : 캘린더
            TabViewCalendar(),
            // 탭2 : 투두
            TodoMainScreen(),
            // 탭3 : 메모
            MemoMainScreen()
          ],
        ))
      ],
    );
  }
}

// 캘린더 탭에 보일 항목들
class TabViewCalendar extends StatelessWidget {
  const TabViewCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              children: [
                // 월간, 주간 일정
                MainCalendarMonth(),
                // 장기 일정
                ShowLongAppoint(),
                // 일간 일정
                MainCalendarDay(),
              ])
      ),
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
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
