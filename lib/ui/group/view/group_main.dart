import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../assets/colors/color.dart';
import '../../../widget/main_app_bar.dart';
import '../widget/group_detail_item.dart';
import '../widget/group_divider.dart';

class GroupMain extends StatefulWidget {
  final List<Invite> invites = [
    Invite(ProfileImage: "lib/assets/image/logo.png", UserName: "이수원"),
    Invite(ProfileImage: "lib/assets/image/logo.jpg", UserName: "이수원2"),
    Invite(ProfileImage: "lib/assets/image/logo.png", UserName: "이수원3"),
    Invite(ProfileImage: "lib/assets/image/profile.png", UserName: "이수원4"),
  ];

  GroupMain({Key? key}) : super(key: key);

  @override
  State<GroupMain> createState() => _GroupMainState();
}

class _GroupMainState extends State<GroupMain> {
  // 꺽쇠 방향을 돌릴 프로퍼티
  double iconRotate = 4.7;
  // 상세 내용을 눌렀을 때(bool) 초기는 false
  bool isClick = false;

  // 각 아코디언 메뉴의 확장 상태를 관리하는 리스트
  List<bool> _isExpandedList = [true, true];

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
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              //   child: Divider(
              //     color: grey2,
              //     height: 1,
              //   ),
              // ),
              // MyAccordionMenu(
              //   title: '그룹 1',
              //   isExpanded: _isExpandedList[0],
              //   onTap: () {
              //     setState(() {
              //       _isExpandedList[0] = !_isExpandedList[0];
              //     });
              //   },
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              //   child: Divider(
              //     color: grey2,
              //     height: 1,
              //   ),
              // ),
              // MyAccordionMenu(
              //   title: '친구 2',
              //   isExpanded: _isExpandedList[1],
              //   onTap: () {
              //     setState(() {
              //       _isExpandedList[1] = !_isExpandedList[1];
              //     });
              //   },
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              //   child: Divider(
              //     color: grey2,
              //     height: 1,
              //   ),
              // ),
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
                      children: widget.invites.map((invite) => GroupDetailItem(invite: invite)).toList()
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

// class MyAccordionMenu extends StatelessWidget {
//   final String title;
//   final bool isExpanded;
//   final VoidCallback onTap;
//
//   const MyAccordionMenu({
//     required this.title,
//     required this.isExpanded,
//     required this.onTap,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ExpansionPanelList(
//       // dividerColor : Colors.white,
//       expandedHeaderPadding : EdgeInsets . all ( 0 ),
//       expansionCallback: (int index, bool isExpanded) {
//         onTap();
//       },
//       children: [
//         ExpansionPanel(
//           headerBuilder: (BuildContext context, bool isExpanded) {
//             return Container(
//               padding: EdgeInsets.zero,
//               height: 40, // ListTile의 높이를 50으로 고정
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.transparent, width: 0.0),
//                 boxShadow: null,
//               ),
//               child: ListTile(
//                 title: Text(title,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: grey4,
//                   ),
//                 ),
//                 // trailing: Icon(
//                 //   isExpanded ? Icons.expand_less : Icons.expand_more,
//                 // ),
//                 onTap: onTap,
//               ),
//             );
//           },
//           body: Column(
//             children: [
//               GroupItem(),
//               GroupItem(),
//               GroupItem(),
//             ],
//           ),
//           isExpanded: isExpanded,
//         ),
//       ],
//     );
//   }
// }


class GroupItem extends StatefulWidget {
  const GroupItem({super.key});

  @override
  State<GroupItem> createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Get.toNamed('/groupDetail');},
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: grey1,
                border: Border.all(color: grey2, width: 1),
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
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
