import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../assets/colors/color.dart';

class GroupProfile{
  String ProfileImage = '';
  String UserName;

  GroupProfile({this.ProfileImage = '', required this.UserName});
}

class GroupDetailItem extends StatefulWidget {
  final GroupProfile groupProfile;

  const GroupDetailItem({Key? key, required this.groupProfile}) : super(key: key);

  @override
  State<GroupDetailItem> createState() => _GroupDetailItemState();
}

class _GroupDetailItemState extends State<GroupDetailItem> {
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
                      child: widget.groupProfile.ProfileImage == "" ? Icon(CupertinoIcons.person_fill, color: mainBrown.withOpacity(0.5))
                          : Image.asset(widget.groupProfile.ProfileImage,fit: BoxFit.cover,)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.groupProfile.UserName,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(widget.groupProfile.UserName,
                      style: TextStyle(
                        fontSize: 12,
                        color: grey3,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}