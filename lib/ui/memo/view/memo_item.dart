import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';

class Memo {
  String date;
  String title;
  String body;
  bool hasImage;
  bool isPublic;

  Memo({required this.date, required this.title, required this.body, this.hasImage = false, this.isPublic = true});
}

class MemoItem extends StatelessWidget {
  final Memo memo;

  const MemoItem({Key? key, required this.memo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor = memo.isPublic ? mainOrange : mainBrown;
    return Container(
      padding: EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 날짜 타이틀
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(memo.date, style: TextStyle(fontSize: 10, color: grey4)),
                  Text(memo.title, style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              // 공개/비공개
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor, width: 1),
                ),
                child: Text(memo.isPublic ? '공개' : '비공개',
                    style: TextStyle(color: statusColor, fontSize: 10)),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            memo.body,
            style: TextStyle(fontSize: 12),
            maxLines: memo.hasImage ? 2 : 4,
            overflow: TextOverflow.ellipsis,
          ),
          // Image Container if available
          if (memo.hasImage) Container(
            width: 70,
            height: 70,
            margin: EdgeInsets.only(top: 10),
            color: Colors.pink[300],
          ),
        ],
      ),
    );
  }
}
