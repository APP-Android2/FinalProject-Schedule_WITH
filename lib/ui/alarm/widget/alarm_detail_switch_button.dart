import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../assets/colors/color.dart';

class AlarmDetailSwitchButton extends StatefulWidget {
  final String titleText;
  final bool alarmIsChecked;
  final VoidCallback? onPressed;

  const AlarmDetailSwitchButton({
    required this.titleText,
    required this.alarmIsChecked,
    this.onPressed,
    Key? key,
    }): super(key: key);

  @override
  State<AlarmDetailSwitchButton> createState() => _AlarmdetailswitchbuttonState();
}

class _AlarmdetailswitchbuttonState extends State<AlarmDetailSwitchButton> {
  bool _isChecked = true;

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
                value: _isChecked,
                activeColor: mainOrange,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value;
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
