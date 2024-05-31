import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_bottom_sheet.dart';

class ScheduleAlert extends StatefulWidget {

  // final title;
  final msg;
  final showAll;
  final showTitle;
  final showNothing;

  const ScheduleAlert({super.key,
    this.msg,
    this.showAll,
    this.showTitle,
    this.showNothing
  });

  @override
  State<ScheduleAlert> createState() => _MainAlertState();
}

class _MainAlertState extends State<ScheduleAlert> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        backgroundColor: Colors.white,
        child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              width: 500,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                border: Border(),
                color: Colors.white,
              ),
              child: Text(widget.msg,),
            ),
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: mainOrange
              ),
              child: MaterialButton(
                onPressed: () {
                  print('공개여부선택 >> 전체공개');
                  Get.back();
                },
                child: Text(widget.showAll,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // SizedBox(height: 10,),
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: grey1
              ),
              child: MaterialButton(
                onPressed: () {
                  print('공개여부선택 >> 일부공개');
                  Get.back();
                },
                child: Text(widget.showTitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: mainBrown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                  color: grey1
              ),
              child: MaterialButton(
                onPressed: () {
                  print('공개여부선택 >> 비공개');
                  Get.back();
                },
                child: Text(widget.showNothing,
                  style: TextStyle(
                    fontSize: 16,
                    color: mainBrown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
