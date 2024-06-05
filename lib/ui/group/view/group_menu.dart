import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/widget/main_profile.dart';
import '../../../assets/colors/color.dart';
import '../widget/friend_profile_item.dart';
import '../widget/group_divider.dart';
import '../widget/groupl_switch_button.dart';

class GroupMenu extends StatefulWidget {
  final List<FriendProfile> friendProfile = [
    FriendProfile(ProfileImage: "lib/assets/image/logo.png", UserName: "이수원"),
    FriendProfile(ProfileImage: "lib/assets/image/logo.jpg", UserName: "이수원2"),
    FriendProfile(ProfileImage: "lib/assets/image/logo.png", UserName: "이수원3"),
  ];

  GroupMenu({super.key});

  @override
  State<GroupMenu> createState() => _GroupMenuState();
}

class _GroupMenuState extends State<GroupMenu> {
  late final TextEditingController controller;
  // 꺽쇠 방향을 돌릴 프로퍼티
  double iconRotate = 4.7;
  // 상세 내용을 눌렀을 때(bool) 초기는 false
  bool isClick = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("그룹설정",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: InkWell(
            onTap: (){Get.back();},
            child: Icon(CupertinoIcons.back),
          ),
        ),
        body:  Container(
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    flex: 2,
                    child:MainProfile(),
                  ),
                  SizedBox(height: 10,),
                  Flexible(
                      flex: 3,
                      child: Column(
                        children: [
                          GroupSwitchButton(
                            titleText: '구성원 TODO(%)',
                            IsChecked: true,
                          ),
                          GroupSwitchButton(
                            titleText: '알람설정',
                            IsChecked: true,
                          ),
                          // GroupInviteItem(invite: ),
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
                          // 친구 목록
                            Expanded(
                              child: ListView(
                                  children: widget.friendProfile.map((friendProfile) => FriendProfileItem(friendProfile: friendProfile)).toList()
                              ),
                            )
                        ],
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
