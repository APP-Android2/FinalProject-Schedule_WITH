import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../domain/use_case/paymemo_use__case.dart';
import '../../../entity/paymemo_tbl.dart';

class PayMemoController extends GetxController {
  final PayMemoUseCase payMemoUseCase;
  var paymemos = <PayMemo>[].obs;
  var isExpanded = true.obs;
  var count = 0.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  PayMemoController({required this.payMemoUseCase});

  @override
  void onInit() {
    super.onInit();
    fetchPayMemo();
  }

  Stream<List<PayMemo>> streamMemos() {
    return firestore.collection('paymemos').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => PayMemo.fromDocument(doc.data(), doc.id)).toList());
  }

  Future<void> deletePayMemo(String paymemoId) async {
    PayMemo? paymemo = paymemos.firstWhereOrNull((m) => m.idx.toString() == paymemoId);
    if (paymemo != null) {
      await firestore.collection('paymemo').doc(paymemo.documentId).update({'status': 'D'});
      paymemos.remove(paymemo);
      update();
    }
  }

  void fetchPayMemo() async {
    paymemos.bindStream(payMemoUseCase.readPayMemo());
  }

  Future<String> addPayMemo(PayMemo paymemo) async {
    DocumentReference ref = await firestore.collection('paymemo').add(paymemo.toDocument());
    return ref.id;
  }

  Future<void> updatePayMemo(PayMemo paymemo) async {
    await payMemoUseCase.updatePayMemo(paymemo.idx.toString(), paymemo);
    fetchPayMemo();
  }

  Future<void> deleteBasePayMemo(String paymemoId) async {
    await payMemoUseCase.deletePayMemo(paymemoId);
    fetchPayMemo();
  }

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  void incrementCount() {
    count++;
  }

  void decrementCount() {
    if (count > 0) {
      count--;
    }
  }
}

class PayMemoProvider with ChangeNotifier {
  PayMemo _payMemo;

  PayMemoProvider(this._payMemo);

  PayMemo get payMemo => _payMemo;

  void toggleCompleted() {
    _payMemo.isCompleted = !_payMemo.isCompleted;
    notifyListeners();
  }
}