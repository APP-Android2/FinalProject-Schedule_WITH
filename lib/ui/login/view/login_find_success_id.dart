import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/widget/main_button.dart';

class LoginFindSuccessId extends StatefulWidget {
  const LoginFindSuccessId({super.key});

  @override
  State<LoginFindSuccessId> createState() => _LoginFindSuccessIdState();
}

class _LoginFindSuccessIdState extends State<LoginFindSuccessId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // 중앙에 위치한 텍스트
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('lib/assets/icon/icon_done.svg'),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  // "고객님의 정보와 일치하는 아이디는" 출력
                  DefaultTextStyle(
                      style: TextStyle(
                          color: mainBrown,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      child: Text("고객님의 정보와 일치하는 아이디는")
                  ),
                  // 회원의 아이디 및 "입니다" 출력
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 회원의 아이디 출력
                      DefaultTextStyle(
                          style: TextStyle(
                              color: mainOrange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                          child: Text("qwer${1234}")
                      ),
                      // "입니다" 출력
                      DefaultTextStyle(
                          style: TextStyle(
                              color: mainBrown,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                          child: Text("  입니다")
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 하단에 위치한 버튼
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: MainButton(
                text: "로그인",
                onPressed: () {
                  Get.offAllNamed("/login");
                },
                color: mainOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
