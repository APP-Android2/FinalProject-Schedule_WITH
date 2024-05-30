import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconAndText extends StatelessWidget {
  final String text;
  final String iconRoute;
  final double height;

  const IconAndText({
    required this.iconRoute,
    required this.text,
    required this. height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconRoute,
          color: Colors.black,
          height: height,
        ),
        Padding(padding: EdgeInsets.only(right: 8)),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}
