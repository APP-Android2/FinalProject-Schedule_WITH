import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const MainButton({
    required this.text,
    required this.onPressed,
    required this.color,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity, // 버튼을 전체 너비로 설정
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ), // 텍스트 색상
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color), // 배경색 설정
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 13)), // 패딩 설정
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
    );
  }
}