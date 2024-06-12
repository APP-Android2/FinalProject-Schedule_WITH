import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../entity/memo_tbl.dart';

// Firestore 데이터베이스 인스턴스를 생성하고 초기화하는 코드입니다.
// 이를 통해 애플리케이션 내에서 Firestore 데이터베이스와 상호작용할 수 있습니다.
class MemoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Memo>> readMemos() {
    return _firestore.collection('memo')
      .where('status', isEqualTo: 'Y')
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => Memo.fromDocument(doc.data() as Map<String, dynamic>, doc.id))
      .toList());
  }

  Future<void> createMemo(Memo memo) async {
    DocumentReference ref = await _firestore.collection('memo').add(memo.toDocument());
    memo.documentId = ref.id;
  }

  Future<void> updateMemo(String memoId, Memo memo) async {
    await _firestore.collection('memo').doc(memo.documentId).update(memo.toDocument());
  }

  Future<void> deleteMemo(String memoId) async {
    await _firestore.collection('memo').doc(memoId).update({'status': 'D'});
  }
}

