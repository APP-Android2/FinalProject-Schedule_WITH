import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
import 'package:schedule_with/ui/mypage/view/my_page_info_modify.dart';
import 'package:schedule_with/ui/notification/view/notification_main.dart';
import 'package:schedule_with/ui/notification/view/notification_request_detail.dart';
import 'package:schedule_with/widget/main_bottom_navigation_bar.dart';



void main() {
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ko', ''), // Korean, no country code
      ],
      // 요일을 한국어로 변경하기 위한 작업
      locale: const Locale('ko'),
      // 우상단 디버그 표시 제거
      debugShowCheckedModeBanner: false,
      // 테마
      theme: ThemeData(
        // DatePicker
        datePickerTheme: DatePickerThemeData(
          backgroundColor: Colors.white,
        ),
        // Dialog
        dialogTheme: DialogTheme(
            backgroundColor: Colors.white
        ),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
        ),
        textSelectionTheme:
        // 커서 포인트 색상 변경
        TextSelectionThemeData(selectionHandleColor: Colors.transparent),
        primarySwatch: Colors.blue,
        // 배경 컬러
        scaffoldBackgroundColor: Colors.white,

      ),

      home: MainBottomNavigationBar(),

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
        GetPage(name: '/myPageInfoModify', page: () => MyPageInfoModify()),
      ],
    );
  }
}