import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;

  const MainButton({
    required this.text,
    required this.onPressed,
    required this.color,
    Key? key,
  }) : super(key: key);

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
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ), // 텍스트 색상
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.white;
              }
              return color;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) {
              if (states.contains(MaterialState.disabled)) {
                return mainOrange;
              }
              return Colors.white;
            },
          ),
          side: MaterialStateProperty.resolveWith<BorderSide>(
                (states) {
              if (states.contains(MaterialState.disabled)) {
                return BorderSide(color: mainOrange);
              }
              return BorderSide.none;
            },
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
