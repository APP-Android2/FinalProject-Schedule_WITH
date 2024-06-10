import 'package:flutter/material.dart';

class MiniButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;

  const MiniButton({
    required this.text,
    required this.onPressed,
    required this.color,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 100,
      child: TextButton(
        onPressed: onPressed,
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
}
