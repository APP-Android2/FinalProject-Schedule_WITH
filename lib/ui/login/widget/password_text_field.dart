import 'package:flutter/material.dart';

import '../../../assets/colors/color.dart';

class PasswordErrorSingleton {
  static final PasswordErrorSingleton _instance = PasswordErrorSingleton._internal();

  factory PasswordErrorSingleton() {
    return _instance;
  }

  PasswordErrorSingleton._internal();

  String? _passwordError;

  String? get passwordError => _passwordError;

  void setPasswordError(String? error) {
    _passwordError = error;

  }
}

class PasswordTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final FocusNode focusNode;

  const PasswordTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.textInputAction,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {

  String? _passwordError; // 비밀번호 에러 메시지

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _passwordError == null ? 45 : 70,
      child: TextField(
        obscureText: true,
        onChanged: (value) {
          setState(() {
            _passwordError = _validatePassword(value);
            PasswordErrorSingleton().setPasswordError(_passwordError);
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
String? _validatePassword(String value) {
  if (value.length < 8) {
    return '비밀번호는 8자 이상이어야 합니다.';
  }
  // 영문 대/소문자, 숫자, 특수문자 중 최소 두 가지가 포함되었는지 확인
  bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
  bool hasLowercase = value.contains(RegExp(r'[a-z]'));
  bool hasDigit = value.contains(RegExp(r'[0-9]'));
  bool hasSpecialCharacters =
  value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  if (!(hasUppercase && hasLowercase) &&
      !(hasUppercase && hasDigit) &&
      !(hasUppercase && hasSpecialCharacters) &&
      !(hasLowercase && hasDigit) &&
      !(hasLowercase && hasSpecialCharacters) &&
      !(hasDigit && hasSpecialCharacters)) {
    return '영문 대/소문자, 숫자, 특수문자 중 최소 두 가지를 포함하세요.';
  }
  return null; // 유효성 검사 통과
}
