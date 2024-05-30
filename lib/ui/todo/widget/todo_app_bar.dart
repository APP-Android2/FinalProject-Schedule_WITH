import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedule_with/assets/colors/color.dart';

class TodoAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TabController tabController;

  const TodoAppBar({super.key, required this.tabController});

  @override
  State<TodoAppBar> createState() => _TodoAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 48.0);
}

class _TodoAppBarState extends State<TodoAppBar> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Container(
        alignment: Alignment.centerLeft,
        child: Image.asset(
          "lib/assets/image/logo.png",
          height: 35,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset("lib/assets/icon/icon_bell_outline.svg"),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: TabBar(
                  controller: widget.tabController,
                  indicatorColor: mainOrange,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: const TextStyle(fontSize: 14),
                  indicator: const BoxDecoration(color: mainOrange),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: '캘린더'),
                    Tab(text: 'TODO'),
                    Tab(text: '메모'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
