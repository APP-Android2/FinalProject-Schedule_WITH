import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_with/entity/schedule_tbl.dart';

class ScheduleRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 스케줄 목록을 가져오는 메서드
  Stream<List<Schedule>> getSchedules() {
    return _db.collection('schedule')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Schedule.fromFirestore(doc.data() as Map<String, dynamic>)).toList());
  }

  // 스케줄을 업데이트하는 메서드
  Future<void> updateSchedule(String id, Map<String, dynamic> data) async {
    await _db.collection('schedule').doc(id).update(data);
  }

  // 새로운 스케줄을 추가하는 메서드
  Future<void> addSchedule(Map<String, dynamic> data) async {
    await _db.collection('schedule').add(data);
  }
}
