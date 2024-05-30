import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/widget/main_profile.dart';

class MyPageInfoModify extends StatefulWidget {
  const MyPageInfoModify({super.key});

  @override
  State<MyPageInfoModify> createState() => _MyPageInfoModifyState();
}

class _MyPageInfoModifyState extends State<MyPageInfoModify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 툴바 설정
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          // 뒤로가기 버튼
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: SvgPicture.asset("lib/assets/icon/icon_angel_brackets.svg"),
            onPressed: () {
              Get.back();
            },
          ),
          // 타이틀
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "개인정보 수정",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // 완료 버튼
          actions: [
            InkWell(
              onTap: () {

              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 8),
                child: Text("완료",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: mainOrange),),
              ),
            )
          ],
        ),
      ),
      // 개인정보 수정 화면
      body: Column(
        children: [
          // 프로필 배경 및 프로필 사진 및 이름 + 수정 아이콘 설정
          Expanded(
            flex: 2,
              child: MainProfile()
          ),
          Expanded(
            flex: 3,
              child: Container(
                color: Colors.green,
                child: Text("zz"),
              )
          )

        ],
      ),
    );
  }
}
