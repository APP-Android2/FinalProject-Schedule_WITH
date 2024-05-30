import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/widget/main_button.dart';
import 'package:schedule_with/widget/main_text_field.dart';

class LoginJoin extends StatefulWidget {
  const LoginJoin({super.key});

  @override
  State<LoginJoin> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<LoginJoin> {
  var user_name_controller = TextEditingController();
  var user_id_controller = TextEditingController();
  var user_password_controller = TextEditingController();
  var user_password_check_controller = TextEditingController();
  var user_email_controller = TextEditingController();
  var email_sign_number_controller = TextEditingController();
  var user_birth_controller = TextEditingController();
  // 성별 기본 세팅 리스트
  List<bool> isSelected = [true, false];
  // 약관 동의 체크 여부
  bool check = false;

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
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      miniButton("중복확인", mainOrange),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  // 비밀번호 입력
                  MainTextField(
                    labelText: "비밀번호",
                    hintText: "8자이상, 영문 대/소문자, 숫자, 특수문자 2가지 이상 조합",
                    controller: user_password_controller,
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  // 비밀번호 확인 입력
                  MainTextField(
                    labelText: "비밀번호 확인",
                    hintText: "8자이상, 영문 대/소문자, 숫자, 특수문자 2가지 이상 조합",
                    controller: user_password_check_controller,
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
                                      isSelected[0] = true;
                                      isSelected[1] = false;
                                    } else {
                                      isSelected[0] = false;
                                      isSelected[1] = true;
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
                      onPressed: check ? () {
                        Get.back();
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