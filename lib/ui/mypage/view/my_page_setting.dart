import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:schedule_with/ui/mypage/widget/my_page_switch_buttton.dart';

import '../../../assets/colors/color.dart';

class MyPageSetting extends StatefulWidget {
  const MyPageSetting({super.key});

  @override
  State<MyPageSetting> createState() => _MyPageSettingState();
}

class _MyPageSettingState extends State<MyPageSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 툴바
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          // 뒤로가기 버튼
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(CupertinoIcons.back,color: grey4),
            onPressed: () {
              Get.back();
            },
          ),
          // 타이틀
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "설정",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ),
      ),
      // 설정 화면 내용들
      body: Column(
        children: [
          // 친구/그룹 신청 알림 받기
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("친구/그룹 신청 알림 받기",style: TextStyle(fontSize: 16)),
                MyPageSwitchButton()
              ],
            ),
          ),
          // 그룹 신규 소식 알림 받기
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("그룹 신규 소식 알림 받기",style: TextStyle(fontSize: 16)),
                MyPageSwitchButton()
              ],
            ),
          ),
          // 접근 권한 설정
          InkWell(
            onTap: () {
              openAppSettings();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("접근 권한 설정",style: TextStyle(fontSize: 16)),
                  SvgPicture.asset(
                    'lib/assets/icon/icon_detail_open.svg',
                    width: 7,
                    height: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
