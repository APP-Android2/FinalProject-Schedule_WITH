import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  final int idx;
  final int userIdx;
  final int? groupIdx; // Nullable
  final String title;
  final String content;
  final bool publicStatus;
  final String status;
  final DateTime regDt;
  final DateTime modDt;

  Memo({
    required this.idx,
    required this.userIdx,
    this.groupIdx,
    required this.title,
    required this.content,
    required this.publicStatus,
    required this.status,
    required this.regDt,
    required this.modDt,
  });

  factory Memo.fromFirestore(Map<String, dynamic> data) {
    return Memo(
      idx: data['idx'],
      userIdx: data['user_idx'],
      groupIdx: data['group_idx'],
      title: data['title'],
      content: data['content'],
      publicStatus: data['public_status'],
      status: data['status'],
      regDt: (data['reg_dt'] as Timestamp).toDate(),
      modDt: (data['mod_dt'] as Timestamp).toDate(),
    );
  }
}
