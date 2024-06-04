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

  // 취소 확인 바텀 시트를 보여주는 함수
  void _showCancelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => TodoCancelBottomSheet(
        onConfirm: () {
          Navigator.of(context).pop(); // 확인 바텀 시트 닫기
          Navigator.of(context).pop(); // 수정 바텀 시트 닫기
          widget.onCancel(); // 추가적인 취소 로직 실행
        },
        onContinue: () {
          Navigator.of(context).pop(); // 확인 바텀 시트 닫기
        },
      ),
    );
  }

  // 날짜 선택 바텀 시트를 열고 날짜를 선택하는 함수
  Future<void> _openSelectDateBottomSheet(BuildContext context) async {
    Navigator.of(context).pop(); // 현재 바텀 시트 닫기

    final DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: DatePicker(
                back_page: this.widget,
                title: '날짜',
              ),
            );
          },
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showEditBottomSheet(context); // 업데이트된 날짜로 수정 바텀 시트를 다시 열기
        }
      });
    }
  }

  // 수정 바텀 시트를 다시 여는 함수
  void _showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => TodoEditBottomSheet(
        todoItemData: TodoItemData(
          date: selectedDate,
          content: _contentController.text,
        ),
        onCancel: widget.onCancel,
        onSave: widget.onSave,
        onDelete: widget.onDelete,
      ),
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
          height: MediaQuery.of(context).size.height * 0.5, // 화면 높이의 50%로 설정
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // 정렬된 요소가 있는 커스텀 BottomSheetTitle 위젯
              BottomSheetTitle(title: '         TODO 수정', closeIcon: true),
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
                              SizedBox(width: 10), // 버튼 사이 간격 추가
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (selectedDate.isNotEmpty && _contentController.text.isNotEmpty) {
                                      widget.onSave(TodoItemData(
                                        date: selectedDate,
                                        content: _contentController.text,
                                      ));
                                      if (Navigator.canPop(context)) {
                                        Navigator.of(context).pop(); // 수정 바텀 시트 닫기
                                      }
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
  final String title;
  final bool closeIcon;

  const BottomSheetTitle({
    Key? key,
    required this.title,
    this.closeIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        if (closeIcon)
          IconButton(
            padding: EdgeInsets.only(top: 10),
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close),
            alignment: Alignment.topRight,
          ),
      ],
    );
  }
}
