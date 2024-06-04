import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/todo/widget/todo_cancel_bottom_sheet.dart';
import '../../../widget/date_picker.dart';
import '../../../widget/main_two_button.dart';
import 'todo_controller.dart';
import '../view/todo_main_screen.dart';

class TodoEditBottomSheet extends StatefulWidget {
  final TodoItemData todoItemData;
  final VoidCallback onCancel;
  final Function(TodoItemData) onSave;
  final VoidCallback onDelete;

  const TodoEditBottomSheet({
    super.key,
    required this.todoItemData,
    required this.onCancel,
    required this.onSave,
    required this.onDelete,
  });

  @override
  _TodoEditBottomSheetState createState() => _TodoEditBottomSheetState();
}

class _TodoEditBottomSheetState extends State<TodoEditBottomSheet> {
  late TextEditingController _contentController;
  String selectedDate = '';

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.todoItemData.content);
    selectedDate = widget.todoItemData.date;
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _showCancelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => TodoCancelBottomSheet(
        onConfirm: () {
          Navigator.of(context).pop(); // Close the confirmation bottom sheet
          Navigator.of(context).pop(); // Close the edit bottom sheet
          widget.onCancel(); // Execute any additional onCancel logic
        },
        onContinue: () {
          Navigator.of(context).pop(); // Close the confirmation bottom sheet
        },
      ),
    );
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
          height: MediaQuery.of(context).size.height * 0.5, // Set height to 50% of the screen
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                title: Center(
                  child: Text(
                    'TODO 수정',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.black),
                    onPressed: () => _showCancelBottomSheet(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _openSelectDateBottomSheet(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '날짜',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    Text(
                      selectedDate,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: grey2,
              ),
              const SizedBox(height: 3),
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
              Divider(
                thickness: 1,
                color: grey2,
              ),
              const SizedBox(height: 16),
              Spacer(), // Pushes the buttons to the bottom
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: MainTwoButton(
                    leftText: '삭제하기',
                    leftColor: mainBrown,
                    leftOnPressed: widget.onDelete,
                    rightText: '수정 완료',
                    rightColor: mainOrange,
                    rightOnPressed: () {
                      if (selectedDate.isNotEmpty && _contentController.text.isNotEmpty) {
                        widget.onSave(TodoItemData(
                          date: selectedDate,
                          content: _contentController.text,
                        ));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
