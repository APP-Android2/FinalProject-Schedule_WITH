import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../assets/colors/color.dart';

class AlramItem extends StatefulWidget {
  final bool alramIsChecked ;

  const AlramItem({
    required this.alramIsChecked,
    Key? key,
  }) : super(key: key);

  @override
  State<AlramItem> createState() => _AlramListState();
}

class _AlramListState extends State<AlramItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Column(
        children: [
          // 시간, 스위치 버튼
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 시간 [ 숫자, 오후or오전 ]
                Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 40,
                          child: Text("01:30",
                            style: TextStyle(
                              height: 0,
                              fontSize: 40,
                            ),
                          ),
                        ),
                        Container(
                          child: Text("오전",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ]
                  ),
                // 스위치 버튼
                CupertinoSwitch(
                  value: widget.alramIsChecked,
                  activeColor: mainOrange,
                  onChanged: (bool? value) {
                    setState(() {
                      value = true ?? false;
                      // value ?? false;
                    });
                  },
                ),
              ],
            ),
          ),
          // 타켓 및 타이틀, 반복날짜
          Container(
            padding: EdgeInsets.only(top: 3),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: grey2, width: 1)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(1, 0, 1, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("야 일어나라 김진갱!!!",
                    style: TextStyle(
                        fontSize: 14,
                        color: mainOrange
                    ),
                  ),
                  Text("월, 화, 수",
                    style: TextStyle(
                      fontSize: 12,
                      color: grey4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}