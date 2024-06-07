import 'package:schedule_with/domain/repository/schedule/schedule_repository.dart';
import 'package:schedule_with/entity/schedule_tbl.dart';

// 비즈니스 로직:
// ScheduleUseCase 클래스는 레포지토리(ScheduleRepository)와 상호작용하여 일정을 생성, 읽기, 업데이트, 삭제하는 비즈니스 로직을 캡슐화합니다.
// 이를 통해 UI 레이어와 데이터 레이어 간의 결합도를 낮추고, 유지 보수성과 테스트 용이성을 높입니다.

// 레포지토리 위임:
// 각 메서드는 실제 데이터 조작 로직을 ScheduleRepository 에 위임 합니다.
// 이를 통해 비즈니스 로직을 쉽게 이해 하고 관리할 수 있으며, 데이터 소스가 변경 되더라도 비즈니스 로직에는 최소한의 영향을 미칩니다.



// ScheduleRepository와 상호작용하여 일정 데이터를 관리하는 역할을 합니다.
// ScheduleDataSource 객체를 사용 하여 일정을 관리하는 비즈니스 로직을 포함합니다.
class ScheduleUseCase {

  // repository 는 ScheduleRepository 타입의 인스턴스이며, 이 클래스의 주요 데이터 소스 역할을 합니다.
  final ScheduleRepository repository;

  // 생성자에서 repository 를 받아서 초기화합니다.
  ScheduleUseCase(this.repository);

  // createSchedule 메서드는 새로운 일정을 생성합니다.
  // Schedule 엔티티 타입 객체 생성
  // repository의 createSchedule 메서드를 호출하여 Firestore에 새로운 일정을 추가 합니다.
  // 비동기 작업을 수행하므로 Future<void> 타입을 반환합니다.
  // Future<void> createSchedule(Schedule schedule) {
  //   return repository.createSchedule(schedule.toDocument());
  // }

  // readSchedules 메서드는 일정을 읽어 옵니다.
  // repository의 readSchedules 메서드를 호출하여 Firestore의 일정 데이터를 스트림 형태로 반환 합니다.
  // 반환 타입은 Stream<List<Schedule>>으로, 일정 목록의 스트림을 반환 합니다.
  Stream<List<Schedule>> readSchedules() {
    return repository.readSchedules();
  }

  // updateSchedule 메서드는 특정 일정을 업데이트 합니다.
  // id, color, title을 매개변수로 받아, repository의 updateSchedule 메서드를 호출하여 Firestore의 특정 일정을 업데이트 합니다.
  // 비동기 작업을 수행하므로 Future<void> 타입을 반환 합니다.
  Future<void> updateSchedule(Schedule schedule) {
    return repository.updateSchedule(schedule);
  }

  // deleteSchedule 메서드는 특정 일정을 삭제합니다.
  // id를 매개변수로 받아, repository의 deleteSchedule 메서드를 호출하여 Firestore의 특정 일정을 삭제 합니다.
  // 비동기 작업을 수행하므로 Future<void> 타입을 반환 합니다.
  Future<void> deleteSchedule(String id) {
    return repository.deleteSchedule(id);
  }


  // 스케줄 컬렉션에서 idx가 일치하는 문서의 색상만 가져오는 함수
  Stream<String> fetchColorByIdx(String idx){
    return repository.fetchColorByIdx(idx);


}

}