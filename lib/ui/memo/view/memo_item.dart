import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';

import '../widget/memo_slide_delete.dart';

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
  final Function onTap;
  final Function onDelete;

  const MemoItem({Key? key, required this.memo, required this.onTap, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(memo.date, style: TextStyle(fontSize: 10, color: grey4)),
                    Text(memo.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                // 공개/비공개
                Transform.translate(
                  offset: Offset(0, -5),
                  child: Container(
                    width: 52,
                    height: 20,
                    decoration: BoxDecoration(
                      color: memo.isPublic ? mainOrange : mainBrown,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: memo.isPublic ? mainOrange : mainBrown, width: 1),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      memo.isPublic ? '공개' : '비공개',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        height: 1.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
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
      ),
    );
  }
}
