import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/mypage/widget/my_page_divider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widget/main_alert.dart';
import '../../../widget/main_app_bar.dart';

class MyPageMain extends StatefulWidget {
  const MyPageMain({super.key});

  @override
  State<MyPageMain> createState() => _MyPageMainState();
}

class _MyPageMainState extends State<MyPageMain> {
  Future<bool> _getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id') != null;
  }

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
      body: FutureBuilder<bool>(
        future: _getId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            bool hasId = snapshot.data ?? false;
            return Column(
              children: [
                // 프로필 사진 + 닉네임 + 상세내용 보기 아이콘 + 화면이동 설정
                InkWell(
                  onTap: () async {
                    hasId ? Get.toNamed('/myPageInfoModify') : Get.toNamed('/login');
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
                            Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    border: Border.all(color: grey2, width: 0.5)),
                                margin: EdgeInsets.only(bottom: 5),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: SvgPicture.asset("lib/assets/icon/icon_profile.svg", color: genderMale))),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Text("닉네임", style: TextStyle(fontSize: 16))
                          ],
                        ),
                        // 상세내용 아이콘 설정
                        SvgPicture.asset("lib/assets/icon/icon_detail_open.svg")
                      ],
                    ),
                  ),
                ),
                // 디바이더 설정
                MyPageDivider(verticalPadding: 0, horizontalPadding: 10),
                // 설정 화면 이동 + "설정" 텍스트 설정
                InkWell(
                  // 설정 화면 이동
                  onTap: () {
                    // 설정 화면 이동
                    Get.toNamed('/myPageSetting');
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
                    Get.toNamed('/myPageNotice');
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
                    // 정보 화면 이동
                    Get.toNamed('/myPageReadTerms');
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
                    // 문의 화면 이동
                    Get.toNamed('/myPageInquiry');
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
                MyPageDivider(verticalPadding: 0, horizontalPadding: 10),
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
                hasId
                    ? InkWell(
                  // 로그아웃 팝업창 설정
                  onTap: () {
                    // 로그아웃 팝업창
                    Get.dialog(
                      barrierDismissible: false,
                      MainAlert(
                        msg: "로그아웃 하시겠습니까?",
                        YesMsg: "예",
                        NoMsg: "아니오",
                      ),
                    );
                  },
                  // "로그아웃" 텍스트 설정
                  child: Container(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                      child: Text("로그아웃"),
                    ),
                  ),
                )
                    : Container()
              ],
            );
          }
        },
      ),
    );
  }
}
