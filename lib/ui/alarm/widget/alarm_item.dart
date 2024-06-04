import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../assets/colors/color.dart';
import '../view/alarm_detail.dart';

class AlarmItem extends StatefulWidget {
  final Alarm alarm;

  const AlarmItem({
    Key? key,
    required this.alarm,
  }) : super(key: key);

  @override
  State<AlarmItem> createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmItem> {
  bool _isChecked = false;
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
                  value: _isChecked,
                  activeColor: mainOrange,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value;
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

class Alarm {
  final String title; // Alarm title
  bool isChecked; // Whether the alarm is active or not

  Alarm({required this.title, required this.isChecked});
}