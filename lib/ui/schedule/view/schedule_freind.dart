import 'package:flutter/material.dart';
import 'package:schedule_with/ui/schedule/widget/friend_tab_bar.dart';
import 'package:schedule_with/widget/main_calendar_month.dart';
import 'package:schedule_with/widget/main_tab_bar.dart';

class ScheduleFriend extends StatefulWidget {
  const ScheduleFriend({super.key});

  @override
  State<ScheduleFriend> createState() => _ScheduleFriendState();
}

class _ScheduleFriendState extends State<ScheduleFriend> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [Icon(Icons.close)],
              backgroundColor: Colors.transparent,
            ),
          body: FriendTabBar(),
        )
    );
  }


}
