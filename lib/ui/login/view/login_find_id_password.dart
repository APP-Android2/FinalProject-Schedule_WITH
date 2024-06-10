import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:schedule_with/domain/repository/user_repository.dart';
import 'package:schedule_with/entity/user_tbl.dart';
import 'package:schedule_with/ui/login/view/login_find_success_id.dart';
import 'package:schedule_with/ui/login/widget/mini_button.dart';
import 'package:schedule_with/widget/main_button.dart';
import '../../../assets/colors/color.dart';
import '../../../widget/main_text_field.dart';

class LoginFindIdAndPassword extends StatefulWidget {
  const LoginFindIdAndPassword({super.key});

  @override
  State<LoginFindIdAndPassword> createState() => _LoginFindIdAndPasswordState();
}

class _LoginFindIdAndPasswordState extends State<LoginFindIdAndPassword> {

  UserRepository userRepository = UserRepository();

  late Users? users;

  var user_name_controller = TextEditingController();
  var user_email_controller = TextEditingController();
  var email_sign_number_controller = TextEditingController();
  var user_id_controller = TextEditingController();

  FocusNode user_id_focus = FocusNode();
  FocusNode user_name_focus = FocusNode();
  FocusNode user_email_focus = FocusNode();
  FocusNode email_sign_number_focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
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
                                textInputAction: TextInputAction.next,
                                focusNode: user_name_focus,
                                textInputType: TextInputType.text,
                                obscureText: false,
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
                                      textInputAction: TextInputAction.next,
                                      focusNode: user_email_focus,
                                      textInputType: TextInputType.emailAddress,
                                      obscureText: false,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  MiniButton(
                                      onPressed: () {

                                      },
                                      text: "코드 발송",
                                      color: mainOrange
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 15)),
                              // 인증 코드 입력
                              MainTextField(
                                labelText: "인증 코드",
                                hintText: "인증 코드를 입력해 주세요.",
                                controller: email_sign_number_controller,
                                textInputAction: TextInputAction.done,
                                focusNode: email_sign_number_focus,
                                textInputType: TextInputType.text,
                                obscureText: false,
                              ),
                              Padding(padding: EdgeInsets.only(top: 15)),
                              Spacer(),
                              // 확인 버튼
                              MainButton(
                                  text: "확인",
                                  onPressed: () async {

                                    // 작성한 이메일을 이용해 유저 정보를 가져온다.
                                    users = await userRepository.getUserInfoUseEmail(user_email_controller.text);

                                    // 이름입력란이 비어있다면..
                                    if(user_name_controller.text == ""){
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
                                                  TextSpan(text: " 이름",style: TextStyle(color: mainOrange,fontSize: 16)),
                                                  TextSpan(text: "을\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                                                  TextSpan(text: "입력해 주세요.",style: TextStyle(color: Colors.white,fontSize: 16))
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
                                    else if(user_email_controller.text == ""){
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
                                                  TextSpan(text: " 이메일",style: TextStyle(color: mainOrange,fontSize: 16)),
                                                  TextSpan(text: "을\n",style: TextStyle(color: Colors.white,fontSize: 16)),
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
                                    else {
                                      if(users == null || users?.name != user_name_controller.text){
                                        // 유저정보가 존재하지 않으면
                                        Get.toNamed("/findFailId");
                                      }
                                      else{
                                        // 유저정보가 존재하면
                                        Get.toNamed("/findSuccessId",arguments: users?.id);
                                      }
                                    }
                                  },
                                  color: mainOrange
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 30)),
                            ],
                          ),
                        ),
                        // 비밀번호 찾기 탭 내용
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // 아이디 입력
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
                              // 이메일 입력 및 코드발송 버튼
                              Row(
                                children: [
                                  // 이메일 입력
                                  Expanded(
                                    child: MainTextField(
                                      labelText: "이메일",
                                      hintText: "이메일을 입력해 주세요.",
                                      controller: user_email_controller,
                                      textInputAction: TextInputAction.next,
                                      focusNode: user_email_focus,
                                      textInputType: TextInputType.emailAddress,
                                      obscureText: false,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  MiniButton(
                                      onPressed: () {

                                      },
                                      text: "코드 발송",
                                      color: mainOrange
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 15)),
                              // 인증 코드 입력
                              MainTextField(
                                labelText: "인증 코드",
                                hintText: "인증 코드를 입력해 주세요.",
                                controller: email_sign_number_controller,
                                textInputAction: TextInputAction.done,
                                focusNode: email_sign_number_focus,
                                textInputType: TextInputType.text,
                                obscureText: false,
                              ),
                              Padding(padding: EdgeInsets.only(top: 15)),
                              Spacer(),
                              // 확인 버튼
                              MainButton(
                                  text: "확인",
                                  onPressed: () async {
                                    // 아이디가 존재하는지 확인한다.
                                    users = await userRepository.getUserInfoUseId(user_id_controller.text);

                                    // 아이디 입력란이 비어있다면..
                                    if(user_id_controller.text == ""){
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
                                    else if(user_email_controller.text == ""){
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
                                                  TextSpan(text: " 이메일",style: TextStyle(color: mainOrange,fontSize: 16)),
                                                  TextSpan(text: "을\n",style: TextStyle(color: Colors.white,fontSize: 16)),
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
                                      if(users == null || users?.email != user_email_controller.text){
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
                                                    TextSpan(text: " 작성한 ",style: TextStyle(color: mainOrange,fontSize: 16)),
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
                                      }
                                      else{
                                        Get.toNamed("/passwordReset",arguments: users);
                                      }
                                    }


                                  },
                                  color: mainOrange
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 30)),
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

