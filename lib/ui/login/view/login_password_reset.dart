import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/domain/repository/user_repository.dart';
import 'package:schedule_with/entity/user_tbl.dart';
import 'package:schedule_with/widget/main_button.dart';

import '../../../widget/main_text_field.dart';
import '../widget/password_check_text_field.dart';
import '../widget/password_text_field.dart';

class LoginPasswordReset extends StatefulWidget {
  const LoginPasswordReset({super.key});

  @override
  State<LoginPasswordReset> createState() => _LoginPasswordResetState();
}

class _LoginPasswordResetState extends State<LoginPasswordReset> {

  UserRepository userRepository = UserRepository();

  var user_password_controller = TextEditingController();
  var user_password_check_controller = TextEditingController();

  FocusNode user_password_focus = FocusNode();
  FocusNode user_password_check_focus = FocusNode();

  Users users = Get.arguments;

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
                      // 비밀번호 입력
                      PasswordTextField(
                        labelText: "비밀번호",
                        hintText: "8자이상, 영문 대/소문자, 숫자, 특수문자 2가지 이상 조합",
                        controller: user_password_controller,
                        textInputAction: TextInputAction.next,
                        focusNode: user_password_focus,
                      ),
                      Padding(padding: EdgeInsets.only(top: 15)),
                      // 비밀번호 확인 입력
                      PasswordCheckTextField(
                        labelText: "비밀번호 확인",
                        hintText: "8자이상, 영문 대/소문자, 숫자, 특수문자 2가지 이상 조합",
                        controller: user_password_check_controller,
                        textInputAction: TextInputAction.next,
                        focusNode: user_password_check_focus,
                        check_controller: user_password_controller,
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
                  onPressed: () async {
                    // 비밀번호에 대한 유효성 검사를 해준다.
                    // 비밀번호 유효성 검사를 해준다.
                    if(PasswordErrorSingleton().passwordError != null || user_password_controller.text == ""
                        || CheckPasswordErrorSingleton().passwordError != null || user_password_check_controller.text == ""){
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
                                  TextSpan(text: " 비밀번호",style: TextStyle(color: mainOrange,fontSize: 16)),
                                  TextSpan(text: "가\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                                  TextSpan(text: "맞지 않습니다.",style: TextStyle(color: Colors.white,fontSize: 16))
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
                    }
                    else{
                      // 바뀐 비밀번호와 로그인 실패 횟수를 0으로 초기화 한다.
                      // 회원 상태를 Y로 변경한다.
                      users.pw = user_password_controller.text;
                      users.login_fail_cnt = 0;
                      users.status = "Y";

                      // 바뀐 회원 정보를 업데이트 한다.
                      await userRepository.updateUserInfo(users, users.idx);

                      // 비밀번호 입력과 비밀번호 확인 입력이 맞을 시 다음 화면 이동
                      Get.offNamed("/passwordResetDone");
                    }

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
