import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../assets/colors/color.dart';

class GroupProfile extends StatefulWidget {

  final groupName;

  const GroupProfile({super.key, required this.groupName});

  @override
  State<GroupProfile> createState() => _GroupProfileState();
}

class _GroupProfileState extends State<GroupProfile> {

  @override void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 배경 이미지
        Padding(
          padding: EdgeInsets.only(bottom: 35),
          child: InkWell(
            onTap: () {
              // Get.toNamed('/myPageBackgroundPhotoDetail', arguments: _backgroundImage);
            },
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: grey2,
            ),
          ),
        ),
        // 프로필 + 이름 + 수정 아이콘
        Positioned(
            bottom: 0,
            left: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 프로필
                InkWell(
                  onTap: () {
                    // Get.toNamed('/myPageProfilePhotoDetail', arguments: _profileImage);
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: grey1,
                        border: Border.all(color: grey2,width: 1)
                    ),
                    margin: EdgeInsets.only(bottom: 5),
                    child: FittedBox(
                      fit: BoxFit.none,
                      child: Icon(CupertinoIcons.person_fill,
                      color: mainBrown.withOpacity(0.5),
                    ),),
                  ),
                ),
                // 이름 및 수정 아이콘
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 이름
                        Text(widget.groupName ,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: (){ Get.toNamed("/groupMenu");},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 3),
                            child: SvgPicture.asset("lib/assets/icon/icon_setting.svg",
                              color: grey3,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            )
        ),
      ],
    );
  }
}
