import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../assets/colors/color.dart';
import 'my_page_divider.dart';

class Notice{
  String date;
  String NoticeTitle;
  String NoticeContent;

  Notice({required this.date, required this.NoticeTitle, required this.NoticeContent});
}

class NoticeListItem extends StatefulWidget {
  final Notice notice;

  const NoticeListItem({Key? key, required this.notice}) : super(key: key);

  @override
  _NoticeListItemState createState() => _NoticeListItemState();
}

class _NoticeListItemState extends State<NoticeListItem> {
  // 꺽쇠 방향을 돌릴 프로퍼티
  double iconRotate = 1.57;
  // 상세 내용을 눌렀을 때(bool) 초기는 false
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isClick = !isClick;
          iconRotate = isClick ? 4.7 : 1.57;
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 날짜 및 공지 제목
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 작성 날짜 및 공지 제목
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 작성날짜
                    Text(
                      widget.notice.date,
                      style: TextStyle(fontSize: 12, color: grey4,height: 1),
                    ),
                    // 공지사항 제목
                    Text(widget.notice.NoticeTitle,style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold,height: 1)),
                  ],
                ),
                // 꺽쇠 아이콘 설정
                Transform.rotate(
                  // 1.57 아래 방향
                  // 4.7 윗 방향
                  angle: iconRotate,
                  child: SvgPicture.asset(
                    "lib/assets/icon/icon_detail_open.svg",
                    width: 6,
                    height: 13,
                  ),
                ),
              ],
            ),
            // 디바이더 설정
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: MyPageDivider(verticalPadding: 0, horizontalPadding: 0),
            ),
            // 상세내용
            // isClick이 true일때만 노출
            if (isClick)
              Padding(
                padding: EdgeInsets.only(top: 15,bottom: 15),
                child: Text(
                  widget.notice.NoticeContent,
                  style: TextStyle(fontSize: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}