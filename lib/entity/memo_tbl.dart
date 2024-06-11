import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  String documentId; //파이어베이스 아이디
  int idx;
  final String title;
  final String content;
  final bool hasImage;
  final bool isPublic;
  String status;
  DateTime reg_dt;
  DateTime mod_dt;

  Memo({
    required this.documentId,
    required this.idx,
    required this.status,
    required this.reg_dt,
    required this.mod_dt,
    required this.title,
    required this.content,
    this.hasImage = false,
    this.isPublic = false});

  // 서버에서 데이터 가져올 때 사용
  static Memo fromDocument(Map<String, dynamic> doc, String docId) {
    return Memo(
      documentId: docId,
      idx: doc['idx'] as int? ?? 0,
      status: doc['status'] as String? ?? 'Y',
      reg_dt: (doc['reg_dt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      mod_dt: (doc['mod_dt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      title: doc['title'] as String? ?? '',
      content: doc['content'] as String? ?? '',
      hasImage: doc['hasImage'] ?? false,
      isPublic: doc['public_status'] == 'Y',
    );
  }

  // 서버로 데이터 전달할 때 사용
  Map<String, dynamic> toDocument() {
    String publicStatus = isPublic ? 'Y' : 'N';
    return {
      'documentId' : documentId,
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