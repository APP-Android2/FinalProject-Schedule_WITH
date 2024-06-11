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
        .map((snapshot) =>
        snapshot.docs.map((doc) =>
            Memo.fromDocument(doc.data() as Map<String, dynamic>, doc.id)).toList());
  }

  Future<void> createMemo(Memo memo) async {
    await _firestore.collection('memo').add(
        memo.toDocument());
  }

  //
  // Future<void> updateMemo( Memo memo) async {
  //   await _firestore.collection('memo')
  //       .doc().update(memo.toDocument());
  // }
  Future<void> updateMemo(String memoId, Memo memo) async {
    await _firestore.collection('memo').doc(memoId).update(memo.toDocument());
  }

//   Future<void> deleteMemo() async {
//     await _firestore.collection('memo').doc().update({'status': 'D'});
//   }
// }
  Future<void> deleteMemo(String memoId) async {
    await _firestore.collection('memo').doc(memoId).update({'status': 'D'});
  }
}

  // 문서 생성: 자동 생성된 ID를 사용하며, color, title, public_status, status 정보를 포함합니다.
  // Future<void> createMemo(int idx, String title, String content, bool isPublic, bool hasImage, DateTime date, String status) async {
  //   await _firestore.collection('memo').add({
  //     'idx' : idx,
  //     'title': title,
  //     'content': content,
  //     'hasImage': hasImage,
  //     'public_status': isPublic ? 'Y' : 'N',
  //     'status': status,
  //     'date': date,
  //   });
  // }

//   Future<void> createMemo(Memo memo) async {
//     CollectionReference collection = _firestore.collection('memos').doc(memo.idx).collection('memoDetails');
//     await collection.add({
//       'title': memo.title,
//       'content': memo.content,
//       'hasImage': memo.hasImage,
//       'public_status': memo.isPublic ? 'Y' : 'N',
//       'status': memo.status,
//       'date': memo.date,
//     });
//   }
//
//   // 문서 읽기: Firestore 컬렉션의 스냅샷을 스트림 형태로 반환하며, 문서에 포함된 모든 필드를 Memo 객체로 변환합니다.
//   Stream<List<Memo>> readMemos() {
//     return _firestore.collection('memo')
//           // 삭제되지 않은 메모만 조회
//         .where('status', isEqualTo: 'Y')
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return Memo.fromDocument(doc.data() as Map<String, dynamic>, doc.id);
//       }).toList();
//     });
//   }
//
//   // 문서 업데이트: ID를 통해 특정 문서를 업데이트합니다.
//   Future<void> updateMemo(int idx, String title, String content, bool isPublic, bool hasImage,DateTime date, String status) async {
//     await _firestore.collection('memo').doc(idx as String?).update({
//       // 'idx' : idx,
//       'title': title,
//       'content': content,
//       'hasImage': hasImage,
//       'public_status': isPublic ? 'Y' : 'N',
//       'status': status,
//       'date':date,
//     });
//   }
//
//   // 문서 상태를 'D'로 변경하여 '삭제' 처리
//   Future<void> deleteMemo(String id) async {
//     await _firestore.collection('memo').doc(id).update({
//       'status': 'D'
//     });
//   }
// }

  // Future<void> createMemo(Memo memo) async {
  //   // Create a new collection uniquely identified by timestamp or some unique hash
  //   String collectionID = 'memo_${DateTime.now().millisecondsSinceEpoch}';
  //   await _firestore.collection(collectionID).add({
  //     'title': memo.title,
  //     'content': memo.content,
  //     'hasImage': memo.hasImage,
  //     'public_status': memo.isPublic ? 'Y' : 'N',
  //     'status': 'active',
  //     'date': memo.date,
  //   });
  //   // Optionally, maintain a central registry of all memo collections
  //   await _firestore.collection('memoRegistry').add({
  //     'collectionID': collectionID,
  //     'createdOn': DateTime.now(),
  //   });
  // }

  // // Read all memos by fetching information from a registry of collections
  // Stream<List<Memo>> readMemos() {
  //   return _firestore.collection('memoRegistry')
  //       .snapshots()
  //       .map((snapshot) {
  //     List<Memo> allMemos = [];
  //     snapshot.docs.forEach((registryDoc) async {
  //       String collectionID = registryDoc.data()['collectionID'] as String;
  //       var memosSnapshot = await _firestore.collection(collectionID).get();
  //       for (var memoDoc in memosSnapshot.docs) {
  //         allMemos.add(Memo.fromDocument(memoDoc.data() as Map<String, dynamic>, memoDoc.id));
  //       }
  //     });
  //     return allMemos;
  //   });
  // }

  // Future<void> createMemo(String userId, Memo memo) async {
  //   await _firestore.collection('memo').add(
  //       memo.toDocument());
  // }

  // // Firestore에서 사용자의 모든 메모를 읽어오는 메소드
  // Stream<List<Memo>> readMemos() {
  //   return _firestore.collection('memo')
  //       .where('status', isEqualTo: 'Y')
  //       .snapshots()
  //       .map((snapshot) =>
  //       snapshot.docs
  //           .map((doc) =>
  //           Memo.fromDocument(doc.data() as Map<String, dynamic>, doc.id))
  //           .toList());
  // }
