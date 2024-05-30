import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MainAlert extends StatefulWidget {
  // final title;
  final msg;
  final YesMsg;
  final NoMsg;

  const MainAlert({super.key,
    this.msg,
    this.YesMsg,
    this.NoMsg
  });

  @override
  State<MainAlert> createState() => _MainAlertState();
}

class _MainAlertState extends State<MainAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(widget.msg,
      ),
      actions: <Widget>[
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () {
                  print('WarningYesNo >> false');
                  Get.back(result: false);
                },
                child: Text(widget.NoMsg),
              ),
            ),
            Container(
              decoration: BoxDecoration(),
              child: MaterialButton(
                onPressed: () {
                  print('WarningYesNo >> true');
                  Get.back(result: true);
                },
                child: Text(widget.YesMsg),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
