import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/domain/repository/user_repository.dart';
import 'package:schedule_with/ui/login/view/login_main.dart';
import 'package:schedule_with/ui/login/widget/mini_button.dart';
import 'package:schedule_with/ui/login/widget/password_check_text_field.dart';
import 'package:schedule_with/ui/login/widget/password_text_field.dart';
import 'package:schedule_with/widget/main_bottom_navigation_bar.dart';
import 'package:schedule_with/widget/main_button.dart';
import 'package:schedule_with/widget/main_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../entity/user_tbl.dart';
import '../../../main.dart';

class LoginJoin extends StatefulWidget {
  const LoginJoin({super.key});

  @override
  State<LoginJoin> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<LoginJoin> {
  // textField controller 변수 설정
  var user_name_controller = TextEditingController();
  var user_id_controller = TextEditingController();
  var user_password_controller = TextEditingController();
  var user_password_check_controller = TextEditingController();
  var user_email_controller = TextEditingController();
  var email_sign_number_controller = TextEditingController();
  var user_birth_controller = TextEditingController();
  // 포커스 노드 변수 설정
  FocusNode user_id_focus = FocusNode();
  FocusNode user_name_focus = FocusNode();
  FocusNode user_password_focus = FocusNode();
  FocusNode user_password_check_focus = FocusNode();
  FocusNode user_email_focus = FocusNode();
  FocusNode email_sign_number_focus = FocusNode();
  FocusNode user_birth_focus = FocusNode();
  // 성별 기본 세팅 리스트
  List<bool> isSelected = [true, false];
  // 약관 동의 체크 여부
  bool check = false;

  // 성별 체크 상태 초기 설정 (남)
  String gender = "남";

  late Users user;

  UserRepository userRepository = UserRepository();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 툴바
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          // 뒤로가기 버튼
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: SvgPicture.asset("lib/assets/icon/icon_angel_brackets.svg"),
            onPressed: () {
              Get.back();
            },
          ),
          // 타이틀
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "회원가입",
              style: TextStyle(color: mainBrown, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ),
      ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
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
                  // 아이디 입력 및 중복 버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 아이디 입력
                      Expanded(
                        child: MainTextField(
                          labelText: "아이디",
                          hintText: "아이디를 입력해 주세요.",
                          controller: user_id_controller,
                          textInputAction: TextInputAction.next,
                          focusNode: user_id_focus,
                          textInputType: TextInputType.text,
                          obscureText: false,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      MiniButton(
                          text: "중복확인",
                          onPressed: () async {

                            print("check : ${user_id_controller.text}");

                            // 중복확인을 해준다.
                            var check = await userRepository.doubleCheckId(user_id_controller.text);

                            // 중복되지 않는다면..
                            if(check){
                              // 사용가능하다는 스낵바 노출
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
                                          TextSpan(text: "사용가능한\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                                          TextSpan(text: " 아이디",style: TextStyle(color: mainOrange,fontSize: 16)),
                                          TextSpan(text: "입니다.",style: TextStyle(color: Colors.white,fontSize: 16))
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
                              // 중복된다는 스낵바 노출
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
                                          TextSpan(text: "중복된\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                                          TextSpan(text: " 아이디",style: TextStyle(color: mainOrange,fontSize: 16)),
                                          TextSpan(text: "입니다.",style: TextStyle(color: Colors.white,fontSize: 16))
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
                              // 다시 작성을 위해 필드를 비워준다.
                              user_id_controller.text = "";
                              // 아이디 필드에 포커스를 준다.
                              FocusScope.of(context).requestFocus(user_id_focus);
                            }
                          },
                          color: mainOrange
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
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
                  Padding(padding: EdgeInsets.only(top: 50)),
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
                          text: "코드 발송",
                          onPressed: () {

                          },
                          color: mainOrange
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  // 인증 코드 입력
                  MainTextField(
                    labelText: "인증 코드",
                    hintText: "인증 코드를 입력해 주세요.",
                    controller: email_sign_number_controller,
                    textInputAction: TextInputAction.next,
                    focusNode: email_sign_number_focus,
                    textInputType: TextInputType.text,
                    obscureText: false,
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  // 생년월일 입력 및 성별 선택
                  Container(
                    height: 45,
                    child: Row(
                      children: [
                        // 생년월일 입력
                        Expanded(
                          flex: 1,
                          child: MainTextField(
                            labelText: "생년월일",
                            hintText: "ex) 20000101",
                            controller: user_birth_controller,
                            textInputAction: TextInputAction.done,
                            focusNode: user_birth_focus,
                            textInputType: TextInputType.number,
                            obscureText: false,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        // 성별 선택
                        Expanded(
                          flex: 1,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return ToggleButtons(
                                children: [
                                  Container(
                                    width: constraints.maxWidth / 2 - 2,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "남",
                                      style: TextStyle(
                                        color: isSelected[0]
                                            ? Colors.white
                                            : mainOrange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: constraints.maxWidth / 2 - 2,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "여",
                                      style: TextStyle(
                                        color: isSelected[1]
                                            ? Colors.white
                                            : mainOrange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                                onPressed: (index) {
                                  setState(() {
                                    if (index == 0) {
                                      // 남자 클릭시
                                      isSelected[0] = true;
                                      isSelected[1] = false;
                                      gender = "남성";
                                    } else {
                                      // 여자 클릭시
                                      isSelected[0] = false;
                                      isSelected[1] = true;
                                      gender = "여성";
                                    }
                                  });
                                },
                                borderColor: mainOrange,
                                isSelected: isSelected,
                                selectedBorderColor: mainOrange,
                                fillColor: mainOrange,
                                borderRadius: BorderRadius.circular(10),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  // 약관 동의 체크 박스
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 체크 버튼
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.0,
                            child: Checkbox(
                              // 체크박스 여백 제거
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              // 체크박스 여백 제거
                              visualDensity: VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity
                              ),
                              // 체크박스 클릭 이벤트
                              value: check,
                              onChanged: (value) {
                                setState(() {
                                  if(check == true){
                                    check = false;
                                  }
                                  else{
                                    check = true;
                                  }
                                });
                              },
                              // 체크박스 테두리 둥글게 설정
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // 체크박스 체크 아이콘 색상 설정
                              checkColor: Colors.white,
                              activeColor: Colors.white,
                              // 체크박스 색상 설정
                              fillColor: check ? MaterialStatePropertyAll(mainOrange) : MaterialStatePropertyAll(Colors.white),
                              // 체크박스 테두리 색상 설정
                              side: MaterialStateBorderSide.resolveWith(
                                    (states) => BorderSide(width: 1.0, color: mainOrange),),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 5)),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if(check == true){
                                  check = false;
                                }
                                else{
                                  check = true;
                                }
                              });
                            },
                            child: Text(
                              "약관 동의 [필수]",
                              style: TextStyle(
                                  color: mainOrange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                      // 약관 보기
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 약관 보기 텍스트
                          TextButton(
                            // 클릭 이벤트 설정
                            onPressed: () {
                              Get.toNamed('/readTerms');
                            },
                            // 스타일 변경
                            style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap
                            ),
                            // "약관보기" + ">" 설정
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Text(
                                    "약관보기",
                                    style: TextStyle(
                                      color: grey4,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(right: 5)),
                                SvgPicture.asset("lib/assets/icon/icon_detail_open.svg"),
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 5)),
                        ],
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Spacer(),
                  // 확인 버튼
                  MainButton(
                      text: "확인",
                      onPressed: check ? () async {

                        // 아이디 중복확인을 해준다.
                        var check1 = await userRepository.doubleCheckId(user_id_controller.text);

                        // 이메일 중복확인을 해준다.
                        var check2 = await userRepository.doubleCheckEmail(user_email_controller.text);

                        // 이름 유효성 검사를 해준다.
                        if(user_name_controller.text == ""){
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
                                      TextSpan(text: "이름",style: TextStyle(color: mainOrange,fontSize: 16)),
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
                          // 아이디 유효성 검사를 해준다.
                          if(user_id_controller.text == ""){
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
                          // 아이디가 중복된다면
                          else if(!check1){
                            // 중복된다는 스낵바 노출
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
                                        TextSpan(text: "중복된\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                                        TextSpan(text: " 아이디",style: TextStyle(color: mainOrange,fontSize: 16)),
                                        TextSpan(text: "입니다.",style: TextStyle(color: Colors.white,fontSize: 16))
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
                              // 이메일로 받은 코드와 동일한지 인증코드 유효성 검사를 해준다.
                              if(user_email_controller.text == ""){
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
                              // 이메일이 중복된다면
                              else if(!check2){
                                // 중복된다는 스낵바 노출
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
                                            TextSpan(text: "중복된\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                                            TextSpan(text: " 이메일",style: TextStyle(color: mainOrange,fontSize: 16)),
                                            TextSpan(text: "입니다.",style: TextStyle(color: Colors.white,fontSize: 16))
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
                                // 생년월일 유효성 검사를 해준다.
                                if(user_birth_controller.text == ""){
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
                                              TextSpan(text: " 생년월일",style: TextStyle(color: mainOrange,fontSize: 16)),
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
                                else if(user_birth_controller.text.length != 8){
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
                                              TextSpan(text: " 생년월일",style: TextStyle(color: mainOrange,fontSize: 16)),
                                              TextSpan(text: "을\n",style: TextStyle(color: Colors.white,fontSize: 16)),
                                              TextSpan(text: "올바르게 작성해 주세요.",style: TextStyle(color: Colors.white,fontSize: 16))
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
                                  // 회원가입 되었다는 스낵바 노출
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
                                              TextSpan(text: "회원가입이\n",style: TextStyle(color: Colors.white,fontSize: 16)),
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

                                  // 로컬파일에 저장한 user_idx와 비회원id를 가져온다.
                                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                                  int? idx = prefs.getInt('idx');
                                  String? server_id = prefs.getString('server_id');

                                  // 회원가입 정보를 가져온다.
                                  user = Users(
                                      idx: idx!,
                                      name: user_name_controller.text,
                                      login_fail_cnt: 0,
                                      server_id: server_id!,
                                      profile_img: null,
                                      back_img: null,
                                      id: user_id_controller.text,
                                      pw: user_password_controller.text,
                                      email: user_email_controller.text,
                                      birth: user_birth_controller.text,
                                      gender: gender,
                                      status: "Y",
                                      reg_dt: DateTime.now(),
                                      mod_dt: DateTime.now()
                                  );

                                  // 유저 정보를 업데이트한다.
                                  await userRepository.updateUserInfo(user, idx);

                                  Get.offAll(() => LoginMain());
                                }
                              }
                            }
                          }
                        }
                      } : null,
                      color: mainOrange
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 30)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
