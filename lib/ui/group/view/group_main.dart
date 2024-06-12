import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/ui/group/widget/friend_profile_item.dart';

import '../../../assets/colors/color.dart';
import '../../../widget/main_app_bar.dart';
import '../widget/group_detail_item.dart';
import '../widget/group_divider.dart';

class GroupMain extends StatefulWidget {
  final List<GroupProfile> groupProfile = [
    GroupProfile(ProfileImage: "", UserName: "스케줄 위드"),
    GroupProfile(ProfileImage: "", UserName: "멋쟁이 사자처럼"),
    GroupProfile(ProfileImage: "", UserName: "안드로이드 스쿨 2기"),
    GroupProfile(ProfileImage: "", UserName: "인천 정모"),
    GroupProfile(ProfileImage: "", UserName: "스터디 그룹"),
    GroupProfile(ProfileImage: "", UserName: "친구모임"),
  ];
  final List<FriendProfile> friendProfile = [
    FriendProfile(ProfileImage: "", UserName: "이영주"),
    FriendProfile(ProfileImage: "", UserName: "김승미"),
    FriendProfile(ProfileImage: "", UserName: "이수원"),
    FriendProfile(ProfileImage: "", UserName: "정명재"),
    FriendProfile(ProfileImage: "", UserName: "이영주"),
  ];

  // GroupMain({Key? key}) : super(key: key);

  @override
  State<GroupMain> createState() => _GroupMainState();
}

class _GroupMainState extends State<GroupMain> {
  // 꺽쇠 방향을 돌릴 프로퍼티
  double groupIconRotate = 4.7;
  double friendIconRotate = 4.7;
  // 상세 내용을 눌렀을 때(bool) 초기는 false
  bool groupIsClick = true;
  bool friendIsClick = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: grey1,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: MainAppBar(),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                color: Colors.white,
                // 본인 프로필
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: grey1,
                        border: Border.all(color: grey2, width: 01),
                      ),
                      margin: EdgeInsets.only(bottom: 5),
                      child: FittedBox(
                        fit: BoxFit.none,
                        child: Icon(CupertinoIcons.person_fill,
                          color: mainBrown.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "김진경",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              // 디바이더 설정
              GroupDivider(verticalPadding: 0, horizontalPadding: 16),
              // 그룹 및 꺽쇠 아이콘 설정
              InkWell(
                onTap: () {
                  setState(() {
                    groupIsClick = !groupIsClick;
                    groupIconRotate = groupIsClick ? 4.7 : 1.57;
                  });
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // "친구" + 검색한 친구 수
                      Text("그룹 5",style: TextStyle(fontSize: 12,color: grey3)),
                      // 꺽쇠 아이콘 설정
                      Transform.rotate(
                        // 1.57 아래 방향
                        // 4.7 윗 방향
                        angle: groupIconRotate,
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
              if(groupIsClick)
              // 그룹 목록
                Expanded(
                  child: ListView(
                      children: widget.groupProfile.map((groupProfile) => GroupDetailItem(groupProfile: groupProfile)).toList()
                  ),
                ),
              GroupDivider(verticalPadding: 0, horizontalPadding: 16),
              // 친구 및 꺽쇠 아이콘 설정
              InkWell(
                onTap: () {
                  setState(() {
                    friendIsClick = !friendIsClick;
                    friendIconRotate = friendIsClick ? 4.7 : 1.57;
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
                        angle: friendIconRotate,
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
              if(friendIsClick)
              // 친구 목록
                Expanded(
                  child: ListView(
                      children: widget.friendProfile.map((friendProfile) => FriendProfileItem(friendProfile: friendProfile)).toList()
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

