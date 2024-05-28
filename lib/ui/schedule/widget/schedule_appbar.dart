import 'package:flutter/material.dart';

class ScheduleAppbar extends StatefulWidget implements PreferredSizeWidget {
  const ScheduleAppbar({super.key});

  @override
  State<ScheduleAppbar> createState() => _ScheduleAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _ScheduleAppbarState extends State<ScheduleAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 왼쪽 로고 관련 설정
      leading:
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SizedBox(
          child: Image.asset(
            'lib/assets/image/logo.png',
            fit: BoxFit.contain
          )
        )
      ),
      // 오른쪽 아이콘 관련 설정
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Image.asset('lib/assets/icon/icon_bell_outline.svg')
        )
      ],
    );
  }
}
