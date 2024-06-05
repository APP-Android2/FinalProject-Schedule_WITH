import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/todo/widget/todo_controller.dart';
import 'package:schedule_with/widget/main_button.dart';
import '../../../widget/date_picker.dart';
import '../../schedule/widget/schedule_add_bottom_sheet.dart';

class TodoAddBottomSheet extends StatefulWidget {
  final TextEditingController dateController;
  final TextEditingController contentController;
  final VoidCallback onSave;

  const TodoAddBottomSheet({
    super.key,
    required this.dateController,
    required this.contentController,
    required this.onSave,
  });

  @override
  _TodoAddBottomSheetState createState() => _TodoAddBottomSheetState();
}

class _TodoAddBottomSheetState extends State<TodoAddBottomSheet> {
  final TodoController _todoController = TodoController();
  late TextEditingController _contentController;
  String selectedDate = '';
  DateTime? selectedDate2;

  @override
  void initState() {
    super.initState();
    _contentController = widget.contentController;
    selectedDate = widget.dateController.text;
  }

  Future<void> _openSelectDateBottomSheet(BuildContext context) async {
    final DateTime? pickedDate = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePicker(
          back_page: this.widget,
          title: '날짜',
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
        widget.dateController.text = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          // Adjust the height based on your preference
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
              // Custom BottomSheetTitle widget with aligned elements
              BottomSheetTitle(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () {
                            Get.back(); // Close first
                            Get.bottomSheet(
                                DatePicker(
                                  back_page: TodoAddBottomSheet(
                                    dateController: widget.dateController,
                                    contentController: widget.contentController,
                                    onSave: () {
                                      String dateString = DateFormat('yyyy-MM-dd').format(selectedDate2!);
                                      _todoController.addTodoItem(dateString, _contentController.text);
                                      _contentController.clear();
                                      Navigator.of(context).pop();
                                      setState(() {}); // 상태를 새로고침하여 UI 업데이트
                                    },
                                  ),
                                  title: '날짜',
                                ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '날짜',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                selectedDate,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Divider(),
                        Row(
                          children: [
                            const Text(
                              '내용',
                              style: TextStyle(fontSize: 16),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextField(
                                  controller: _contentController,
                                  decoration: const InputDecoration(
                                    hintText: '내용을 입력하세요',
                                    border: InputBorder.none,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        MainButton(
                            text: "확인",
                            onPressed: () {
                              Get.back();
                            },
                            color: mainOrange
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 바텀 시트 제목 설정
class BottomSheetTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 50),
        Container(
          alignment: Alignment.center,
          height: 45,
          child:
          Text(
            "TODO 추가",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
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
