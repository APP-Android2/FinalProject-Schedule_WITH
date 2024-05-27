import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:schedule_with/ui/login/view/login_find_success_id.dart';
import 'package:schedule_with/widget/view/main_button.dart';
import '../../../assets/colors/color.dart';
import '../../../widget/view/main_text_field.dart';

class LoginFindIdAndPassword extends StatefulWidget {
  const LoginFindIdAndPassword({super.key});

  @override
  State<LoginFindIdAndPassword> createState() => _LoginFindIdAndPasswordState();
}

class _LoginFindIdAndPasswordState extends State<LoginFindIdAndPassword> {

  var user_name_controller = TextEditingController();
  var user_email_controller = TextEditingController();
  var email_sign_number_controller = TextEditingController();
  var user_id_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset("lib/assets/icon/icon_angel_brackets.svg"),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            "ID/PW 찾기",
            style: TextStyle(color: mainBrown, fontSize: 16,fontWeight: FontWeight.bold),
          ),
        )
      ),
      body: Column(
        children: [
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: mainOrange,
                    tabs: [
                      Tab(
                        text: "아이디 찾기",
                      ),
                      Tab(
                        text: "비밀번호 찾기",
                      )
                    ],
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: mainOrange,
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: TextStyle(
                      color: grey3,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // 아이디 찾기 탭 내용
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // 이름 입력
                              MainTextField(
                                labelText: "이름",
                                hintText: "이름을 입력해 주세요",
                                controller: user_name_controller,
                              ),
                              Padding(padding: EdgeInsets.only(top: 15)),
                              // 이메일 입력 및 코드발송 버튼
                              Row(
                                children: [
                                  // 이메일 입력
                                  Expanded(
                                    child: MainTextField(
                                      labelText: "이메일",
                                      hintText: "이메일을 입력해 주세요.",
                                      controller: user_email_controller,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  miniButton("코드 발송", mainOrange),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 15)),
                              // 인증 코드 입력
                              MainTextField(
                                labelText: "인증 코드",
                                hintText: "인증 코드를 입력해 주세요.",
                                controller: email_sign_number_controller,
                              ),
                              Padding(padding: EdgeInsets.only(top: 15)),
                              Spacer(),
                              // 확인 버튼
                              MainButton(
                                  text: "확인",
                                  onPressed: () {
                                    // 아이디가 존재하면
                                    Get.toNamed("/findSuccessId");
                                    // 아이디가 존재하지 않으면
                                    // Get.toNamed("/findFailId");
                                  },
                                  color: mainOrange
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 20)),
                            ],
                          ),
                        ),
                        // 비밀번호 찾기 탭 내용
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // 이름 입력
                              MainTextField(
                                labelText: "아이디",
                                hintText: "아이디를 입력해 주세요",
                                controller: user_id_controller,
                              ),
                              Padding(padding: EdgeInsets.only(top: 15)),
                              // 이메일 입력 및 코드발송 버튼
                              Row(
                                children: [
                                  // 이메일 입력
                                  Expanded(
                                    child: MainTextField(
                                      labelText: "이메일",
                                      hintText: "이메일을 입력해 주세요.",
                                      controller: user_email_controller,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  miniButton("코드 발송", mainOrange),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 15)),
                              // 인증 코드 입력
                              MainTextField(
                                labelText: "인증 코드",
                                hintText: "인증 코드를 입력해 주세요.",
                                controller: email_sign_number_controller,
                              ),
                              Padding(padding: EdgeInsets.only(top: 15)),
                              Spacer(),
                              // 확인 버튼
                              MainButton(
                                  text: "확인",
                                  onPressed: () {
                                    Get.toNamed("/passwordReset");
                                  },
                                  color: mainOrange
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
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
// 중복확인 및 코드 발송 버튼 위젯
Widget miniButton(String text, Color color){
  return SizedBox(
    height: 45,
    width: 100,
    child: TextButton(
      onPressed: () {

      },
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold
        ), // 텍스트 색상
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color), // 배경색 설정
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10)), // 패딩 설정
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    ),
  );
}
