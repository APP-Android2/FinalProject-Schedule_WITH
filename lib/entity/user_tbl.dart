import 'dart:ffi';

// firebase에 저장하기 위한 userModel
class Users {
  // 유저 이름
  String? name;

  // 유저번호
  int idx;

  // 비회원 id
  String server_id;

  // 프로필 이미지
  String? profile_img;

  // 배경 이미지
  String? back_img;

  // 회원 id
  String? id;

  // 회원 비밀번호
  String? pw;

  // 회원 이메일
  String? email;

  // 회원 생일
  String? birth;

  // 회원 성별
  String? gender;

  // 회원 상태
  String status;

  // 등록일
  DateTime reg_dt;

  // 수정일
  DateTime? mod_dt;

  // 로그인 실패 횟수
  int login_fail_cnt;

  Users(
      {required this.name,
      required this.idx,
      required this.server_id,
      required this.profile_img,
      required this.back_img,
      required this.id,
      required this.pw,
      required this.email,
      required this.birth,
      required this.gender,
      required this.status,
      required this.reg_dt,
      required this.mod_dt,
      required this.login_fail_cnt});
}
