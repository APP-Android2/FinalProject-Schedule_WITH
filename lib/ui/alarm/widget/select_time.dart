import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schedule_with/assets/colors/color.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({super.key});

  @override
  State<SelectTime> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectTime> {
  @override
  Widget build(BuildContext context) {
    DateTime selectDate;
    DateTime dateTime;
    return Column(
      children: [
        Container(
          height: 180,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              maximumYear: DateTime.now().year,
              minimumYear: 2000,
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (dateTime) {
                selectDate = dateTime;
              },
          ),
          ),
        )
      ],
    );
  }
}
