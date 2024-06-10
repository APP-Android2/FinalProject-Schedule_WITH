import 'package:schedule_with/domain/repository/memo_repository.dart';
import 'package:schedule_with/entity/memo_tbl.dart';

class MemoUseCase {
  final MemoRepository repository;

  MemoUseCase(this.repository);

  Stream<List<Memo>> getMemos() {
    return repository.getMemos();
  }
}
