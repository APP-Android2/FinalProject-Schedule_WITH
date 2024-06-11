import '../../entity/paymemo_tbl.dart';
import '../repository/memo/paymemo_repository.dart';

class PayMemoUseCase {
  final PayMemoRepository repository;

  PayMemoUseCase(this.repository);

  Future<void> createPayMemo(PayMemo paymemo) {
    return repository.createPayMemo(paymemo);
  }

  Stream<List<PayMemo>> readPayMemo() {
    return repository.readPayMemos();
  }

  Future<void> updatePayMemo(String paymemoId, PayMemo paymemo) {
    return repository.updatePayMemo(paymemoId, paymemo);
  }

  Future<void> deletePayMemo(String paymemoId) {
    return repository.deletePayMemo(paymemoId);
  }
}