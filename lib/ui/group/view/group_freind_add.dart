import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/ui/group/widget/friend_add_mini_button.dart';

import '../../../assets/colors/color.dart';

class GroupFreindAdd extends StatefulWidget {
  const GroupFreindAdd({super.key});

  @override
  State<GroupFreindAdd> createState() => _GroupFreindAddState();
}

class _GroupFreindAddState extends State<GroupFreindAdd> {
  Map<String?, String> userIDToName = {
    "yj123": "이영주",
    "sm456": "김승미",
    "sw789": "이수원",
    "mj000": "정명재",
  };

  String enteredID = '';
  List<String?> searchedIDs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          // 뒤로가기 버튼
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 8,left: 11),
                alignment: Alignment.centerLeft,
                child: Icon(CupertinoIcons.back,color: grey4)),
          ),
          // 타이틀
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "ID로 친구추가",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // 완료 버튼
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  searchedIDs = userIDToName.keys
                      .where((id) =>
                  id!.toLowerCase() == enteredID.toLowerCase())
                      .toList();
                });
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 16, 8),
                child: Text("완료",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: mainOrange)),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          // 내 아이디 노출
          Container(
            margin: EdgeInsets.fromLTRB(16, 20, 16, 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: grey1
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
                  child: Text("내아이디",style: TextStyle(color: grey4)),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20,top: 10,bottom: 10),
                  child: Text("qwer1234",style: TextStyle(color: grey4)),
                ),
              ],
            ),
          ),
          // 아이디 검색 입력란
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,bottom: 20),
            child: TextField(
              // 텍스트 스타일
              style: TextStyle(decorationThickness: 0),
              // 커서 색상
              cursorColor: mainOrange,
              // Add onChanged callback to update search results
              onChanged: (value) {
                setState(() {
                  // searchedIDs = userIDToName.keys
                  //     .where((id) => id!.toLowerCase().contains(value.toLowerCase()))
                  //     .toList();
                  enteredID = value;
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                // ubfocus일 때 border 설정
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: grey3)
                ),
                // focus일 때 border 설정
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: mainOrange),
                ),
                hintText: "ID를 입력해 주세요",
                hintStyle: TextStyle(
                  color: grey2
                )
              ),
            ),
          ),
          if (searchedIDs.isNotEmpty)
          Column(
            children: searchedIDs.map((id) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 프로필 및 유저 이름
                    Row(
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: grey1,
                              border: Border.all(
                                  color: grey2, width: 0.5)),
                          margin: EdgeInsets.only(right: 10),
                          child: SvgPicture.asset(
                            "lib/assets/icon/icon_plus.svg",
                            width: 15,
                            height: 15,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        // Displaying the user's name (if available)
                        Text(userIDToName[id] ?? "검색 결과가 없습니다."),
                      ],
                    ),
                    // 친구요청 버튼
                    FriendAddMiniButton(
                        text: "친구요청",
                        onPressed: () {},
                        color: mainOrange),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
