import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// SfCalendar 에 스케줄 데이터를 렌더링 하려면, 데이터 모델 타입이 Appointment 여야 함.
// 아이콘 추가 기능 설정을 위해 Appointment 데이터 모델 extends 커스텀
class SfCalendarCustomAppointment extends Appointment {
  final bool alarmStatus;

  SfCalendarCustomAppointment({
    this.alarmStatus = false,

    // 아래는 원래 Appointment 에 정의 되어 있어서 상속 받은 기본 설정들
    required DateTime startTime,
    required DateTime endTime,
    String subject = '',
    Color color = Colors.lightBlue,
    String? notes,
    String? location,
    List<Object>? resourceIds,
    String? recurrenceRule,
    bool isAllDay = false,
    String? startTimeZone,
    String? endTimeZone,
    List<DateTime>? recurrenceExceptionDates,
    Object? recurrenceId,
    Object? id,
  }) : super(
    startTime: startTime,
    endTime: endTime,
    subject: subject,
    color: color,
    notes: notes,
    location: location,
    resourceIds: resourceIds,
    recurrenceRule: recurrenceRule,
    isAllDay: isAllDay,
    startTimeZone: startTimeZone,
    endTimeZone: endTimeZone,
    recurrenceExceptionDates: recurrenceExceptionDates,
    recurrenceId: recurrenceId,
    id: id,
  );
}