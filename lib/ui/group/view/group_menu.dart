import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/ui/alarm/widget/alarm_detail_switch_button.dart';
import 'package:schedule_with/widget/group_invite_item.dart';
import 'package:schedule_with/widget/group_profile.dart';
import 'package:schedule_with/widget/main_profile.dart';

import '../../../widget/main_tab_bar.dart';
import '../widget/groupl_switch_button.dart';

class GroupMenu extends StatefulWidget {

  const GroupMenu({super.key});

  @override
  State<GroupMenu> createState() => _GroupMenuState();
}

class _GroupMenuState extends State<GroupMenu> {
  late final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("그룹설정",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: InkWell(
            child: Icon(CupertinoIcons.back),
          ),
        ),
        body:  Container(
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    flex: 2,
                    child:MainProfile(),
                  ),
                  SizedBox(height: 10,),
                  Flexible(
                    flex: 3,
                    child: Column(
                      children: [
                        GroupSwitchButton(
                          titleText: '구성원 TODO(%)',
                          IsChecked: true,
                        ),
                        GroupSwitchButton(
                          titleText: '알람설정',
                          IsChecked: true,
                        ),
                        // GroupInviteItem(invite: ),
                      ],
                    )
                  ),
                ],
              ),
              ],
            ),
        ),
      ),
    );
  }
}
