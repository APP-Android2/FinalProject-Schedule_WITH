import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/ui/todo/controller/todo_controller.dart';
import 'package:schedule_with/widget/main_alert.dart';

import '../../../assets/colors/color.dart';

class TodoDatePickerBottomSheet extends StatefulWidget {
  final Widget back_page;

  const TodoDatePickerBottomSheet({
    required this.back_page,
    Key? key,
  }) : super(key: key);

  @override
  State<TodoDatePickerBottomSheet> createState() => _TodoDatePickerBottomSheetState();
}

class _TodoDatePickerBottomSheetState extends State<TodoDatePickerBottomSheet> {

  final TodoController _todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
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
          // 뒤로가기 및 title 설정
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
                  "날짜",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.dialog(MainAlert(
                    msg: "수정사항을 취소하시겠습니까?",
                    YesMsg: "예",
                    NoMsg: "계속 작성",
                  ));
                },
                // icon: SvgPicture.asset("lib/assets/icon/icon_angel_brackets.svg"),
                icon: Icon(CupertinoIcons.xmark),
                // icon: Icon(Icons.arrow_back_ios),
                color: grey4,
              ),
            ],
          ),
          // 날짜 선택 설정
          Container(
              height: 200,
              child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                      initialDateTime: _todoController.selectedDate.value,
                      maximumYear: 2300,
                      minimumYear: 2000,
                      mode: CupertinoDatePickerMode.date,
                      // 선택된 날짜를 컨트롤러에 업데이트
                      onDateTimeChanged: (dateTime) {
                        _todoController.updateDt(dateTime);
                      }
                  )
              )
          )
        ],
      ),
    );
  }
}
