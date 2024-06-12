import 'package:get/get.dart';
import 'package:schedule_with/entity/memo_tbl.dart';

import '../../../domain/use_case/memo_use_case.dart';

class HomeMemoController extends GetxController {
  final MemoUseCase memoUseCase;
  var memos = <Memo>[].obs;

  HomeMemoController({required this.memoUseCase});

  @override
  void onInit() {
    super.onInit();
    memoUseCase.getMemos().listen((data) {
      print('Firestore data: $data'); // Firestore에서 가져온 데이터를 출력하여 확인
      memos.value = data;
    });
  }
}
