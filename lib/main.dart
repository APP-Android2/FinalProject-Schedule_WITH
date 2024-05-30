import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:schedule_with/ui/alarm/view/alram_main.dart';

void main() {
  runApp(const ScheduleWith());
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
      home: AlramMain(),
    );
  }
}
