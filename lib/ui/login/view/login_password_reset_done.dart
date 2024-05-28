import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../assets/colors/color.dart';
import '../../../widget/view/main_button.dart';

class LoginPasswordResetDone extends StatefulWidget {
  const LoginPasswordResetDone({super.key});

  @override
  State<LoginPasswordResetDone> createState() => _LoginPasswordResetDoneState();
}

class _LoginPasswordResetDoneState extends State<LoginPasswordResetDone> {
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
                  // 회원의 아이디 및 "입니다" 출력
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // "비밀번호 변경이 " 출력
                      DefaultTextStyle(
                          style: TextStyle(
                              color: mainBrown,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                          child: Text("비밀번호 변경이 ")
                      ),
                      // "완료" 텍스트 출력
                      DefaultTextStyle(
                          style: TextStyle(
                              color: mainOrange,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                          child: Text("완료")
                      ),
                      // "되었습니다" 텍스트 출력
                      DefaultTextStyle(
                          style: TextStyle(
                              color: mainBrown,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                          child: Text("되었습니다")
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
