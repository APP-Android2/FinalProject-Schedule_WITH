import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final int? idx;
  final int? userIdx;
  final int? groupIdx;
  final int? alarmIdx;
  final String? title;
  final DateTime? startDt;
  final DateTime? endDt;
  final String? startTime;
  final String? endTime;
  final String? color;
  final String? content;
  final String? publicStatus;
  final String? status;
  final DateTime? regDt;
  final DateTime? modDt;
  final bool? alarmStatus;

  Schedule({
    this.idx,
    this.userIdx,
    this.groupIdx,
    this.alarmIdx,
    this.title,
    this.startDt,
    this.endDt,
    this.startTime,
    this.endTime,
    this.color,
    this.content,
    this.publicStatus,
    this.status,
    this.regDt,
    this.modDt,
    this.alarmStatus,
  });

  factory Schedule.fromFirestore(Map<String, dynamic> data) {
    return Schedule(
      idx: data['idx'] as int?,
      userIdx: data['user_idx'] as int?,
      groupIdx: data['group_idx'] as int?,
      alarmIdx: data['alarm_idx'] as int?,
      title: data['title'] as String?,
      startDt: (data['start_dt'] as Timestamp?)?.toDate(),
      endDt: (data['end_dt'] as Timestamp?)?.toDate(),
      startTime: data['start_time'] as String?,
      endTime: data['end_time'] as String?,
      color: data['color'] as String?,
      content: data['content'] as String?,
      publicStatus: data['public'] as String?,
      status: data['status'] as String?,
      regDt: (data['reg_dt'] as Timestamp?)?.toDate(),
      modDt: (data['mod_dt'] as Timestamp?)?.toDate(),
      alarmStatus: data['alarm_status'] as bool?,
    );
  }
}
