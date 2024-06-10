import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/todo/view/todo_main_screen.dart';

class MainTabBar extends StatefulWidget {
  final TabController tabController;

  const MainTabBar({super.key, required this.tabController});

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: widget.tabController,
          indicatorColor: mainOrange,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          indicator: const BoxDecoration(color: mainOrange),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: '캘린더'),
            Tab(text: 'TODO'),
            Tab(text: '메모'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: widget.tabController,
            children: const [
              Center(child: Text("캘린더화면"),),
              TodoMainScreen(), // This would be the todo list screen
              Center(child: Text('메모 화면')),
            ],
          ),
        ),
      ],
    );
  }
}
