import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../assets/colors/color.dart';
import 'friend_profile_item.dart';

class FriendProfile{
  String ProfileImage;
  String UserName;

  FriendProfile({this.ProfileImage ='', required this.UserName});
}

class FriendProfileItem extends StatefulWidget {
  final FriendProfile friendProfile;

  const FriendProfileItem({Key? key, required this.friendProfile}) : super(key: key);

  @override
  State<FriendProfileItem> createState() => _FriendProfileItemState();
}

class _FriendProfileItemState extends State<FriendProfileItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Get.toNamed('/groupDetail');},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 프로필 및 유저 이름
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: grey1,
                      border: Border.all(color: grey2,width: 0.5)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: widget.friendProfile.ProfileImage == "" ? Icon(CupertinoIcons.person_fill, color: mainBrown.withOpacity(0.5))
                        : Image.asset(widget.friendProfile.ProfileImage,fit: BoxFit.cover,)
                  ),
                ),
                Text(widget.friendProfile.UserName)
              ],
            ),
            // 친구요청 버튼
            // FriendAddMiniButton(
            //     text: "그룹초대",
            //     onPressed: () {
            //
            //     },
            //     color: mainOrange
            // )
          ],
        ),
      ),
    );
  }
}
