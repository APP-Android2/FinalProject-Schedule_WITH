import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationMiniButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;

  const NotificationMiniButton({
    required this.text,
    required this.onPressed,
    required this.color,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 25,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 16)), // 패딩 설정
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))
          )
        ),
      ),
    );
  }
}
