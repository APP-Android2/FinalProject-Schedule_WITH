import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/domain/repository/todo_repository.dart';
import 'package:schedule_with/ui/todo/widget/todo_add_bottom_sheet.dart';
import 'package:schedule_with/ui/todo/widget/todo_date_picker_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../assets/colors/color.dart';
import '../../../widget/main_button.dart';
import '../../../widget/main_two_button.dart';
import 'calendar_cell_custom.dart';
import '../controller/todo_controller.dart';

class TodoEditBottomSheet extends StatelessWidget {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final TodoController _todoController = Get.find<TodoController>();
  final calendarController;
  final title;
  final idx;

  TodoRepository todoRepository = TodoRepository();

  TodoEditBottomSheet({
    super.key,
    this.title,
    this.calendarController,
    this.idx,
  });

  @override
  Widget build(BuildContext context) {
    var todo_idx = idx;
    print("$todo_idx");
    TextEditingController todoContentController = TextEditingController(text: title);
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
                Get.bottomSheet(TodoDatePickerBottomSheet(back_page: TodoEditBottomSheet(idx : todo_idx, calendarController: _todoController,title: title,)));
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
                            '${formatter.format(calendarController.selectedDate.value)}',
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
            // 삭제하기, 수정하기 버튼
            MainTwoButton(
                leftText: '삭제 하기',
                leftColor: mainBrown,
                leftOnPressed: () async {
                  // 유저 번호를 가져온다.
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  var user_idx = prefs.getInt('idx');
                  // 파이어베이스 데이터 수정 하는 코드
                  await todoRepository.updateTodo(user_idx!, todo_idx, {'status' : "N"});

                  // 리스트에서 아이템 제거
                  _todoController.removeTodoItem(todo_idx);

                  Get.back();
                },
                rightText: '수정 완료',
                rightColor: mainOrange,
                rightOnPressed: () async {
                  // 유저 번호를 가져온다.
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  var user_idx = prefs.getInt('idx');

                  // 파이어베이스 데이터 수정 하는 코드
                  await todoRepository.updateTodo(
                      user_idx!,
                      todo_idx,
                      {
                        'title' : todoContentController.text,
                        'todo_dt' : _todoController.selectedDate.value,
                        'mod_dt' : DateTime.now()
                      }
                  );
                  if (todoContentController.text.isNotEmpty) {
                    _todoController.updateTodoItem(
                      idx: todo_idx,
                      oldTitle: title,
                      newTitle: todoContentController.text,
                      newDate: _todoController.selectedDate.value,
                    );
                    Get.back();
                  }

                }),
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
            "TODO 수정",
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
