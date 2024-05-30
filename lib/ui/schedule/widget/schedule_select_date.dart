import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';

class SelectDate extends StatefulWidget {
  final Widget back_page ;
  final String title;
  const SelectDate({
    required this.back_page,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
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
                Get.bottomSheet(
                  widget.back_page,
                  isDismissible: true,
                  );
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
                onDateTimeChanged: (dateTime) {
                  selectDate = dateTime;
                },
              ),
            ),
          )
        ],
      )
    );
  }
}
