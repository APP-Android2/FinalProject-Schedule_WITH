import 'package:flutter/material.dart';

import '../../../assets/colors/color.dart';

class CheckPasswordErrorSingleton {
  static final CheckPasswordErrorSingleton _instance = CheckPasswordErrorSingleton._internal();

  factory CheckPasswordErrorSingleton() {
    return _instance;
  }

  CheckPasswordErrorSingleton._internal();

  String? _passwordError;

  String? get passwordError => _passwordError;

  void setPasswordError(String? error) {
    _passwordError = error;
  }
}


class PasswordCheckTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final TextEditingController check_controller;

  const PasswordCheckTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.textInputAction,
    required this.focusNode,
    required this.check_controller,
  }) : super(key: key);

  @override
  State<PasswordCheckTextField> createState() => _PasswordCheckTextFieldState();
}

class _PasswordCheckTextFieldState extends State<PasswordCheckTextField> {

  String? _passwordError; // 비밀번호 에러 메시지

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _passwordError == null ? 45 : 70,
      child: TextField(
        obscureText: true,
        onChanged: (value) {
          setState(() {
            _passwordError = _validatePassword(value, widget.check_controller.text);
            CheckPasswordErrorSingleton().setPasswordError(_passwordError);
          });
        },
        textInputAction: widget.textInputAction,
        onSubmitted: (_) => FocusScope.of(context).nextFocus,
        controller: widget.controller,
        // 커서 색상
        cursorColor: mainOrange,
        // 텍스트 입력시 밑줄 제거
        style: TextStyle(decorationThickness: 0),
        decoration: InputDecoration(
          errorText: _passwordError,
          errorMaxLines: 1,
          errorStyle: TextStyle(
            color: mainBrown,
            fontSize: 12,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainBrown),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainBrown),
            borderRadius: BorderRadius.circular(10),
          ),
          // 라벨을 항상 위에 보이게 한다.
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // TextField 테두리 색상 변경 및 radius 설정
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainOrange),
            borderRadius: BorderRadius.circular(10),
          ),
          // TextField에 포커스가 주어졌을 때 테두리 색상 변경 및 radius 설정
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainOrange),
            borderRadius: BorderRadius.circular(10),
          ),
          // 라벨 설정
          labelStyle: TextStyle(
            color: _passwordError == null ? mainOrange : mainBrown,
            fontSize: 12,
          ),
          // 힌트 설정
          hintStyle: TextStyle(
            color: grey3,
            fontSize: 12,
          ),
          // 라벨 및 힌트 입력
          labelText: widget.labelText,
          hintText: widget.hintText,
        ),
        focusNode: widget.focusNode,
      ),
    );
  }
}

// 비밀번호 유효성 검사 메서드
String? _validatePassword(String value,  String checkValue) {
  if (value != checkValue) {
    return '비밀번호가 일치하지 않습니다.';
  }
  return null; // 유효성 검사 통과
}
