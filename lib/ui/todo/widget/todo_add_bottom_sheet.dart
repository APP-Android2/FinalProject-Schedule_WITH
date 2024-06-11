import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/todo/widget/todo_date_picker_bottom_sheet.dart';
import '../../../widget/main_button.dart';
import '../controller/todo_controller.dart';
import '../view/todo_main_screen.dart';

class TodoAddBottomSheet extends StatelessWidget {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final TodoController _todoController = Get.find<TodoController>();

  TodoAddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController todoContentController = TextEditingController();

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            TodoBottomSheetTitle(),
            InkWell(
              onTap: () {
                Get.back();
                Get.bottomSheet(TodoDatePickerBottomSheet(back_page: TodoAddBottomSheet()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: grey2, width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "날짜",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Text(
                            '${formatter.format(_todoController.selectedDate.value)}',
                            style: TextStyle(fontSize: 16, color: grey4))),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        SvgPicture.asset("lib/assets/icon/icon_detail_open.svg")
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: grey2, width: 1)),
              ),
              child: Row(
                children: [
                  Text("내용", style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: SizedBox(
                      height: 20,
                      child: TextField(
                        controller: todoContentController,
                        textAlign: TextAlign.right,
                        cursorColor: mainOrange,
                        style: TextStyle(
                          decorationThickness: 0,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "TODO 내용입니다.",
                          hintStyle: TextStyle(fontSize: 16, color: grey4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: MainButton(
                text: "확인",
                onPressed: () {
                  if (todoContentController.text.isNotEmpty) {
                    _todoController.addTodoItem(
                      todoContentController.text,
                      "Todo 설명", // You can add a description field to the UI as well
                      _todoController.selectedDate.value,
                    );
                    Get.back();
                  }
                },
                color: mainOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoBottomSheetTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 50),
        Container(
          alignment: Alignment.center,
          height: 45,
          child: Text(
            "TODO 추가",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.close),
        ),
      ],
    );
  }
}
