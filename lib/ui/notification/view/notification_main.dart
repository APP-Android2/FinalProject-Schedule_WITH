import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/ui/notification/widget/notification_mini_button.dart';

import '../../../assets/colors/color.dart';

class NotificationMain extends StatefulWidget {
  const NotificationMain({super.key});

  @override
  State<NotificationMain> createState() => _NotificationMainState();
}

class _NotificationMainState extends State<NotificationMain> {

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
              "알림",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // 친구 및 그룹 요청에 대한 화면
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: InkWell(
                onTap: () {
                  Get.toNamed('/requestDetail');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 프로필 사진 겹치기 설정
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.blue,
                                  // 백그라운드 이미지로 최신 알림 이전 알림 회원 이미지를 가져온다.
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        // 친구 및 그룹 요청 텍스트 + 최신 요청을 한 유저의 아이디 및 외 00명 출력
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 친구 및 그룹 요청 텍스트
                            Text(
                              "친구 및 그룹 요청",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            // 최신 요청을 한 유저의 아이디 및 외 00명 텍스트
                            Text(
                              "0000님 외 00명",
                              style: TextStyle(
                                  color: grey4,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // 아이콘 설정
                    SvgPicture.asset(
                      "lib/assets/icon/icon_detail_open.svg",
                      height: 15,
                      color: grey3,
                    )
                  ],
                ),
              ),
            ),
          ),
          // 디바이더 설정
          SliverToBoxAdapter(
            child: Divider(
              thickness: 1,
              height: 1,
              color: grey2,
            ),
          ),
          // 여백 설정
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              height: 10,
            ),
          ),
          // ListView.builder를 대체하는 SliverList
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return ListItem();
              },
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}

// ListItem 위젯 정의
Widget ListItem() {

  bool isUser = true;

  return Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
                // 날짜 출력
                Container(
                  height: 13,
                  child: Text(
                    "2024. 05. 28",
                    style: TextStyle(
                        fontSize: 12,
                        color: grey4
                    ),
                  ),
                ),
                // 유저의 아이디 또는 그룹이름 + 알림에 대한 텍스트
                Row(
                  children: [
                    // 요청한 유저의 아이디 출력 또는 그룹 이름이 출력
                    Text(
                      "1swawaw1234",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    // 어떤 요청이나 알림에 따라 텍스트가 달라짐
                    getGroupText(1)
                  ],
                )
              ],
            )
          ],
        ),
        getGroupButton(1)
      ],
    ),
  );
}

// 그룹에서 알림 종류에 따라 텍스트 변경
Widget getGroupText(groupNum){
  switch(groupNum){
    case 1:
      return Text("님이 친구 신청을 하였습니다.", style: TextStyle(fontSize: 12));
    case 2:
      return Text("그룹에 초대되었습니다.", style: TextStyle(fontSize: 12));
    case 3:
      return Text("그룹에 새로운 일정이 등록되었습니다.", style: TextStyle(fontSize: 12));
    case 4:
      return Text("그룹에 새로운 알람이 등록되었습니다.", style: TextStyle(fontSize: 12));
    case 5:
      return Text("그룹에 새로운 메모가 등록되었습니다.", style: TextStyle(fontSize: 12));
    case 6:
      return Text("그룹에 새로운 TODO가 등록되었습니다", style: TextStyle(fontSize: 12));
    default:
      return Text("없음", style: TextStyle(fontSize: 12));
  }
}

Widget getGroupButton(groupNum){
  switch(groupNum){
  // 친구 신청일 때
    case 1:
      return NotificationMiniButton(
          text: "수락",
          onPressed: () {

          },
          color: mainOrange
      );
  // 그룹 초대 일 때
    case 2:
      return NotificationMiniButton(
          text: "수락",
          onPressed: () {

          },
          color: mainOrange
      );
    default:
      return Container();
  }
}

