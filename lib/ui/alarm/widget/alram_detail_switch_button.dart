import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../assets/colors/color.dart';

class AlramDetailSwitchButton extends StatefulWidget {
  final String titleText;
  final bool alramIsChecked;
  final VoidCallback? onPressed;

  const AlramDetailSwitchButton({
    required this.titleText,
    required this.alramIsChecked,
    this.onPressed,
    Key? key,
    }): super(key: key);

  @override
  State<AlramDetailSwitchButton> createState() => _AlramdetailswitchbuttonState();
}

class _AlramdetailswitchbuttonState extends State<AlramDetailSwitchButton> {
  // final bool alramIsChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: grey2, width: 1)
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( '${widget.titleText}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              CupertinoSwitch(
                value: widget.alramIsChecked,
                activeColor: mainOrange,
                onChanged: (bool? value) {
                  setState(() {
                    value = true ?? false;
                    // value ?? false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
