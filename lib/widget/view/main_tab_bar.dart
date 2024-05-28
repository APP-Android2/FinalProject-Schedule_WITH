import 'package:flutter/material.dart';
import 'package:schedule_with/widget/view/main_calendar_day.dart';
import 'package:schedule_with/widget/view/main_calendar_month.dart';

import '../../assets/colors/color.dart';

class MainTabBar extends StatefulWidget {
  const MainTabBar({super.key});

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 탭의 수에 따라 length 값을 조정
    _tabController = TabController(length: 3, vsync: this); // 탭의 수에 따라 length 값을 조정
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
          labelStyle: TextStyle(fontSize: 14),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          indicator: BoxDecoration(color: mainOrange),
          indicatorSize: TabBarIndicatorSize.tab,
          // 탭
          tabs: <Widget>[
            Tab(text: '캘린더'),
            Tab(text: 'TODO'),
            Tab(text: '메모'),
          ],
        ),
        Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 캘린더 탭에 나타낼 위젯 리스트
                ListView(
                    children: const [
                      // 달력(월, 주)
                      MainCalendarMonth(),
                      // 장기일정
                      DayWork(),
                      // 달력(일)
                      MainCalendarDay()
                    ]
                )
              ],
            )
        )
      ],
    );
  }
}


// 장기일정 숨기기 펼치기
class DayWork extends StatelessWidget {
  const DayWork({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        leading: Container(width: 24),
        title: const Center(
            child: Text(
              '상세 일정',
              style: TextStyle(fontSize: 14),
            )),
        collapsedIconColor: Colors.grey,
        children: [
          Row(
            children: [
              const Padding(padding: EdgeInsets.all(10)),
              FilledButton(
                  onPressed: () {},
                  child: Text('장기일정1')
              ),
              const Padding(padding: EdgeInsets.all(10)),
              FilledButton(
                  onPressed: () {},
                  child: Text('장기일정2')
              ),
              const Padding(padding: EdgeInsets.all(10)),
              FilledButton(
                  onPressed: () {},
                  child: Text('장기일정3')
              )
            ],
          )
        ]
    );
  }
}

