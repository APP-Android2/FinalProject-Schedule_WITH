import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainAppBar extends StatefulWidget {
  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Container(
        alignment: Alignment.centerLeft,
        child: Image.asset( "lib/assets/image/logo.png",
          height: 35,
        ),
      ),
      actions: [
        IconButton(onPressed: (){},
            icon: SvgPicture.asset("lib/assets/icon/icon_bell_outline.svg"))
      ],
    );
  }
}
