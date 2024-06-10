import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/home/view/home_main.dart';
import 'package:schedule_with/widget/main_button.dart';
import 'package:schedule_with/widget/main_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/repository/user_repository.dart';
import '../../../entity/user_tbl.dart';
import '../../../main.dart';
import '../../../widget/main_bottom_navigation_bar.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  State<LoginMain> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginMain> {

  UserRepository userRepository = UserRepository();
  var user_id_controller = TextEditingController();
  var user_password_controller = TextEditingController();

  late Users? users;

  FocusNode user_id_focus = FocusNode();
  FocusNode user_password_focus = FocusNode();

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
                        focusNode: user_id_focus,
                        textInputType: TextInputType.text,
                        obscureText: false,
                      ),
                      Padding(padding: EdgeInsets.only(top: 15)),
                      // 비밀번호 입력 TextField
                      MainTextField(
                        labelText: "비밀번호",
                        hintText: "비밀번호를 입력해 주세요",
                        controller: user_password_controller,
                        textInputAction: TextInputAction.done,
                        focusNode: user_password_focus,
                        textInputType: TextInputType.text,
                        obscureText: true,
                      ),
                      Padding(padding: EdgeInsets.only(top: 15)),
                      // 로그인 버튼
                      MainButton(
                        text: "로그인",
                        onPressed: () async {
                          // 아이디가 존재하는지 여부를 확인한다.
                          var check = await userRepository.doubleCheckId(user_id_controller.text);

                          // id와 동일한 유저 정보를 가져온다.
                          users = await userRepository.getUserInfoUseId(user_id_controller.text);

                          // 아이디 필드가 비어있을 때 유효성 검사를 해준다.
                          if(user_id_controller.text == ""){
                            // 아이디 입력하라는 스낵바 노출
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
                                        TextSpan(text: " 아이디",style: TextStyle(color: mainOrange,fontSize: 16)),
                                        TextSpan(text: "를\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                                        TextSpan(text: "작성해 주세요.",style: TextStyle(color: Colors.white,fontSize: 16))
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
                          // 비밀번호 필드가 비어있을 때 유효성 검사를 해준다.
                          else if(user_password_controller.text == ""){
                            // 비밀번호 입력하라는 스낵바 노출
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
                                        TextSpan(text: "를\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                                        TextSpan(text: "작성해 주세요.",style: TextStyle(color: Colors.white,fontSize: 16))
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

                            // 아이디가 존재하지 않다면..
                            if(check){
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
                                          TextSpan(text: " 아이디",style: TextStyle(color: mainOrange,fontSize: 16)),
                                          TextSpan(text: "정보가\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                                          TextSpan(text: "업성요.",style: TextStyle(color: Colors.white,fontSize: 16))
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
                            // 아이디가 존재한다면..
                            else{
                              // 비밀번호 유효성 검사를 해준다.
                              // 비밀번호가 옳지 않다면..
                              if(users?.pw != user_password_controller.text){

                                // 로그인 실패 횟수가 5이상이면..
                                if(users!.login_fail_cnt >= 5){
                                  // 아이디 입력하라는 스낵바 노출
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
                                              TextSpan(text: "[잠긴 회원입니다.]\n",style: TextStyle(color: mainOrange,fontSize: 16)),
                                              TextSpan(text: "비밀번호 찾기 후\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                                              TextSpan(text: "다시 시도해 주세요.",style: TextStyle(color: Colors.white,fontSize: 16))
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
                                  // 회원 상태를 정지상태로 변경한다.
                                  users?.status = "S";
                                  // 회원 정보를 업데이트 한다.
                                  userRepository.updateUserInfo(users!, users!.idx);
                                }
                                else{
                                  // 비밀번호가 틀렸다는 스낵바 노출
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
                                              TextSpan(text: "정보가\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                                              TextSpan(text: "옳지 않습니다.",style: TextStyle(color: Colors.white,fontSize: 16))
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
                                  // login_fail_cnt 값을 1 증가 시킨다.
                                  users?.login_fail_cnt++;
                                  // 유저 정보를 업데이트 한다.
                                  await userRepository.updateUserInfo(users!, users!.idx);
                                }
                              }
                              // 비밀번호까지 잘 작성했다면..
                              else{
                                // 그 유저의 로그인 실패 횟수를 가져온다.
                                // 로그인 실패 횟수가 5이상이면..
                                if(users!.login_fail_cnt >= 5){
                                  // 아이디 입력하라는 스낵바 노출
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
                                              TextSpan(text: "[잠긴 회원입니다.]\n",style: TextStyle(color: mainOrange,fontSize: 16)),
                                              TextSpan(text: "비밀번호 찾기 후\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                                              TextSpan(text: "다시 시도해 주세요.",style: TextStyle(color: Colors.white,fontSize: 16))
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
                                  // 회원 상태를 정지상태로 변경한다.
                                  users?.status = "S";
                                  // 회원 정보를 업데이트 한다.
                                  userRepository.updateUserInfo(users!, users!.idx);
                                }
                                else{
                                  // login_fail_cnt 값을 0으로 초기화 한다.
                                  users?.login_fail_cnt = 0;
                                  // 유저 정보를 업데이트 한다.
                                  await userRepository.updateUserInfo(users!, users!.idx);
                                  // 유저 정보를 로컬파일에 저장한다.
                                  await userRepository.saveLocalUserInfo(users!);
                                  // 홈 화면으로 이동한다.
                                  Get.offAll(() => MainBottomNavigationBar());
                                }
                              }
                            }
                          }


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
                              onTap: () async {
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                if(prefs.getString('server_id') == null){
                                  await userRepository.logoutNewUser();
                                  Get.offAll(() => MainBottomNavigationBar());
                                }
                                else{
                                  Get.offAll(() => MainBottomNavigationBar());
                                }
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
