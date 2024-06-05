import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';

class MainTwoButton extends StatelessWidget {
  // 왼쪽 버튼 매개변수
  final String leftText;
  final Color leftColor;
  final VoidCallback? leftOnPressed;
  // 오른쪽 버튼 매개변수
  final String rightText;
  final Color rightColor;
  final VoidCallback? rightOnPressed;

  const MainTwoButton(
      {required this.leftText,
        required this.leftColor,
        required this.leftOnPressed,
        required this.rightText,
        required this.rightColor,
        required this.rightOnPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Row(
          children: [
            Expanded(
            child: SizedBox(
              height: 45,
              child: TextButton(
                onPressed: leftOnPressed,
                child: Text(leftText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.white;
                      }
                      return leftColor;
                    },
                  ),
                  foregroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.disabled)) {
                      return mainOrange;
                    }
                    return Colors.white;
                  }),
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
            )),
            SizedBox(
              width: 10,
            ),
            // 버튼 사이 여백
            Expanded(
            child: SizedBox(
              height: 45,
              child: TextButton(
                onPressed: rightOnPressed,
                child: Text(rightText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.white;
                      }
                      return rightColor;
                    },
                  ),
                  foregroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.disabled)) {
                      return mainOrange;
                    }
                    return Colors.white;
                  }),
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
            )
        )
      ],
    )
    );
  }
}
