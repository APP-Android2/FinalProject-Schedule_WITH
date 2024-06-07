import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_add_bottom_sheet.dart';

class ScheduleDatePicker extends StatefulWidget {
  final Widget back_page ;
  final String title;

  const ScheduleDatePicker({
    required this.back_page,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleDatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<ScheduleDatePicker> {
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
                IconButton(onPressed: (){
                  Get.back();
                  showModalBottomSheet(
                    // 바텀 시트 높이 지정하려면 isScrollControlled: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context){
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
                  child:
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
            Container(
              height: 200,
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      fontSize:20,
                    ),
                  ),
                ),
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  maximumYear: 2300,
                  minimumYear: 2000,
                  mode: CupertinoDatePickerMode.date,
                  // 선택된 날짜를 컨트롤러에 업데이트
                  onDateTimeChanged: (dateTime) {
                    // 시작날짜 변경인지 종료날짜 변경인지 확인
                    if (AddScheduleBottomSheet().isStartDt = true) {
                      scheduleController.updateStartDt(dateTime);
                      AddScheduleBottomSheet().isStartDt = false;
                    } else {
                      scheduleController.updateEndDt(dateTime);
                      AddScheduleBottomSheet().isEndDt = false;
                    }
                  },
                ),
              ),
            )
          ],
        )
    );
  }

}

