import '../../entity/memo_tbl.dart';
import '../repository/memo/memo_repository.dart';

class MemoUseCase {
  final MemoRepository repository;

  // 생성자에서 repository 를 받아서 초기화합니다.
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

//   Future<void> createMemo( String title, String content, bool isPublic, bool hasImage, DateTime date, String status) {
//     return repository.createMemo( title, content,isPublic, hasImage, date, status);
//   }
//
//   // readSchedules 메서드는 일정을 읽어 옵니다.
//   // repository의 readSchedules 메서드를 호출하여 Firestore의 일정 데이터를 스트림 형태로 반환 합니다.
//   // 반환 타입은 Stream<List<Schedule>>으로, 일정 목록의 스트림을 반환 합니다.
//   Stream<List<Memo>> readMemo() {
//     return repository.readMemos();
//   }
//
//   // updateSchedule 메서드는 특정 일정을 업데이트 합니다.
//   // id, color, title을 매개변수로 받아, repository의 updateSchedule 메서드를 호출하여 Firestore의 특정 일정을 업데이트 합니다.
//   // 비동기 작업을 수행하므로 Future<void> 타입을 반환 합니다.
//   Future<void> updateMemo( String title, String content, bool isPublic, bool hasImage, DateTime date, String status) {
//     return repository.updateMemo( title, content,isPublic, hasImage, date, status);
//   }
//
//   // deleteSchedule 메서드는 특정 일정을 삭제합니다.
//   // id를 매개변수로 받아, repository의 deleteSchedule 메서드를 호출하여 Firestore의 특정 일정을 삭제 합니다.
//   // 비동기 작업을 수행하므로 Future<void> 타입을 반환 합니다.
//   Future<void> deleteMemo(int idx) {
//     return repository.deleteMemo(idx as String);
//   }
// }

