import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../assets/colors/color.dart';
import '../widget/notification_mini_button.dart';

class NotificationRequestDetail extends StatefulWidget {
  const NotificationRequestDetail({super.key});

  @override
  State<NotificationRequestDetail> createState() => _NotificationRequestDetailState();
}

class _NotificationRequestDetailState extends State<NotificationRequestDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 툴바
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          // 스크롤 시 배경색 바뀌는 오류 해결 코드
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          // 뒤로가기 버튼
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: SvgPicture.asset("lib/assets/icon/icon_angel_brackets.svg"),
            onPressed: () {
              Get.back();
            },
          ),
          // 타이틀
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "친구 및 그룹 요청",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListItem(context);
          },
      ),
    );
  }
}

Widget ListItem(BuildContext context){
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 프로필 사진 및 텍스트 출력
        Row(
          children: [
            // 유저 또는 그룹 이미지 설정
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.green,
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            // 텍스트 설정
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 친구 또는 그룹 텍스트 출력
                Container(
                  height: 15,
                  child: Text(
                    "친구",
                    style: TextStyle(
                        fontSize: 12,
                        color: grey4
                    ),
                  ),
                ),
                // 요청한 유저의 아이디 출력 또는 그룹 이름이 출력
                Text(
                  "1swawaw1234",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            )
          ],
        ),
        // 수락 및 거절 버튼 설정
        Row(
          children: [
            // 초대 또는 친구요청일 때에만 수락버튼 보이게 해야됨
            NotificationMiniButton(
                text: "확인",
                onPressed: () {

                },
                color: mainOrange
            ),
            Padding(padding: EdgeInsets.only(right: 5)),
            NotificationMiniButton(
                text: "삭제",
                onPressed: () {

                },
                color: mainBrown
            ),
          ],
        )
      ],
    ),
  );
}
