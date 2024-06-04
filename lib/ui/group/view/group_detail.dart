import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/group/view/group_main.dart';
import 'package:schedule_with/widget/group_profile.dart';
import 'package:schedule_with/widget/main_profile.dart';
import 'package:schedule_with/widget/main_tab_bar.dart';

class GroupDetail extends StatefulWidget {
  const GroupDetail({super.key});

  @override
  State<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(50),
        //   child:
        // ),
        body: Stack(
          children: [
            Column(
              children: [
                Flexible(
                  flex: 2,
                  child:GroupProfile(groupName: "인천 모임",),
                ),
                SizedBox(height: 20,),
                Flexible(
                  flex: 3,
                  child:
                  MainTabBar(),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 20,
              child: IconButton(
                onPressed: (){
                  Get.back();
                  // Get.go(GroupMain());
                },
                icon: Icon(Icons.close, size: 30, color: grey4,)
                        ),
            ),
          ],
        ),
        ),
    );
  }
}
