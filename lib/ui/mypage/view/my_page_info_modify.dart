import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/mypage/widget/my_page_divider.dart';
import 'package:schedule_with/ui/mypage/widget/nick_name_controller.dart';
import 'package:schedule_with/widget/main_profile.dart';

import '../../../widget/main_alert.dart';

class MyPageInfoModify extends StatefulWidget {
  const MyPageInfoModify({super.key});

  @override
  State<MyPageInfoModify> createState() => _MyPageInfoModifyState();
}

class _MyPageInfoModifyState extends State<MyPageInfoModify> {
  final NickNameController _nickNameController = Get.put(NickNameController());

  final TextEditingController nickname = TextEditingController();

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
              "개인정보 수정",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // 완료 버튼
          actions: [
            InkWell(
              onTap: () {
                _nickNameController.setNickNameChangeState(false);
                print("${nickname.text}");
                // 스낵바 노출
                Get.snackbar(
                  duration: Duration(seconds: 2),
                    // Title
                    "",
                    // Message
                    "",
                  // Title커스텀 Title이 있을 시 TitleText를 이용을 함
                  titleText: SizedBox.shrink(),
                  // Message커스텀 Message가 있을 시 MessageText를 이용함
                  messageText: RichText(
                    textAlign: TextAlign.center,
                      text: TextSpan(
                        children:[
                          TextSpan(text: "개인정보 수정이\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                          TextSpan(text: " 완료",style: TextStyle(color: mainOrange,fontSize: 16)),
                          TextSpan(text: "되셨습니다.",style: TextStyle(color: Colors.white,fontSize: 16))
                        ]
                      )
                  ),
                  // 스낵바 위치
                  snackPosition: SnackPosition.BOTTOM,
                  // 스낵바를 중앙에 배치하기 위해 margin 설정
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 2),
                  // 스낵바 너비 설정
                  maxWidth: 300,
                  // 스낵바 배경의 투명도를 설정
                  backgroundColor: Colors.black.withOpacity(0.5),
                  // 스낵바가 나타날 때 애니메이션
                  forwardAnimationCurve: Curves.easeOutCirc,
                  // 스낵바가 사라질 때 애니메이션
                  reverseAnimationCurve: Curves.easeOutCirc,
                );
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 8),
                child: Text("완료",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: mainOrange)),
              ),
            )
          ],
        ),
      ),
      // 개인정보 수정 화면
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // 프로필 배경 및 프로필 사진 및 이름 + 수정 아이콘 설정
              Expanded(
                  flex: 3,
                  child: MainProfile()
              ),
              // 개인 정보 내용들 및 탈퇴하기 버튼
              Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      children: [
                        // 아이디
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("아이디",style: TextStyle(fontSize: 12)),
                            Text("qwer1234",style: TextStyle(fontSize: 14))
                          ],
                        ),
                        // 디바이더 설정
                        MyPageDivider(verticalPadding: 15,horizontalPadding: 0),
                        // 이메일
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("이메일",style: TextStyle(fontSize: 12)),
                            Text("qwer1234@naver.com",style: TextStyle(fontSize: 14))
                          ],
                        ),
                        // 디바이더 설정
                        MyPageDivider(verticalPadding: 15,horizontalPadding: 0),
                        // 생년월일
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("생년월일",style: TextStyle(fontSize: 12)),
                            Text("1997년 07월 03일",style: TextStyle(fontSize: 14))
                          ],
                        ),
                        // 디바이더 설정
                        MyPageDivider(verticalPadding: 15,horizontalPadding: 0),
                        // 성별
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("성별",style: TextStyle(fontSize: 12)),
                            Text("여성",style: TextStyle(fontSize: 14))
                          ],
                        ),
                        // 디바이더 설정
                        MyPageDivider(verticalPadding: 15,horizontalPadding: 0),
                        // 비밀번호
                        Row(
                          children: [
                            // 비밀번호 텍스트
                            Padding(
                              padding: EdgeInsets.only(right: 27),
                              child: Text("비밀번호",style: TextStyle(fontSize: 12)),
                            ),
                            // 비밀번호 입력란
                            Expanded(
                                child: SizedBox(
                                  height: 20,
                                  child: TextField(
                                    textAlign: TextAlign.right,
                                    cursorColor: mainOrange,
                                    style: TextStyle(
                                        decorationThickness: 0,
                                        fontSize: 14
                                    ),
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        enabled: true,
                                        focusedBorder: InputBorder.none,
                                        hintText: "8~20자, 영문 대/소문자, 숫자, 특수문자 중 2가지 이상 조합",
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: grey4
                                        )
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),
                        // 디바이더 설정
                        MyPageDivider(verticalPadding: 15,horizontalPadding: 0),
                        // 비밀번호 확인
                        Row(
                          children: [
                            // 비밀번호 텍스트
                            Padding(
                              padding: EdgeInsets.only(right: 27),
                              child: Text("비밀번호 확인",style: TextStyle(fontSize: 12)),
                            ),
                            // 비밀번호 입력란
                            Expanded(
                                child: SizedBox(
                                  height: 20,
                                  child: TextField(
                                    textAlign: TextAlign.right,
                                    cursorColor: mainOrange,
                                    style: TextStyle(
                                        decorationThickness: 0,
                                        fontSize: 14
                                    ),
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        enabled: true,
                                        focusedBorder: InputBorder.none,
                                        hintText: "비밀번호와 동일하게 입력해 주세요.",
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: grey4
                                        )
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),
                        // 디바이더 설정
                        MyPageDivider(verticalPadding: 15,horizontalPadding: 0),
                        Spacer(),
                        // 탈퇴하기 설정
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: InkWell(
                              onTap: () {
                                // 탈퇴 팝업창
                                Get.dialog(
                                  barrierDismissible: false,
                                  MainAlert(
                                    msg: "탈퇴하기\n 탈퇴 시 이용기록은 모두 삭제되며,\n삭제된 데이터는 복구되지 않습니다.\n탈퇴하시겠습니까?",
                                    YesMsg: "예",
                                    NoMsg: "아니오",
                                  )
                                );
                              },
                              child: Text("탈퇴하기",style: TextStyle(fontSize: 12,color: grey4)),
                            )
                          ),
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      )
    );
  }
}
