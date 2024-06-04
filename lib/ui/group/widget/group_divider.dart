import 'package:flutter/material.dart';

import '../../../assets/colors/color.dart';

class GroupDivider extends StatelessWidget {

  final double verticalPadding;
  final double horizontalPadding;

  const GroupDivider({
    required this.verticalPadding,
    required this.horizontalPadding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      child: Divider(
        thickness: 1,
        height: 1,
        color: grey2,
      ),
    );
  }
}
