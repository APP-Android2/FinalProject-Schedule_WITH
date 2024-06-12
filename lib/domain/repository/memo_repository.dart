import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_with/entity/memo_tbl.dart';

class MemoRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Memo>> getMemos() {
    return _db.collection('memo')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Memo.fromFirestore(doc.data() as Map<String, dynamic>)).toList());
  }
}
