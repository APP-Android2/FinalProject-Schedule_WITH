import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../entity/memo_tbl.dart';
import '../../../entity/paymemo_tbl.dart';

class PayMemoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createPayMemo(PayMemo paymemo) async {
    DocumentReference ref = await _firestore.collection('paymemo').add(paymemo.toDocument());
    paymemo.documentId = ref.id;
  }

  Stream<List<PayMemo>> readPayMemos() {
    return _firestore.collection('paymemo')
      .where('status', isEqualTo: 'Y')
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => PayMemo.fromDocument(doc.data() as Map<String, dynamic>, doc.id))
      .toList());
  }

  Future<void> updatePayMemo(String paymemoId, PayMemo paymemo) async {
    await _firestore.collection('paymemo').doc(paymemo.documentId).update(paymemo.toDocument());
  }

  Future<void> deletePayMemo(String memoId) async {
    await _firestore.collection('paymemo').doc(memoId).update({'status': 'D'});
  }
}