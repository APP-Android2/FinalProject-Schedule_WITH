import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/ui/home/view/home_main.dart';
import 'package:schedule_with/ui/login/view/login_find_fail_id.dart';
import 'package:schedule_with/ui/login/view/login_find_id_password.dart';
import 'package:schedule_with/ui/login/view/login_find_success_id.dart';
import 'package:schedule_with/ui/login/view/login_join.dart';
import 'package:schedule_with/ui/login/view/login_main.dart';
import 'package:schedule_with/ui/login/view/login_password_reset.dart';
import 'package:schedule_with/ui/login/view/login_password_reset_done.dart';
import 'package:schedule_with/ui/login/view/login_read_terms.dart';
import 'package:schedule_with/ui/notification/view/notification_main.dart';
import 'package:schedule_with/ui/notification/view/notification_request_detail.dart';
import 'package:schedule_with/widget/bottom_navigation_bar.dart';

void main(){
  runApp(ScheduleWith());
}

class ScheduleWith extends StatefulWidget {
  const ScheduleWith({super.key});

  @override
  State<ScheduleWith> createState() => _ScheduleWithState();
}

class _ScheduleWithState extends State<ScheduleWith> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 우상단 디버그 표시 제거
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // 커서 포인트 색상 변경
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.transparent
        ),
        primarySwatch: Colors.blue
      ),
      home: BottomNavigationBar2(),
      // Name을 지정하여 페이지 이동
      getPages: [
        GetPage(name: '/join', page: () => LoginJoin()),
        GetPage(name: '/login', page: () => LoginMain()),
        GetPage(name: '/findIdAndPassword', page: () => LoginFindIdAndPassword()),
        GetPage(name: '/findSuccessId', page: () => LoginFindSuccessId()),
        GetPage(name: '/findFailId', page: () => LoginFindFailId()),
        GetPage(name: '/passwordReset', page: () => LoginPasswordReset()),
        GetPage(name: '/passwordResetDone', page: () => LoginPasswordResetDone()),
        GetPage(name: '/readTerms', page: () => LoginReadTerms()),
        GetPage(name: '/notificationMain', page: () => NotificationMain()),
        GetPage(name: '/requestDetail', page: () => NotificationRequestDetail()),
      ],
    );
  }
}