import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'todo_cancel_bottom_sheet.dart';
import '../view/todo_main_screen.dart';
import 'select_date.dart';

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

  void _openSelectDateBottomSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SelectDate(
          backPage: this.widget,
          title: '날짜 선택',
          onDateSelected: (date) {
            setState(() {
              selectedDate = '${date.year}-${date.month}-${date.day}';
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Adjust for keyboard
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    '         TODO 수정',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => _showCancelBottomSheet(context),
                  ),
                ],
              ),
              Row(
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
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      _openSelectDateBottomSheet(context);
                    },
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
              Row(
                children: [
                  const Text(
                    '내용',
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: Container(), // 빈 공간을 채우기 위해 사용
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            _contentController.text.isEmpty ? '할 일' : _contentController.text,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        TextField(
                          controller: _contentController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'TODO 내용', // 힌트 설정
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.transparent, // 투명하게 설정
                          ),
                          cursorColor: Colors.grey, // 커서 색상 설정
                          onChanged: (text) {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: widget.onDelete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown, // 배경색 갈색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // 모서리 둥글게
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16), // 버튼 높이 조절
                      ),
                      child: const Text(
                        '삭제하기',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onSave(TodoItemData(
                          date: selectedDate,
                          content: _contentController.text.isEmpty ? "    " : _contentController.text,
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7A5D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // 모서리 둥글게
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16), // 버튼 높이 조절
                      ),
                      child: const Text(
                        '수정 완료',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
