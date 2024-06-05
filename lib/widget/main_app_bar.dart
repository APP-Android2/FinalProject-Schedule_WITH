import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';

class MainAppBar extends StatefulWidget {
  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      title: Container(
        alignment: Alignment.centerLeft,
        child: Image.asset( "lib/assets/image/logo.png",
          height: 35,
        ),
      ),
      actions: [
        IconButton(
            onPressed: (){
              Get.toNamed('/groupSearchFriend');
            },
            icon: SvgPicture.asset("lib/assets/icon/icon_search.svg")
        ),
        IconButton(
            onPressed: (){
              Get.toNamed('/groupFriendAdd');
            },
            icon: SvgPicture.asset("lib/assets/icon/icon_add_friend.svg")
        ),
        IconButton(
            onPressed: (){
              Get.toNamed('/notificationMain');
            },
            icon: SvgPicture.asset("lib/assets/icon/icon_bell_outline.svg")
        )
      ],
    );
  }
}