import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';

class MainTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction textInputAction;

  const MainTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        textInputAction: textInputAction,
        onSubmitted: (_) => FocusScope.of(context).nextFocus,
        controller: controller,
        // 커서 색상
        cursorColor: mainOrange,
        // 텍스트 입력시 밑줄 제거
        style: TextStyle(decorationThickness: 0),
        decoration: InputDecoration(
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
            color: mainOrange,
            fontSize: 12,
          ),
          // 힌트 설정
          hintStyle: TextStyle(
            color: grey3,
            fontSize: 12,
          ),
          // 라벨 및 힌트 입력
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
