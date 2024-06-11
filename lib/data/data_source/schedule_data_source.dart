import 'package:schedule_with/entity/sfcalendar_custom_appointment.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<SfCalendarCustomAppointment> source) {
    appointments = source;
  }
}

// class ScheduleDataSource extends CalendarDataSource {
//   ScheduleDataSource(List<Appointment> source) {
//     appointments = source;
//   }
// }
//
