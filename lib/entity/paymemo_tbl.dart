import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PayMemo extends ChangeNotifier {
  String documentId; //파이어베이스 아이디
  int idx;
  DateTime reg_dt;
  DateTime mod_dt;
  final String title;
  final String amount;
  bool isCompleted;
  final String accountNumber;
  final int participantsCount;
  final List<String> usageDetails;
  String status;

  PayMemo({
    required this.documentId,
    required this.idx,
    required this.status,
    required this.title,
    required this.reg_dt,
    required this.mod_dt,
    required this.amount,
    this.isCompleted = false,
    this.accountNumber = '',
    this.participantsCount = 1,
    this.usageDetails = const [] });

  static PayMemo fromDocument(Map<String, dynamic> doc, String docId) {
    return PayMemo(
      documentId: docId,
      idx: doc['idx'] as int? ?? 0,
      title: doc['title'] as String? ?? '',
      reg_dt: (doc['reg_dt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      mod_dt: (doc['mod_dt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      amount: doc['amount'] as String? ?? '0원',
      isCompleted: doc['completed_status'] == 'Y',
      accountNumber: doc['account_idx'] as String? ?? '',
      participantsCount: doc['user_cnt'] as int? ?? 1,
      usageDetails: List<String>.from(doc['usage_detail'] as List<dynamic>? ?? []),
      status: doc['status'] as String? ?? 'Y',
    );
  }

  // 서버로 데이터 전달할 때 사용
  Map<String, dynamic> toDocument() {
    return {
      'documentId' : documentId,
      'idx': idx,
      'title': title,
      'reg_dt': reg_dt,
      'mod_dt': mod_dt,
      'status': status,
      'amount' : amount,
      'account_idx' : accountNumber,
      'user_cnt': participantsCount,
      'usage_detail': usageDetails,
      'completed_status': isCompleted ? 'Y' : 'N',
    };
  }
}