import 'package:schedule_with/domain/repository/schedule_repository.dart';
import 'package:schedule_with/entity/schedule_tbl.dart';

class ScheduleUseCase {
  final ScheduleRepository repository;

  ScheduleUseCase(this.repository);

  // 스케줄 목록을 가져오는 메서드
  Stream<List<Schedule>> getSchedules() {
    return repository.getSchedules();
  }

  // 스케줄을 업데이트하는 메서드
  Future<void> updateSchedule(String id, Map<String, dynamic> data) {
    return repository.updateSchedule(id, data);
  }

  // 새로운 스케줄을 추가하는 메서드
  Future<void> addSchedule(Map<String, dynamic> data) {
    return repository.addSchedule(data);
  }
}
