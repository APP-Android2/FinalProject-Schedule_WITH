import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule_with/ui/group/widget/group_todo_percent.dart';
import 'package:schedule_with/widget/main_calendar_month.dart';

class GroupTodo extends StatefulWidget {
  const GroupTodo({super.key});

  @override
  State<GroupTodo> createState() => _GroupTodoState();
}

class _GroupTodoState extends State<GroupTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50), child: groupTodoAppBar()),
      body: groupTodoCalendar(),

    );
  }
}

Widget groupTodoCalendar() {
  return CustomScrollView(
    slivers: [
      // 프사,배경 부분 넣어야 됨

      // 캘린더
      SliverToBoxAdapter(
        child: MainCalendarMonth()
      ),
      // 구성원 투두 달성률
      SliverToBoxAdapter(
        child: ShowGroupTodoPercent(itemCount: 10),
      ),
    // 투두 리스트
    SliverToBoxAdapter(
      child: SizedBox(
        width: double.infinity,
        height: 300,
      )
    ),
  ],
  );
}



Widget groupTodoAppBar(){
  return AppBar(
    backgroundColor: Colors.white,
    actions: [
      Icon(CupertinoIcons.clear),
      SizedBox(width: 10)
    ],

  );
}
