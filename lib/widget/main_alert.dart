import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/login/view/login_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainAlert extends StatefulWidget {
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
    return Dialog(
      backgroundColor: Colors.white.withOpacity(0),
      child:
      Column(
        children: [
          // 야매로 띄우기
          SizedBox(height: 330),
          // 질문
          Container(
            alignment: Alignment.center,
            width: 500,
            // height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Text(widget.msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          // 긍정 버튼
          Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                color: mainBrown
            ),
            child: MaterialButton(
              onPressed: () async {
                if(widget.msg == "로그아웃 하시겠습니까?") {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('server_id');
                  prefs.remove('idx');
                  prefs.remove('status');
                  prefs.remove('id');
                  Get.offAll(LoginMain());
                }
                if(widget.msg == "수정사항을 취소하시겠습니까?"){
                  Get.back();
                  Get.back();
                }
                Get.back(result: false);
              },
              child: Text(widget.YesMsg,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          //버튼 사이 공간
          SizedBox(height: 12),
          //부정버튼
          Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: mainOrange
            ),
            child: MaterialButton(
              onPressed: () {
                print('WarningYesNo >> true');
                Get.back(result: true);
              },
              child: Text(widget.NoMsg,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
