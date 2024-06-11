import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_with/entity/schedule_tbl.dart';

// 파이어베이스 컬렉션에 접근
// CRUD

class ScheduleRepository {
  // Firestore 데이터베이스 인스턴스를 생성하고 초기화하는 코드입니다.
  // 이를 통해 애플리케이션 내에서 Firestore 데이터베이스와 상호작용할 수 있습니다.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // .add
  // 문서 생성: 자동 생성된 ID를 사용
  Future<void> createSchedule(Schedule schedule) async {
    await _firestore.collection('schedule').add(schedule.toDocument());
  }

  // .snapshots().map
  // 문서 읽어 오기
  // 컬렉션에 있는 모든 문서의 리스트를 가져옴
  Stream<List<Schedule>> getAllSchedules() {
    print('레포지토리');
    // snapshots() : QuerySnapshot 스트림 반환.
    // 이 스트림은 컬렉션의 현재 상태와 이후 모든 변경 사항을 포함한다.
    // map((snapshot) => ...) : 스트림의 각 QuerySnapshot을 처리하여 원하는 형태로 변환.
    return _firestore.collection('schedule').snapshots().map((snapshot) {
      // snapshot.docs : 스트림의 각 QuerySnapshot을 변환하여 DocumentSnapshot 리스트를 가져옵니다.
      // 각 DocumentSnapshot을 Schedule 객체로 변환하기 위해 map 함수를 사용
      // 항상 리스트를 반환
      return snapshot.docs.map((doc) {
        // 각 문서의 데이터를 Schedule 객체로 변환
        return Schedule.fromDocument(doc.id, doc.data());
        // toList() : 변환된 Schedule 객체들을 리스트로 묶어 반환
      }).toList();
    });
  }

  // .update
  // 문서의 필드값 업데이트
  Future<void> updateSchedule(Schedule schedule) async {
    await _firestore
        .collection('schedule')
        .doc(schedule.id)
        .update(schedule.toDocument());
  }

  // .set
  // 엔티티를 매개변수로 받음
  // schedule 엔티티에 정의해놓은 toDocument 메서드로 map 형태로 변환해줌
  void setSchedule(Schedule schedule) async {
    try {
      await _firestore
          .collection('schedules')
          .doc(schedule.id)
          .set(schedule.toDocument());
      print("Document successfully set with merge!");
    } catch (e) {
      print("Error setting document: $e");
    }
  }

  // 특정 idx에 해당하는 color 값만 가져오기
  Stream<String> fetchColorByIdx(String idx) {
    return _firestore
        .collection('schedule')
        .where('idx', isEqualTo: idx)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data()['color'] as String;
      } else {
        throw Exception('No document found with Idx: $idx');
      }
    });
  }

  // user idx가 일치하는 문서 정보만 가져오기
  Stream<Schedule> fetchScheduleByUserIdx(int userIdx) {
    return _firestore
        .collection('schedule')
        .where('user_idx', isEqualTo: userIdx)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        // doc = QueryDocumentSnapshot 객체 (문서 1개)
        // first = 조건이 일치하는 문서 중에 첫번째 문서만 가져 온다
        // 주로 user idx 처럼 조건 일치하는 문서가 딱 하나 밖에 없을 때 사용
        var doc = snapshot.docs.first;
        // doc.id = 가져온 문서의 id
        // doc.data() = 해당 문서에서 실제 데이터를 가져오는 메서드
        // fireStore 데이터로부터 schedule 객체를 생성하는 팩토리 메서드

        print('레포지토리 fetchScheduleByUserIdx의 ${doc.id}');

        return Schedule.fromDocument(doc.id, doc.data());
      } else {
        // 문서가 없는 경우 예외를 던짐
        throw Exception('No document found with userIdx: $userIdx');
      }
    });
  }

  // Alarm Status 가 true 인 문서 정보만 가져오기
  Stream<List<Schedule>> fetchScheduleByAlarmStatus(bool alarmStatus) {
    return _firestore
        .collection('schedule')
        .where('alarm_status', isEqualTo: alarmStatus)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          return Schedule.fromDocument(doc.id, doc.data());
        }).toList();
      } else {
        throw Exception('No document found with alarmStatus: $alarmStatus');
      }
    });
  }
}
