import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/assets/colors/color.dart';
import '../widget/my_page_notice_item.dart';

class MyPageNotice extends StatefulWidget {

  // 공지사항에 작성할 리스트(작성을 원하면 여기서 작성하면 됨)
  final List<Notice> notices = [
    Notice(date: 'zz', NoticeTitle: 'zzz', NoticeContent: 'zzzz'),
    Notice(date: 'zz', NoticeTitle: 'zzz', NoticeContent: 'zzzz'),
    Notice(date: 'zz', NoticeTitle: 'zzz', NoticeContent: 'zzzz'),
    Notice(date: 'zz', NoticeTitle: 'zzz', NoticeContent: 'zzzz'),
  ];
  @override
  State<MyPageNotice> createState() => _MyPageNoticeState();
}

class _MyPageNoticeState extends State<MyPageNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 툴바
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
            backgroundColor: Colors.white,
            // 뒤로가기 버튼
            leading: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(CupertinoIcons.back,color: grey4),
              onPressed: () {
                Get.back();
              },
            ),
            // 타이틀
            centerTitle: true,
            title: Container(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "공지사항",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
        ),
      ),
      body: ListView(
        children: widget.notices.map((notice) => NoticeListItem(notice: notice)).toList(),
      ),
    );
  }
}

