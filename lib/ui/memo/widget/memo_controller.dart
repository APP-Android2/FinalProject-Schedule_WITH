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
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  MemoController({required this.memoUseCase});

  @override
  void onInit() {
    super.onInit();
    fetchMemos();
  }

  Stream<List<Memo>> streamMemos() {
    return firestore.collection('memos').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Memo.fromDocument(doc.data(), doc.id)).toList());
  }

  void fetchMemos() {
    memos.bindStream(memoUseCase.readMemo());
  }

  Future<String> addMemo(Memo memo) async {
    DocumentReference ref = await firestore.collection('memo').add(memo.toDocument());
    return ref.id;
  }

  Future<void> updateMemo(Memo memo) async {
    await memoUseCase.updateMemo(memo.idx.toString(), memo);
    fetchMemos();
  }

  Future<void> deleteMemo(String memoId) async {
    Memo? memo = memos.firstWhereOrNull((m) => m.idx.toString() == memoId);
    if (memo != null) {
      await firestore.collection('memo').doc(memo.documentId).update({'status': 'D'});
      memos.remove(memo);
      update();
    }
  }

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }
}

