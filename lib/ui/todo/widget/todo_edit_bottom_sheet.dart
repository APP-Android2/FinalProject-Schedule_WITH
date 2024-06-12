import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/todo/widget/todo_controller.dart';
import 'package:schedule_with/ui/todo/widget/todo_item_data.dart';
import 'select_date.dart';

class TodoEditBottomSheet extends StatefulWidget {
  final TodoItemData todoItemData;
  final VoidCallback onCancel;
  final Function(String, TodoItemData) onSave;
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
  final TodoController _todoController = Get.find<TodoController>();
  late TextEditingController _contentController;
  String selectedDate = '';

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.todoItemData.content);
    selectedDate = widget.todoItemData.date;
    print('Edit BottomSheet initialized with date: $selectedDate and content: ${_contentController.text}');
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _openSelectDateBottomSheet(BuildContext context) async {
    await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return SelectDate(
              onDateSelected: (dateTime) {
                setState(() {
                  selectedDate = DateFormat('yyyy년 MM월 dd일').format(dateTime);
                  print('Date selected: $selectedDate');
                });
                Navigator.of(context).pop(); // Close the date picker

                // Reopen the bottom sheet with updated date
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    _showEditBottomSheet(context);
                  }
                });
              },
            );
          },
        );
      },
    );
  }

  void _showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return TodoEditBottomSheet(
          todoItemData: TodoItemData(
            date: selectedDate,
            content: _contentController.text,
          ),
          onCancel: widget.onCancel,
          onSave: widget.onSave,
          onDelete: widget.onDelete,
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
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              BottomSheetTitle(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: widget.onDelete,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainBrown,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Center(
                                  child: Text(
                                    '삭제하기',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: CupertinoColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (selectedDate.isNotEmpty && _contentController.text.isNotEmpty) {
                                    print('Save button pressed with date: $selectedDate and content: ${_contentController.text}');
                                    final updatedItem = TodoItemData(
                                      date: selectedDate,
                                      content: _contentController.text,
                                    );
                                    widget.onSave(widget.todoItemData.date, updatedItem);
                                    Navigator.of(context).pop();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainOrange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Center(
                                  child: Text(
                                    '수정 완료',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: CupertinoColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
