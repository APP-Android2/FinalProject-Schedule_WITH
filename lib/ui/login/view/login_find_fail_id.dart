import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/widget/main_button.dart';

class LoginFindFailId extends StatefulWidget {
  const LoginFindFailId({super.key});

  @override
  State<LoginFindFailId> createState() => _LoginFindFailIdState();
}

class _LoginFindFailIdState extends State<LoginFindFailId> {
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
                  SvgPicture.asset('lib/assets/icon/icon_cancel.svg',
                  color: mainBrown,
                  width: 25,
                  height: 25,),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  // "고객님의 정보와 일치하는 아이디가" 출력
                  DefaultTextStyle(
                      style: TextStyle(
                          color: mainBrown,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      child: Text("고객님의 정보와 일치하는 아이디가")
                  ),
                  // "존재하지 않습니다." 출력
                  DefaultTextStyle(
                      style: TextStyle(
                          color: mainBrown,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      child: Text(" 존재하지 않습니다.")
                  ),
                ],
              ),
            ),
            // 하단에 위치한 버튼
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: MainButton(
                text: "확인",
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
