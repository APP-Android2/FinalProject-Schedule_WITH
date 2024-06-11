
import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/memo/view/memo_main.dart';
import 'package:schedule_with/widget/friend_request_after.dart';
import 'package:schedule_with/widget/friend_request_before.dart';
import 'package:schedule_with/widget/main_calendar_month.dart';
import 'package:schedule_with/widget/main_tab_bar.dart';

import '../../todo/widget/calendar_cell_custom.dart';

class FriendTabBar extends StatefulWidget {
  const FriendTabBar({super.key});

  @override
  State<FriendTabBar> createState() => _FriendTabBarState();
}

class _FriendTabBarState extends State<FriendTabBar>
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
        Container(
            width: double.infinity,
            height: 200,
          child: Image.asset('lib/assets/image/logo.png'),
        ),
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
              controller: _tabController,
              children: [
                // 탭1 : 캘린더
                TabViewCalendar(),
                // 탭2 : 투두
                // TodoMainScreen(),
                FriendRequestBefore(),
                // 탭3 : 메모
                FriendRequestAfter()
              ],
            )
        )
      ],
    );
  }
}


// 캘린더 탭에 보일 항목들
class TabViewCalendar extends StatelessWidget {
  const TabViewCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: MainCalendarMonth(),
        ),
    ]);
  }
}
