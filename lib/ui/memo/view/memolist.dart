import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/memo/view/memo.dart' as MemoView;

import 'memo_item.dart';

class MemoListView extends StatefulWidget {
  final List<Memo> memos = [
    Memo(date: '2024.05.13', title: '메모 제목입니다.', body: '메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.', hasImage: true, isPublic: true),
    Memo(date: '2024.05.13', title: '다른 메모 제목입니다.', body: '다른 메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.', hasImage: false, isPublic: false),
    Memo(date: '2024.05.13', title: '다른 메모 제목입니다.', body: '다른 메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.', hasImage: false, isPublic: false),
    Memo(date: '2024.05.13', title: '다른 메모 제목입니다.', body: '다른 메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.', hasImage: false, isPublic: false),
    Memo(date: '2024.05.13', title: '다른 메모 제목입니다.', body: '다른 메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.메모 내용입니다.', hasImage: false, isPublic: false),
  ];


  @override
  _MemoListViewState createState() => _MemoListViewState();
}

class _MemoListViewState extends State<MemoListView> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 40,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  child: Center(
                    child: Text(
                      '메모',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainOrange),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: mainOrange),
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1.5,
            thickness: 1.5,
            color: mainOrange,
          ),
          Expanded(
            child: AnimatedSize(
              duration: Duration(milliseconds: 300),
              child: ListView(
                children: isExpanded ? widget.memos.map((memo) => MemoItem(memo: memo)).toList() : [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class MemoListWidget extends StatelessWidget {
//   final List<MemoView.Memo> memos;
//
//   const MemoListWidget({Key? key, required this.memos}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MemoListView(memos: memos);
//   }
// }
