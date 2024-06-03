import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';


// 장기일정 숨기기 펼치기
class ShowLongAppoint extends StatelessWidget {
  const ShowLongAppoint({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        initiallyExpanded: true,
        shape: Border(
            bottom: BorderSide(
                color: grey2
            )
        ),
        // side: BorderSide(color: grey2)),
        leading: Container(width: 24),
        minTileHeight: 40,
        title: const Center(
            child: Text(
              '장기 일정',
              style: TextStyle(fontSize: 14),
            )),
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        collapsedIconColor: grey1,
        children: [
          Padding(padding: EdgeInsets.all(4)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                LongAppointText(title: '장기일정1'),
                const Padding(padding: EdgeInsets.all(10)),
                LongAppointText(title: '장기일정2'),
                const Padding(padding: EdgeInsets.all(10)),
                LongAppointText(title: '장기일정3'),
                const Padding(padding: EdgeInsets.all(10)),
                LongAppointText(title: '장기일정4'),
                const Padding(padding: EdgeInsets.all(10)),
                LongAppointText(title: '장기일정5'),
                const Padding(padding: EdgeInsets.all(10)),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(4)),
        ]);
  }
}


// 장기 일정 Text
class LongAppointText extends StatelessWidget {
  final String title;

  const LongAppointText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: lightPink,
        ),
        height: 30,
        width: 100,
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 12),
            )),
      ),
    );
  }
}