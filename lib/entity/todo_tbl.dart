import 'dart:ffi';
// firebase에 저장하기 위한 todoModel
class Todos{
  // 투두 idx
  int idx;
  // 유저 idx
  int user_idx;
  // 그룹 idx
  int group_idx;
  // 투두 지정 날짜
  DateTime todo_dt;
  // 투두 제목
  String title;
  // 투두 상태
  String status;
  // 등록일
  DateTime reg_dt;
  // 수정일
  DateTime? mod_dt;
  // 체크 상태
  bool check;
  Todos({
    required this.idx,
    required this.user_idx,
    required this.group_idx,
    required this.todo_dt,
    required this.title,
    required this.status,
    required this.reg_dt,
    required this.mod_dt,
    required this.check,
  });}
