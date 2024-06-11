import '../../entity/paymemo_tbl.dart';
import '../repository/memo/paymemo_repository.dart';

class PayMemoUseCase {
  final PayMemoRepository repository;

  // 생성자에서 repository 를 받아서 초기화합니다.
  PayMemoUseCase(this.repository);


  Future<void> createPayMemo(PayMemo paymemo) {
    // 사용자 ID와 메모 객체를 repository로 전달
    return repository.createPayMemo(paymemo);
  }

  Stream<List<PayMemo>> readPayMemo() {
    return repository.readPayMemos();
  }

  Future<void> updatePayMemo(String paymemoId, PayMemo paymemo) {
    return repository.updatePayMemo(paymemoId, paymemo);
  }

  Future<void> deletePayMemo(String paymemoId) {
    // 사용자 ID와 메모 ID를 기반으로 메모 삭제
    return repository.deletePayMemo(paymemoId);
  }
}