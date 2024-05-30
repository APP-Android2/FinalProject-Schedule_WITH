import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:schedule_with/widget/main_calendar_day.dart';
import 'package:schedule_with/widget/main_calendar_month.dart';
import '../assets/color/color.dart';

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
              controller: _tabController,
              children: const [
                // 탭1 : 캘린더
                TabViewCalendar(),
                // 탭2 : 투두
                TabViewCalendar(),
                // 탭3 : 메모
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
    return const CustomScrollView(
      // 커스텀 스크롤뷰 사용을 위해 위젯을 Sliver 타입으로 변경
      slivers: [
        // 월간, 주간 일정
        SliverToBoxAdapter(
          child: MainCalendarMonth(),
        ),
        // 상세 일정
        SliverToBoxAdapter(
          child: DayWork(),
        ),
        // 일간 일정
        SliverToBoxAdapter(
          child: MainCalendarDay(),
        ),
        // 여백
        SliverPadding(padding: EdgeInsets.all(20))
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
        collapsedBackgroundColor: grey1,
        children: [
          Row(children: [
            const Padding(padding: EdgeInsets.all(10)),
            TextButton(
                onPressed: () {},
                child: Text(
                  '장기일정1',
                )),
            const Padding(padding: EdgeInsets.all(10)),
            TextButton(onPressed: () {}, child: Text('장기일정2')),
            const Padding(padding: EdgeInsets.all(10)),
            TextButton(onPressed: () {}, child: Text('장기일정3')),
            const Padding(padding: EdgeInsets.all(10)),
            TextButton(onPressed: () {}, child: Text('장기일정4'))
          ]
          )
        ]
    );
  }
}