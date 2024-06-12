import '../../entity/memo_tbl.dart';
import '../repository/memo/memo_repository.dart';

class MemoUseCase {
  final MemoRepository repository;

  MemoUseCase(this.repository);

  Future<void> createMemo(Memo memo) {
    return repository.createMemo(memo);
  }

  Stream<List<Memo>> readMemo() {
    return repository.readMemos();
  }

  Future<void> updateMemo(String memoId, Memo memo) {
    return repository.updateMemo(memoId, memo);
  }

  Future<void> deleteMemo(String memoId) {
    return repository.deleteMemo(memoId);
  }
}

