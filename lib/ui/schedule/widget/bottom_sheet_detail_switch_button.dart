import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_switch_button.dart';

class BottomSheetDetailSwitchButton extends StatefulWidget {
  final String titleText;
  final VoidCallback? onTap;

  const BottomSheetDetailSwitchButton({
    required this.titleText,
    this.onTap,
    Key? key,
  }): super(key: key);

  @override
  State<BottomSheetDetailSwitchButton> createState() => _BottomSheetDetailButtonState();
}

class _BottomSheetDetailButtonState extends State<BottomSheetDetailSwitchButton> {
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: widget.onTap,
        child: Padding(
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
                  ScheduleSwitchButton()
                ],
              ),
            ),
          ),
        ),
      );
  }
}