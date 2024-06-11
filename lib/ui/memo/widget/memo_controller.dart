import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../domain/use_case/memo_use_case.dart';
import '../../../entity/memo_tbl.dart';
import '../../../entity/paymemo_tbl.dart';

class MemoController extends GetxController {
  final MemoUseCase memoUseCase;
  var memos = <Memo>[].obs;
  var isExpanded = true.obs;
  var isPublic = false.obs;
  var titleController = TextEditingController().obs;
  var contentController = TextEditingController().obs;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  MemoController({required this.memoUseCase});

  @override
  void onInit() {
    super.onInit();
    // memos.bindStream(streamMemos());
    // memos.bindStream(memoUseCase.readMemo());
    fetchMemos();
  }

  // Stream<List<Memo>> streamMemos() {
  //   return firestore.collection('memos').snapshots().map((snapshot) =>
  //       snapshot.docs.map((doc) => Memo.fromDocument(doc.data(), doc.id)).toList());
  // }


//   void fetchMemos() async {
//     var fetchedMemos = await memoUseCase.readMemo();
//     memos.assignAll(fetchedMemos as Iterable<Memo>);
//   }
//
//   void deleteMemo(int index) {
//     if (index >= 0 && index < memos.length) {
//       var memoId = memos[index].idx;
//       memoUseCase.deleteMemo(memoId).then((_) {
//         memos.removeAt(index);
//       });
//     }
//   }
//
//   Future<void> updateMemo(Memo memo) async {
//     int index = memos.indexWhere((m) => m.idx == memo.idx);
//     if (index != -1) {
//       memos[index] = memo;
//       await memoUseCase.updateMemo(
//         memo.idx,
//         memo.title,
//         memo.content,
//         memo.isPublic,
//         memo.hasImage,
//         memo.date,
//         memo.status,
//       );
//       update();
//     }
//   }
//
//   Future<void> addMemo(Memo memo) async {
//     await memoUseCase.createMemo(
//       memo.idx,
//       memo.title,
//       memo.content,
//       memo.isPublic,
//       memo.hasImage,
//       memo.date,
//       memo.status,
//     ).then((_) {
//       memos.add(memo);
//       fetchMemos();
//     });
//   }
//
//   void toggleExpansion() {
//     isExpanded.value = !isExpanded.value;
//   }
// }


  // void fetchMemos() async {
  //   var stream = memoUseCase.readMemo();
  //   stream.listen((fetchedMemos) {
  //     memos.assignAll(fetchedMemos);
  //   });
  // }
  void fetchMemos() {
    memos.bindStream(memoUseCase.readMemo());
  }

  Future<void> addMemo(Memo memo) async {
    // memos.add(memo);
    await memoUseCase.createMemo(memo);
    fetchMemos();
  }

  Future<void> updateMemo(Memo memo) async {
    // await memoUseCase.updateMemo(userId, memo.idx, memo);
    // fetchMemos();
    // await firestore.collection('memo').doc(memo.idx as String?).update(memo.toDocument());
    // fetchMemos();
    // await memoUseCase.updateMemo(memo.idx.toString(), memo);
    // fetchMemos();
      try {
        await memoUseCase.updateMemo(memo.idx.toString(), memo);
        fetchMemos();
      } catch (e) {
        print("Error updating memo: ${e.toString()}");
    }
  }
  //
  // Future<void> deleteMemo(String idx) async {
  //   await memoUseCase.deleteMemo(idx);
  //   fetchMemos();
  // }

  Future<void> deleteMemo(String memoId) async {
    Memo? memo = memos.firstWhereOrNull((m) => m.idx.toString() == memoId);
    if (memo != null) {
      memo.status = 'D'; // 상태를 'D'로 설정
      await memoUseCase.updateMemo(memoId, memo);
      fetchMemos();
    }
  }

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }
}

