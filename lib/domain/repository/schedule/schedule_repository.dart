import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_with/entity/schedule_tbl.dart';

// lib/repositories/schedule_repository.dart
// 파이어베이스 컬렉션에 접근
// CRUD

class ScheduleRepository {
  // Firestore 데이터베이스 인스턴스를 생성하고 초기화하는 코드입니다.
  // 이를 통해 애플리케이션 내에서 Firestore 데이터베이스와 상호작용할 수 있습니다.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // .add
  // 문서 생성: 자동 생성된 ID를 사용
  // 생성된 문서의 ID를 나중에 사용할 수 있도록 합니다.
  Future<void> createSchedule(Schedule schedule) async {
    // await _firestore.collection('schedule').add(schedule);
  }

  // .snapshots().map
  // 문서 읽기: 자동 생성된 ID를 포함하여 읽음
  // readSchedules 메서드는 Firestore 컬렉션의 스냅샷을 스트림 형태로 반환합니다.
  // 각 문서는 Schedule.fromDocument 메서드를 통해 Schedule 객체로 변환되며, 이 과정에서 문서의 ID도 함께 사용됩니다.
  Stream<List<Schedule>> readSchedules() {
    return _firestore.collection('schedule').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Schedule.fromDocument(doc.id, doc.data());
      }).toList();
    });
  }

  // .update
  // 문서 업데이트: ID를 통해 특정 문서 업데이트
  // 이 ID는 생성 시 저장된 ID입니다.
  Future<void> updateSchedule(Schedule schedule) async {
    await _firestore.collection('schedule').doc(schedule.id).update(schedule.toDocument());
  }

  // .delete
  // 문서 삭제: ID를 통해 특정 문서 삭제
  Future<void> deleteSchedule(String id) async {
    await _firestore.collection('schedule').doc(id).delete();
  }

  // 모든 일정 읽기
  // 컬렉션의 모든 문서를 읽어 Schedule 객체 리스트로 변환
  Stream<List<Schedule>> getAllSchedules() {
    return _firestore.collection('schedule').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Schedule.fromDocument(doc.id, doc.data());
      }).toList();
    });
  }

  // 특정 idx에 해당하는 color 값만 가져오기
  Stream<String> fetchColorByIdx(String idx) {
    return _firestore
        .collection('schedule').where('Idx', isEqualTo: idx)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data()['color'] as String;
      } else {
        throw Exception('No document found with Idx: $idx');
      }
    });
  }
}
