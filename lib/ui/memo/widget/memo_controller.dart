import 'package:get/get.dart';
import '../view/memo_item.dart';
import '../view/paymemo_item.dart';

class MemoController extends GetxController {
  var memos = <Memo>[].obs;
  var isExpanded = true.obs;


  void deleteMemo(int index) {
    if (index >= 0 && index < memos.length) {
      memos.removeAt(index);
    }
  }

  void addMemo(Memo memo) {
    memos.add(memo);
  }

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }
}

class PayMemoController extends GetxController {
  var paymemos = <PayMemo>[].obs;
  var isExpanded = true.obs;
  var count = 0.obs;

  void deletePayMemo(int index) {
    if (index >= 0 && index < paymemos.length) {
      paymemos.removeAt(index);
    }
  }

  void addPayMemo(PayMemo paymemo) {
    paymemos.add(paymemo);
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

// class PayMemoController extends GetxController {
//
//   final RxList<PayMemo> payMemoList = <PayMemo>[].obs;
//
//   final RxBool isExpanded = false.obs;
//
//   void addPayMemo(PayMemo paymemo) {
//     payMemoList.add(paymemo);
//     update();
//   }
//
//   void toggleExpansion() {
//     isExpanded.value = !isExpanded.value;
//   }
// }