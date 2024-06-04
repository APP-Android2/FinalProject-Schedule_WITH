import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/group/view/group_main.dart';
import 'package:schedule_with/ui/alarm/view/alram_main.dart';

import 'package:schedule_with/ui/group/view/group_freind_add.dart';
import 'package:schedule_with/ui/group/view/group_invite.dart';

import 'package:schedule_with/ui/group/view/search_friend.dart';

import 'package:schedule_with/ui/home/view/home_main.dart';
import 'package:schedule_with/ui/login/view/login_main.dart';
import 'package:schedule_with/ui/mypage/view/my_page_main.dart';
import 'package:schedule_with/ui/schedule/view/schedule_main.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomNavigationBarController extends GetxController {
  var tabIndex = 2.obs;
}

class MainBottomNavigationBar extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MainBottomNavigationBar();

}
class _MainBottomNavigationBar extends State<MainBottomNavigationBar>{

  @override void initState() {
    controller.tabIndex = 2.obs;
    super.initState();
  }

  final BottomNavigationBarController controller = Get.put(BottomNavigationBarController());

  final List<Widget> pages = [
    // 친구/그룹 목록 메인 화면
    GroupMain(),
    // 캘린더 메인 화면
    ScheduleMain(),
    // 홈 메인 화면
    HomeMain(),
    // 알람 메인 화면
    AlarmMain(),
    // 더보기 메인 화면
    MyPageMain(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: pages[controller.tabIndex.value], // 현재 선택된 페이지 표시
        bottomNavigationBar: Container(
          child: StylishBottomBar(
            option: DotBarOptions(
                dotStyle: DotStyle.tile,
                iconSize: 30
            ),
            backgroundColor: Colors.white,
            currentIndex: controller.tabIndex.value, // 현재 선택된 탭의 인덱스
            onTap: (index) {
              controller.tabIndex.value = index; // 탭을 누르면 인덱스 변경
            },
            items: [
              BottomBarItem(
                  icon: SvgPicture.asset("lib/assets/icon/icon_group_outline.svg"),
                  title: Text("친구/그룹"),
                  selectedColor: mainBrown
              ),
              BottomBarItem(
                  icon: SvgPicture.asset("lib/assets/icon/icon_calender_outline.svg"),
                  title: Text("캘린더"),
                  selectedColor: mainBrown
              ),
              BottomBarItem(
                  icon: SvgPicture.asset("lib/assets/icon/icon_home_outline.svg"),
                  title: Text("홈"),
                  selectedColor: mainBrown
              ),
              BottomBarItem(
                  icon: SvgPicture.asset("lib/assets/icon/icon_alarm_outline.svg"),
                  title: Text("알람"),
                  selectedColor: mainBrown
              ),
              BottomBarItem(
                  icon: SvgPicture.asset("lib/assets/icon/icon_meatball_menu.svg"),
                  title: Text("더보기"),
                  selectedColor: mainBrown
              ),


            ],
          ),
        ),
      );
    });
  }
}
