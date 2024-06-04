import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// 샘플 데이터
DataSource getDataSource() {
  final List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
    startTime: DateTime.now().add(Duration(hours: 4)),
    endTime: DateTime.now().add(Duration(hours: 5)),
    subject: 'Meeting',
    color: lightBlue,
  ));
  appointments.add(Appointment(
    startTime: DateTime.now().add(Duration(days: -2, hours: 4)),
    endTime: DateTime.now().add(Duration(days: -2, hours: 5)),
    subject: 'Development Meeting   New York, U.S.A',
    color: lightPink,
  ));
  appointments.add(Appointment(
    startTime: DateTime.now().add(Duration(days: -2, hours: 3)),
    endTime: DateTime.now().add(Duration(days: -2, hours: 4)),
    subject: 'Project Plan Meeting   Kuala Lumpur, Malaysia',
    color: lightPink,
  ));
  appointments.add(Appointment(
    startTime: DateTime.now().add(Duration(days: -2, hours: 2)),
    endTime: DateTime.now().add(Duration(days: -2, hours: 3)),
    subject: 'Support - Web Meeting   Dubai, UAE',
    color: lemon,
  ));
  appointments.add(Appointment(
    startTime: DateTime.now().add(Duration(days: -2, hours: 1)),
    endTime: DateTime.now().add(Duration(days: -2, hours: 2)),
    subject: 'Project Release Meeting   Istanbul, Turkey',
    color: apricot,
  ));
  appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 4, days: -1)),
      endTime: DateTime.now().add(const Duration(hours: 5, days: -1)),
      subject: 'Release Meeting',
      color: apricot,
      isAllDay: true));
  appointments.add(Appointment(
    startTime: DateTime.now().add(const Duration(hours: 2, days: -4)),
    endTime: DateTime.now().add(const Duration(hours: 4, days: -4)),
    subject: 'Performance check',
    color: lightPurple,
  ));
  appointments.add(Appointment(
    startTime: DateTime.now().add(const Duration(hours: 11, days: -2)),
    endTime: DateTime.now().add(const Duration(hours: 12, days: -2)),
    subject: 'Customer Meeting   Tokyo, Japan',
    color: lightGrey,
  ));
  appointments.add(Appointment(
    startTime: DateTime.now().add(const Duration(hours: 6, days: 2)),
    endTime: DateTime.now().add(const Duration(hours: 7, days: 2)),
    subject: 'Retrospective',
    color: lightGrey,
  ));

  return DataSource(appointments);
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}


