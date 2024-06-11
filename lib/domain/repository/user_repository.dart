import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/english_words.dart';
import 'package:schedule_with/entity/user_tbl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository{

  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  // userSequence 값을 가져온다.
  Future<int?> getUserSequence() async {
    QuerySnapshot querySnapshot = await _firebase.collection('Sequence').get();
    if (querySnapshot.docs.isNotEmpty) {
      // 첫 번째 문서 가져오기
      DocumentSnapshot doc = querySnapshot.docs.first;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return data['value'];
    } else {
      return null;
    }
  }

  // userSequence 값을 업데이트 한다.
  Future<void> updateUserSequence(int userSequence) async {
    // 특정 문서의 value 필드를 업데이트
    await _firebase.collection('Sequence').doc('UserSequence').update({
      'value': userSequence,
    });
  }

  // 사용자 정보를 firebase에 저장하는 메서드
  Future<void> saveUserInfo(Users user) async {
    await _firebase.collection("user").add({
      'name' : user.name,
      'idx' : user.idx,
      'server_id' : user.server_id,
      'profile_img' : user.profile_img,
      'back_img image' : user.back_img,
      'id' : user.id,
      'pw' : user.pw,
      'email' : user.email,
      'birth' : user.birth,
      'gender' : user.gender,
      'status' : user.status,
      'reg_dt' : user.reg_dt,
      'mod_dt' : user.mod_dt,
      'login_fail_cnt' : user.login_fail_cnt
    });
  }

  // 사용자 정보를 user 컬렉션에 존재하는 document들의 idx의 필드값과 매개변수 idx와 같으면 그 document만 업데이트 하는 메서드
  Future<void> updateUserInfo(Users user, int idx) async {
    // user 컬렉션에서 idx 필드가 매개변수 idx와 같은 문서를 찾음
    QuerySnapshot querySnapshot = await _firebase.collection('user').where('idx', isEqualTo: idx).get();

    // 첫 번째로 매칭되는 문서 가져오기
    DocumentSnapshot doc = querySnapshot.docs.first;

    // 등록일, idx, server_id를 제외한 나머지 해당 문서를 업데이트
    await _firebase.collection('user').doc(doc.id).update({
      'name' : user.name,
      'profile_img' : user.profile_img,
      'back_img image' : user.back_img,
      'id' : user.id,
      'pw' : user.pw,
      'email' : user.email,
      'birth' : user.birth,
      'gender' : user.gender,
      'status' : user.status,
      'mod_dt' : user.mod_dt,
      'login_fail_cnt' : user.login_fail_cnt
    });
  }

  // user 컬렉션에 document들의 id필드값과 매개변수 id와 일치하는 문서가 존재한다면 false를 반환하는 메서드
  Future<bool> doubleCheckId(String id) async {
    // "user" 컬렉션에서 ID와 일치하는 문서를 가져옴
    QuerySnapshot querySnapshot = await _firebase.collection('user').where('id', isEqualTo: id).get();

    if(querySnapshot.docs.isEmpty){
      return true;
    }else{
      return false;
    }
  }

  // user 컬렉션에 document들의 id필드값과 매개변수 id와 일치하는 문서가 존재한다면 false를 반환하는 메서드
  Future<bool> doubleCheckEmail(String email) async {
    // "user" 컬렉션에서 ID와 일치하는 문서를 가져옴
    QuerySnapshot querySnapshot = await _firebase.collection('user').where('email', isEqualTo: email).get();

    if(querySnapshot.docs.isEmpty){
      return true;
    }else{
      return false;
    }
  }

  // 처음 앱 실행전 로컬파일에 server_id 존재 여부에 따라 새로운 유저인지 체크하는 메서드
  Future<bool> isNewUser() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Users user;

    // prefs.remove('server_id');
    // prefs.remove('idx');
    // prefs.remove('status');
    // prefs.remove('server_status');
    // prefs.remove('id');

    if(prefs.getString('server_status') == null){
      // 유저 시퀀스 값을 가져온다.
      var userSequence = await getUserSequence();
      print("print : ${userSequence}");
      // 유저 시퀀스 값을 업데이트 해준다.
      updateUserSequence(userSequence! + 1);

      // 비회원 유저 ID를 생성
      String serverId = WordPair.random().toString();

      // firebase에 유저정보 저장
      user = Users(name: null, idx: userSequence+1, server_id: serverId, profile_img: null,back_img: null, id: null,login_fail_cnt: 0,
          pw: null, email: null, birth: null, gender: null, status: 'Y',
          reg_dt: DateTime.now(), mod_dt: DateTime.now());
      // 저장한다.
      saveUserInfo(user);

      // 로컬파일에 유저정보 저장
      // 비회원 아이디 저장
      await prefs.setString('server_id', serverId);
      // 유저번호 저장
      await prefs.setInt('idx', user.idx);
      // 유저상태
      await prefs.setString('status', user.status);
      // 비회원 상태
      await prefs.setString('server_status', "1");

      return true;
    }
    // 새로운 유저라면..
    else{
      if(prefs.getString('server_id') == null){
        return false;
      }
      else{
        return true;
      }
    }
  }

  // 회원가입 후 로그아웃 하고 비회원 시작을 할 시 새롭게 유저 정보를 저장하는 메서드
  Future<void> logoutNewUser() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Users user;

    // prefs.remove('server_id');
    // prefs.remove('idx');
    // prefs.remove('status');
    // prefs.remove('server_status');
    // prefs.remove('id');

    if(prefs.getString('server_id') == null){
      // 유저 시퀀스 값을 가져온다.
      var userSequence = await getUserSequence();
      print("print : ${userSequence}");
      // 유저 시퀀스 값을 업데이트 해준다.
      updateUserSequence(userSequence! + 1);

      // 비회원 유저 ID를 생성
      String serverId = WordPair.random().toString();

      // firebase에 유저정보 저장
      user = Users(name: null, idx: userSequence+1, server_id: serverId, profile_img: null,back_img: null, id: null,login_fail_cnt: 0,
          pw: null, email: null, birth: null, gender: null, status: 'Y',
          reg_dt: DateTime.now(), mod_dt: DateTime.now());
      // 저장한다.
      saveUserInfo(user);

      // 로컬파일에 유저정보 저장
      // 비회원 아이디 저장
      await prefs.setString('server_id', serverId);
      // 유저번호 저장
      await prefs.setInt('idx', user.idx);
      // 유저상태
      await prefs.setString('status', user.status);
      // 비회원 상태
      await prefs.setString('server_status', "1");

    }
  }
  // 사용자 정보를 user 컬렉션에 존재하는 document들의 id 필드값과 매개변수 id와 같으면 그 document만 가져오는 메서드
  Future<Users?> getUserInfoUseId(String id) async {
    QuerySnapshot querySnapshot = await _firebase.collection('user').where('id', isEqualTo: id).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = querySnapshot.docs.first;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return Users(
        name: data['name'],
        idx: data['idx'],
        server_id: data['server_id'],
        profile_img: data['profile_img'],
        back_img: data['back_img image'],
        id: data['id'],
        pw: data['pw'],
        email: data['email'],
        birth: data['birth'],
        gender: data['gender'],
        status: data['status'],
        reg_dt: (data['reg_dt'] as Timestamp).toDate(),
        mod_dt: (data['mod_dt'] as Timestamp).toDate(),
        login_fail_cnt: data['login_fail_cnt'],
      );
    } else {
      return null;
    }
  }

  // 사용자 정보를 user 컬렉션에 존재하는 document들의 email 필드값과 매개변수 email과 같으면 그 document만 가져오는 메서드
  Future<Users?> getUserInfoUseEmail(String email) async {
    QuerySnapshot querySnapshot = await _firebase.collection('user').where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = querySnapshot.docs.first;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return Users(
        name: data['name'],
        idx: data['idx'],
        server_id: data['server_id'],
        profile_img: data['profile_img'],
        back_img: data['back_img'],
        id: data['id'],
        pw: data['pw'],
        email: data['email'],
        birth: data['birth'],
        gender: data['gender'],
        status: data['status'],
        reg_dt: (data['reg_dt'] as Timestamp).toDate(),
        mod_dt: (data['mod_dt'] as Timestamp).toDate(),
        login_fail_cnt: data['login_fail_cnt'],
      );
    } else {
      return null;
    }
  }

  // 로그인한 유저의 인덱스번호, 비회원 아이디, 회원 아이디를 로컬파일에 담아주는 메서드
  Future<void> saveLocalUserInfo(Users users) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // 비회원 아이디 저장
    await prefs.setString('server_id', users.server_id);
    // 유저번호 저장
    await prefs.setInt('idx', users.idx);
    // 유저상태
    await prefs.setString('status', users.status);
    // 회원아이디
    await prefs.setString('id', users.id!);
  }

  // // 이메일 코드 발송하는 메서드
  // Future<void> sendEmail(String email, String password) async{
  //   FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  //   FirebaseAuth.instance.currentUser?.emailVerified;
  // }
}