import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  int idx;
  final String title;
  final String content;
  final bool hasImage;
  final bool isPublic;
  String status;
  DateTime reg_dt;
  DateTime mod_dt;

  Memo(
      {required this.idx,
        required this.status,
        required this.reg_dt,
        required this.mod_dt,
        required this.title,
        required this.content,
        this.hasImage = false,
        this.isPublic = false});

  // 서버에서 데이터 가져올 때 사용
  static Memo fromDocument(Map<String, dynamic> doc, String idx) {
    return Memo(
      // idx
      // user_idx
      // group_idx
      // status
      idx: doc['idx'],
      status: doc['status'],
      reg_dt: (doc['reg_dt'] as Timestamp).toDate(),
      mod_dt: (doc['mod_dt'] as Timestamp).toDate(),
      title: doc['title'],
      content: doc['content'],
      hasImage: doc['hasImage'] ?? false,
      isPublic: doc['public_status'] == 'Y',
    );
  }

  // 서버로 데이터 전달할 때 사용
  Map<String, dynamic> toDocument() {
    String publicStatus = isPublic ? 'Y' : 'N';
    return {
      // user_idx
      // group_idx
      // status
      'idx': idx,
      'status': status,
      'reg_dt': reg_dt,
      'mod_dt': mod_dt,
      'title': title,
      'content': content,
      'hasImage': hasImage,
      'public_status': publicStatus,
    };
  }
}