import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../assets/colors/color.dart';

class Invite{
  String ProfileImage;
  String UserName;

  Invite({required this.ProfileImage, required this.UserName});
}

class GroupInviteItem extends StatefulWidget {
  final Invite invite;

  const GroupInviteItem({Key? key, required this.invite}) : super(key: key);

  @override
  State<GroupInviteItem> createState() => _GroupInviteItemState();
}

class _GroupInviteItemState extends State<GroupInviteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: widget.invite.ProfileImage == "" ? SvgPicture.asset("lib/assets/icon/icon_plus.svg", width: 15, height: 15, fit: BoxFit.scaleDown,)
                      : Image.asset(widget.invite.ProfileImage,fit: BoxFit.cover,)
                ),
              ),
              Text(widget.invite.UserName)
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
    );
  }
}
