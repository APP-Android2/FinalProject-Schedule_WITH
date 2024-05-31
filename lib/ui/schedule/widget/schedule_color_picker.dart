import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_color_button.dart';

class ScheduleColorPicker extends StatefulWidget {
  final msg;

  const ScheduleColorPicker({super.key,
    this.msg,
  });

  @override
  State<ScheduleColorPicker> createState() => _ScheduleColorPickerState();
}

class _ScheduleColorPickerState extends State<ScheduleColorPicker> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: 250,
        child: Column(
            children: [
              // 질문
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    color: Colors.white,
                    border: Border(bottom: BorderSide(
                        width: 1.0,
                        color: grey2
                    ))
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: Text(widget.msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // 색상 버튼
              ColorButtonSet(),
            ]
        )
      )
    );
  }
}


