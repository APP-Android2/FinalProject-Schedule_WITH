import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/widget/main_button.dart';

import '../../../widget/main_text_field.dart';

class LoginPasswordReset extends StatefulWidget {
  const LoginPasswordReset({super.key});

  @override
  State<LoginPasswordReset> createState() => _LoginPasswordResetState();
}

class _LoginPasswordResetState extends State<LoginPasswordReset> {

  var user_password_controller = TextEditingController();
  var user_password_check_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PW 재설정 화면
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // 텍스트 및 인풋 설정
            Expanded(
                // 텍스트 및 인풋 설정
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // "비밀번호" + "재설정" 텍스트 출력
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // "비밀번호" 텍스트 출력
                          Text(
                              "비밀번호",
                            style: TextStyle(
                              color: mainOrange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          // "재설정" 텍스트 출력
                          Text(
                            " 재설정",
                            style: TextStyle(
                                color: mainBrown,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      // "보안 수준이 높은 비밀번호 만들기" 텍스트 출력
                      Text(
                          "보안 수준이 높은 비밀번호 만들기",
                        style: TextStyle(
                          color: mainBrown,
                          fontSize: 14,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 30)),
                      // 비밀번호 입력
                      MainTextField(
                        labelText: "비밀번호",
                        hintText: "8자이상, 영문 대/소문자, 숫자, 특수문자 2가지 이상 조합",
                        controller: user_password_controller,
                        textInputAction: TextInputAction.next,
                      ),
                      Padding(padding: EdgeInsets.only(top: 15)),
                      // 비밀번호 확인 입력
                      MainTextField(
                        labelText: "비밀번호 확인",
                        hintText: "8자이상, 영문 대/소문자, 숫자, 특수문자 2가지 이상 조합",
                        controller: user_password_check_controller,
                        textInputAction: TextInputAction.done,
                      ),
                      
                    ],
                  ),
                )
            ),
            // 비밀번호 변경 버튼 설정
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: MainButton(
                  text: "비밀번호 변경",
                  onPressed: () {
                    // 비밀번호 입력과 비밀번호 확인 입력이 맞을 시 다음 화면 이동
                    Get.offNamed("/passwordResetDone");
                  },
                  color: mainOrange
              ),
            )
          ],
        ),
      ),
    );
  }
}
