import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';

class MyPageSwitchButton extends StatefulWidget {
  const MyPageSwitchButton({Key? key}) : super(key: key);

  @override
  State<MyPageSwitchButton> createState() => _MyPageSwitchButtonState();
}

class _MyPageSwitchButtonState extends State<MyPageSwitchButton> {
  bool _value = false; // 1. value 변수 정의

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: _value, // 1. value 변수 사용
      onChanged: (value) {
        setState(() {
          _value = value; // 2. onChanged 콜백에서 value 업데이트
          // 여기에 스위치 상태가 변경될 때 수행할 로직 추가
        });
      },
      activeColor: mainOrange, // 3. 사용할 색상 가져오기
    );
  }
}
