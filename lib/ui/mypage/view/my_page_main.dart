import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/widget/main_button.dart';

import '../../../widget/main_app_bar.dart';

class MyPageMain extends StatefulWidget {
  const MyPageMain({super.key});

  @override
  State<MyPageMain> createState() => _MyPageMainState();
}

class _MyPageMainState extends State<MyPageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 화면 배경색 설정
      backgroundColor: Colors.white,
      // 상단 툴바
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MainAppBar(),
      ),
      body: Column(
        children: [
          // 프로필 사진 + 닉네임 + 상세내용 보기 아이콘 + 화면이동 설정
          InkWell(
            onTap: () {
              // 개인정보 수정 화면으로 이동
              Get.toNamed('/myPageInfoModify');
            },
            // 프로필 사진 + 닉네임 + 상세내용 보기 아이콘 설정
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 프로필 사진 + 닉네임 설정
                  Row(
                    children: [
                      SvgPicture.asset(
                          "lib/assets/icon/icon_profile.svg",
                          color: genderMale
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Text("닉네임",style: TextStyle(fontSize: 16))
                    ],
                  ),
                  // 상세내용 아이콘 설정
                  SvgPicture.asset("lib/assets/icon/icon_detail_open.svg")
                ],
              ),
            ),
          ),
          // 디바이더 설정
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
              height: 1,
              color: grey2,
            ),
          ),
          // 설정 화면 이동 + "설정" 텍스트 설정
          InkWell(
            // 설정 화면 이동
            onTap: () {
              // 설정 화면 이동
            },
            // "설정" 텍스트 설정
            child: Container(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                child: Text("설정"),
              ),
            ),
          ),
          // 공지사항 화면 이동 + "공지사항" 텍스트 설정
          InkWell(
            // 공지사항 화면 이동
            onTap: () {
              // 설정 화면 이동
            },
            // "공지사항" 텍스트 설정
            child: Container(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                child: Text("공지사항"),
              ),
            ),
          ),
          // 정보 화면 이동 + "정보" 텍스트 설정
          InkWell(
            // 정보 화면 이동
            onTap: () {
              // 설정 화면 이동
            },
            // "정보" 텍스트 설정
            child: Container(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                child: Text("정보"),
              ),
            ),
          ),
          // 문의 화면 이동 + "문의" 텍스트 설정
          InkWell(
            // 문의 화면 이동
            onTap: () {
              // 설정 화면 이동
            },
            // "문의" 텍스트 설정
            child: Container(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                child: Text("문의"),
              ),
            ),
          ),
          // 디바이더 설정
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
              height: 0.5,
              color: grey2,
            ),
          ),
          // 버전 정보 + "버전" 텍스트 설정
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
            // 버전 정보 + "버전" 텍스트 설정
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("버전"),
                Text("1.1.1")
              ],
            ),
          ),
          // 로그아웃 팝업창 + "로그아웃" 텍스트 설정
          InkWell(
            // 로그아웃 팝업창 설정
            onTap: () {
              // 로그아웃 팝업창
            },
            // "로그아웃" 텍스트 설정
            child: Container(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                child: Text("로그아웃"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

