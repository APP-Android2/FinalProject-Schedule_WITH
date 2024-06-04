import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../assets/colors/color.dart';

class GroupSwitchButton extends StatefulWidget {
  final String titleText;
  final bool IsChecked;
  final VoidCallback? onPressed;

  const GroupSwitchButton({
    required this.titleText,
    required this.IsChecked,
    this.onPressed,
    Key? key,
    }): super(key: key);

  @override
  State<GroupSwitchButton> createState() => _GroupSwitchButtonState();
}

class _GroupSwitchButtonState extends State<GroupSwitchButton> {
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(

        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( '${widget.titleText}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: _isChecked,
                  activeColor: mainOrange,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value;
                      // value ?? false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
