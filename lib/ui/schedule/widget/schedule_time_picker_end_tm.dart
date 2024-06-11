import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';

class ScheduleTimePickerEndTm extends StatefulWidget {
  final Widget back_page;

  final String title;

  const ScheduleTimePickerEndTm({
    required this.back_page,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleTimePickerEndTm> createState() => _TimePickerEndTmState();
}

class _TimePickerEndTmState extends State<ScheduleTimePickerEndTm> {
  final ScheduleController scheduleController = Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    DateTime selectDate;
    DateTime dateTime;
    return Container(
      // 바텀 시트 높이 조절
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                    showModalBottomSheet(
                      // 바텀 시트 높이 지정하려면 isScrollControlled: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return widget.back_page;
                        });
                  },
                  // icon: SvgPicture.asset("lib/assets/icon/icon_angel_brackets.svg"),
                  icon: Icon(CupertinoIcons.back),
                  // icon: Icon(Icons.arrow_back_ios),
                  color: grey4,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 45,
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
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
                  backgroundColor: Colors.white,
                  initialDateTime: DateTime.now(),
                  maximumYear: DateTime.now().year,
                  minimumYear: 2000,
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (dateTime) {
                    scheduleController.updateEndTm(dateTime);
                  },
                ),
              ),
            )
          ],
        )
    );
  }
}
