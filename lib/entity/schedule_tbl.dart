import 'package:cloud_firestore/cloud_firestore.dart';

// lib/entity/schedule_tbl.dart
// 파일명 = 파이어베이스 컬렉션명_tbl
// tbl은 table의 약자

// fireStore -> Repository -> Entity
// 데이터 가져올 때 : 레포지토리에 정의한 readSchedules 메서드를 실행한 값이 Schedule 객체에 담긴다.
// 데이터 전달할 때 : 레포지토리에 정의한 addSchedule 메서드를 통해 새로운 Schedule 객체를 Firestore에 추가 한다.

class Schedule {
  // 변수 선언

  final String id; // 파이어베이스 문서 ID
  final int idx;
  final String title;
  final DateTime startDt;
  final DateTime endDt;
  final DateTime startTime;
  final DateTime endTime;
  final String status;
  final String public; // Y: 전체 공개, N: 부분 공개, D: 비공개
  final DateTime? regDt; // 등록일
  final DateTime? modDt; // 수정일
  final String content; // 메모
  final String color; // 일정 색상
  final int userIdx;
  final int groupIdx;
  final int alarmIdx;

  // Private constructor
  // 외부에서 해당 생성자 직접 호출 불가 = 클래스 생성 방법 통제 가능 = 팩토리 메서드
  // 객체 생성 방법 제어
  Schedule._({
    required this.id,
    required this.idx,
    required this.color,
    required this.title,
    required this.startDt,
    required this.endDt,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.public,
    this.regDt,
    this.modDt,
    required this.content,
    required this.userIdx,
    required this.groupIdx,
    required this.alarmIdx,
  });

  // 팩토리 메서드
  // Public factory constructor
  factory Schedule({
    required String id,
    required int idx,
    required String title,
    String? color,
    DateTime? startDt,
    DateTime? endDt,
    DateTime? startTime,
    DateTime? endTime,
    String? status,
    String? public,
    DateTime? regDt,
    DateTime? modDt,
    String? content,
    int? userIdx,
    int? groupIdx,
    int? alarmIdx,
  }) {
    // ?? 연산자로 null 일 때 디폴트 값 설정 가능
    return Schedule._(
      id: id,
      idx: idx,
      color: color ?? 'lightPink',
      title: title,
      startDt: startDt ?? DateTime.now(),
      endDt: endDt ?? DateTime.now(),
      startTime: startTime ?? DateTime.now(),
      endTime: endTime ?? DateTime.now(),
      status: status ?? 'Y',
      public: public ?? 'Y',
      regDt: regDt, // 기본 값을 Null 로 설정
      modDt: modDt, // 기본 값을 Null 로 설정
      content: content ?? '',
      userIdx: userIdx ?? 0,
      groupIdx: groupIdx ?? 0,
      alarmIdx: alarmIdx ?? 0,
    );
  }

  // 서버에서 데이터 가져올 때 사용
  // fromDocument 메서드
  // doc = Firestore 에서 불러온 맵 형식 데이터
  // [Firestore에서 불러온 맵 형식 데이터] -> [Schedule 객체] 형식으로 변환합니다.
  factory Schedule.fromDocument(String id, Map<String, dynamic> doc) {
    return Schedule(
      id: id, // Firestore 문서 ID
      idx: doc['idx'],
      color: doc['color'],
      title: doc['title'],
      startDt: (doc['start_dt'] as Timestamp).toDate(),
      endDt: (doc['end_dt'] as Timestamp).toDate(),
      startTime: (doc['start_time'] as Timestamp).toDate(),
      endTime: (doc['end_time'] as Timestamp).toDate(),
      status: doc['status'],
      public: doc['public'],
      regDt: (doc['reg_dt'] as Timestamp?)?.toDate(),
      modDt: (doc['mod_dt'] as Timestamp?)?.toDate(),
      content: doc['content'],
      userIdx: doc['user_idx'],
      groupIdx: doc['group_idx'],
      alarmIdx: doc['alarm_idx'],
    );
  }

  // 서버로 데이터 전달할 때 사용
  // toDocument 메서드
  // [Schedule 객체] -> [Firestore에 저장할 수 있는 맵 형식]으로 변환합니다.
  Map<String, dynamic> toDocument() {
    return {
      'idx': idx,
      'color': color,
      'title': title,
      'start_dt': Timestamp.fromDate(startDt),
      'end_dt': Timestamp.fromDate(endDt),
      'start_time': Timestamp.fromDate(startTime),
      'end_time': Timestamp.fromDate(endTime),
      'status': status,
      'public': public,
      'reg_dt': regDt != null ? Timestamp.fromDate(regDt!) : null,
      'mod_dt': modDt != null ? Timestamp.fromDate(modDt!) : null,
      'content': content,
      'user_idx': userIdx,
      'group_idx': groupIdx,
      'alarm_idx': alarmIdx,
    };
  }
}


// 추가 설명
// Firestore -> Entity  (Schedule 객체로 변환 하는 과정 상세
// 1. Firestore 에서 특정 문서를 가져오면 DocumentSnapShot 객체로 반환됨
// 2. DocumentSnapShot에 접근해서 문서의 데이터를 Map<String, dynamic> 형식으로 가져옴
//  Map<String, Dynamic> 형식으로 가져오는 이유 : <필드명, 필드값> 을 가져 오는 건데, 필드명은 String 형식 고정이지만 필드값은 다양한 형태를 가짐.
//  dynamic 은 모든 변수 타입을 허용하기 때문에 dynamic 형식으로 가져 오는 것.
// 3. fromDocument 메서드를 사용하여 데이터 타입을 Schedule 객체에 맞도록