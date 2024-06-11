import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../domain/use_case/paymemo_use__case.dart';
import '../../../entity/paymemo_tbl.dart';
import '../view/paymemo_item.dart';

class PayMemoController extends GetxController {
  late final PayMemoUseCase payMemoUseCase;
  var paymemos = <PayMemo>[].obs;
  var isExpanded = true.obs;
  var count = 0.obs;
  late String userId;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  PayMemoController({required this.payMemoUseCase});

  @override
  void onInit() {
    super.onInit();
    // paymemos.bindStream(streamMemos());
    fetchPayMemo();
  }

  Stream<List<PayMemo>> streamMemos() {
    return firestore.collection('paymemos').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => PayMemo.fromDocument(doc.data(), doc.id)).toList());
  }

  void deletePayMemo(int index) {
    if (index >= 0 && index < paymemos.length) {
      paymemos.removeAt(index);
    }
  }

  void fetchPayMemo() async {
    // var stream = payMemoUseCase.readPayMemo(userId);
    // stream.listen((fetchedMemos) {
    //   paymemos.assignAll(fetchedMemos);
    // });
    paymemos.bindStream(payMemoUseCase.readPayMemo());
  }

  // Future<void>  addPayMemo(PayMemo paymemo)  async  {
  //   // paymemos.add(paymemo);
  //   await payMemoUseCase.createPayMemo(paymemo);
  //   fetchPayMemo();
  // }

  Future<String> addPayMemo(PayMemo paymemo) async {
    DocumentReference ref = await firestore.collection('paymemo').add(paymemo.toDocument());
    return ref.id;
  }

  // Future<void> updatePayMemo(PayMemo paymemo) async {
  //   // Firestore에서 문서를 업데이트
  //   await firestore.collection('memo').doc(userId).collection('paymemos').doc(paymemo.id).update(paymemo.toDocument());
  //   fetchPayMemos();  // Firestore에서 최신 데이터를 가져와서 로컬 상태를 업데이트
  // }

  Future<void> updatePayMemo(PayMemo paymemo) async {
    // await payMemoUseCase.updatePayMemo(userId, paymemo.idx, paymemo);
    // fetchPayMemos();
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

// class PayMemo extends ChangeNotifier {
//   String date;
//   String title;
//   String amount;
//   bool isCompleted;
//   String accountNumber;
//   int participantsCount;
//   List<String> usageDetails;
//
//   PayMemo({
//     required this.date,
//     required this.title,
//     required this.amount,
//     this.isCompleted = false,
//     this.accountNumber = '',
//     this.participantsCount = 1,
//     this.usageDetails = const [],
//   });
//
//   void toggleCompleted() {
//     isCompleted = !isCompleted;
//     notifyListeners();
//   }
// }

class PayMemoProvider with ChangeNotifier {
  PayMemo _payMemo;

  PayMemoProvider(this._payMemo);

  PayMemo get payMemo => _payMemo;

  void toggleCompleted() {
    _payMemo.isCompleted = !_payMemo.isCompleted;
    notifyListeners();
  }
}