import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import '../../../widget/date_picker.dart';

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
  late TextEditingController _contentController;
  String selectedDate = '';

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
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Custom BottomSheetTitle widget with aligned elements
              BottomSheetTitle(title: '       TODO 추가', closeIcon: true),
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
                        ElevatedButton(
                          onPressed: widget.onSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Center(
                            child: Text(
                              '확인',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.white,
                              ),
                            ),
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
      mainAxisAlignment: MainAxisAlignment.center,
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
