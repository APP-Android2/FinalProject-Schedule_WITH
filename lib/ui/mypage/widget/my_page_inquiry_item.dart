import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'my_page_divider.dart';

class Inquiry{
  String InquiryTitle;
  String InquiryContent;

  Inquiry({required this.InquiryTitle, required this.InquiryContent});
}

class InquiryListItem extends StatefulWidget {
  final Inquiry inquiry;

  const InquiryListItem({Key? key, required this.inquiry}) : super(key: key);

  @override
  State<InquiryListItem> createState() => _InquiryListItemState();
}

class _InquiryListItemState extends State<InquiryListItem> {
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
        padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Column(
          children: [
            // 제목 및 아이콘
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 문의 제목
                Text(
                  widget.inquiry.InquiryTitle,
                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold,height: 1)
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
            if(isClick)
              Padding(
                padding: EdgeInsets.only(top: 10, left: 16,right: 16),
                child: Text(
                  widget.inquiry.InquiryContent,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            // 디바이더 설정
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: MyPageDivider(verticalPadding: 0, horizontalPadding: 0),
            ),

          ],
        ),
      ),
    );
  }
}
