import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/home/view/home_main.dart';
import 'package:schedule_with/widget/main_button.dart';
import 'package:schedule_with/widget/main_text_field.dart';

import '../../../main.dart';
import '../../../widget/main_bottom_navigation_bar.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  State<LoginMain> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginMain> {
  var user_id_controller = TextEditingController();
  var user_password_controller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [
              // 로고 이미지
              Expanded(
                flex: 2,
                child: Image.asset(
                  'lib/assets/image/logo.png',
                  width: 235,
                  height: 99,
                ),
              ),
              // 입력 필드 및 버튼
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      // 아이디 입력 TextField
                      MainTextField(
                        labelText: "아이디",
                        hintText: "아이디를 입력해 주세요",
                        controller: user_id_controller,
                        textInputAction: TextInputAction.next,
                      ),
                      Padding(padding: EdgeInsets.only(top: 15)),
                      // 비밀번호 입력 TextField
                      MainTextField(
                        labelText: "비밀번호",
                        hintText: "비밀번호를 입력해 주세요",
                        controller: user_password_controller,
                        textInputAction: TextInputAction.done,
                      ),
                      Padding(padding: EdgeInsets.only(top: 15)),
                      // 로그인 버튼
                      MainButton(
                        text: "로그인",
                        onPressed: () {
                          // 로그인 버튼 클릭 시 동작
                          Get.offAll(() => MainBottomNavigationBar());
                        },
                        color: mainOrange,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      // 버튼(회원가입, ID/PW 찾기, 비회원 시작) 설정
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "회원가입",
                                  style: TextStyle(
                                    color: grey4,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Get.toNamed('/join');
                              },
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(
                              color: grey4,
                              fontSize: 10,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "ID / PW 찾기",
                                  style: TextStyle(
                                    color: grey4,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Get.toNamed('/findIdAndPassword');
                              },
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(
                              color: grey4,
                              fontSize: 10,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "비회원으로 시작",
                                  style: TextStyle(
                                    color: grey4,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Get.offAll(() => MainBottomNavigationBar());
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 50)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
