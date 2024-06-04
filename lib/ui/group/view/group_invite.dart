import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/ui/group/widget/group_divider.dart';

import '../../../assets/colors/color.dart';
import '../../../widget/group_invite_item.dart';
import '../widget/friend_add_mini_button.dart';
import '../widget/group_invite_item.dart';

class GroupInvite extends StatefulWidget {

  final List<Invite> invites = [
    Invite(ProfileImage: "lib/assets/image/image2.png", UserName: "이수원"),
    Invite(ProfileImage: "lib/assets/image/image3.jpg", UserName: "이수원2"),
    Invite(ProfileImage: "lib/assets/image/logo.png", UserName: "이수원3"),
    Invite(ProfileImage: "lib/assets/image/profile.png", UserName: "이수원4"),
  ];

  @override
  State<GroupInvite> createState() => _GroupInviteState();
}

class _GroupInviteState extends State<GroupInvite> {
  // 꺽쇠 방향을 돌릴 프로퍼티
  double iconRotate = 1.57;
  // 상세 내용을 눌렀을 때(bool) 초기는 false
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          // 뒤로가기 버튼
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(CupertinoIcons.back,color: grey4),
            onPressed: () {
              Get.back();
            },
          ),
          // 타이틀
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "멤버 초대",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // 완료 버튼
          actions: [
            InkWell(
              onTap: () {

              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 8),
                child: Text("완료",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: mainOrange)),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          // 검색 입력란
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            child: TextField(
              // 텍스트 스타일
              style: TextStyle(decorationThickness: 0,height: 1),
              // 커서 색상
              cursorColor: mainOrange,
              decoration: InputDecoration(
                prefixIcon: Icon(CupertinoIcons.search,color: grey4),
                  fillColor: grey1,
                  filled: true,
                  // ubfocus일 때 border 설정
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: grey2),
                  ),
                  // focus일 때 border 설정
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: grey2)
                  ),
                  hintText: "검색",
                  hintStyle: TextStyle(
                      color: grey4
                  )
              ),
            ),
          ),
          // 디바이더 설정
          GroupDivider(verticalPadding: 0, horizontalPadding: 16),
          // 친구 및 꺽쇠 아이콘 설정
          InkWell(
            onTap: () {
              setState(() {
                isClick = !isClick;
                iconRotate = isClick ? 4.7 : 1.57;
              });
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // "친구" + 검색한 친구 수
                  Text("친구 5",style: TextStyle(fontSize: 12,color: grey3)),
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
            ),
          ),
          if(isClick)
          // 검색한 아이디의 목록
            Expanded(
              child: ListView(
                children: widget.invites.map((invite) => GroupInviteItem(invite: invite)).toList()
              ),
            )
        ],
      ),
    );
  }
}
