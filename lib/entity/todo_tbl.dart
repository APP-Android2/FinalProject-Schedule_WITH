import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final int idx;
  final int userIdx;
  final int? groupIdx;
  final DateTime todoDt;
  final String title;
  final String todoStatus;
  final String status;
  final DateTime regDt;
  final DateTime? modDt;

  Todo({
    required this.idx,
    required this.userIdx,
    this.groupIdx,
    required this.todoDt,
    required this.title,
    required this.todoStatus,
    required this.status,
    required this.regDt,
    this.modDt,
  });

  factory Todo.fromFirestore(Map<String, dynamic> data) {
    return Todo(
      idx: data['idx'],
      userIdx: data['user_idx'],
      groupIdx: data['group_idx'],
      todoDt: (data['todo_dt'] as Timestamp).toDate(),
      title: data['title'],
      todoStatus: data['todo_status'],
      status: data['status'],
      regDt: (data['reg_dt'] as Timestamp).toDate(),
      modDt: data['mod_dt'] != null ? (data['mod_dt'] as Timestamp).toDate() : null,
    );
  }
}
