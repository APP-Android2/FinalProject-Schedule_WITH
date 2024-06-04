import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarChangeViewButton extends StatelessWidget {
  const CalendarChangeViewButton({super.key});

  // void changeView() {
  //   var currentView = CalendarView.month;
  //   if(currentView == CalendarView.month){
  //     currentView = CalendarView.day;
  //   } else {
  //     currentView = CalendarView.month;
  //   }
  // }




  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
        child: IconButton(
          onPressed: () {
          },
          icon: Image.asset('lib/assets/icon/icon_change_view.png'),
        ),

    );
  }
}


