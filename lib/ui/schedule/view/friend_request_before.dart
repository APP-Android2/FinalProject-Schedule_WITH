import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/widget/main_small_button.dart';

class FriendRequestPage extends StatelessWidget {
  const FriendRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [Icon(Icons.close)],
          ),
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            // 배경 사진 부분
            Container(),
            // 프로필 사진 부분
            Container(),
            // 친구 신청 안내 버튼
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: double.infinity, height: 100,),
                Text('친구인 회원의 정보만\n확인 가능합니다', style: TextStyle(fontSize: 24, color: grey4),
                textAlign: TextAlign.center,),
                SizedBox(
                    width: double.infinity,
                    height: 20),
                MainSmallButton(text: '친구 요청', onPressed: () {  }, color: mainOrange,)
              ],
            )
          ])),
    );
  }
}
