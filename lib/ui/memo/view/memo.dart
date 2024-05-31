import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'memo_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MemoScreen(),
    );
  }
}

class MemoScreen extends StatefulWidget {
  @override
  _MemoScreenState createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
            '메모', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              print('Title: ${_titleController.text}');
              print('Content: ${_contentController.text}');
            },
            child: Text('완료', style: TextStyle(
                color: mainOrange, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: grey2)),
              ),
              child: TextField(
                controller: _titleController,
                style: TextStyle(color: grey2, fontSize: 16),
                decoration: InputDecoration(
                  hintText: '제목을 입력해 주세요.',
                  border: InputBorder.none,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                style: TextStyle(color: grey2, fontSize: 14),
                decoration: InputDecoration(
                  hintText: '내용을 입력해 주세요.',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(
          onPressed: () {
            // 버튼이 눌렸을 때의 동작 정의
          },
          backgroundColor: mainOrange,
          child: SvgPicture.asset(
            "lib/assets/icon/icon_camera.svg",
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}

class CreateMemo {
  String content;
  DateTime date;

  CreateMemo({required this.content, required this.date});
}
