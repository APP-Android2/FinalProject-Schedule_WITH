import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/repository/user_repository.dart';
import '../../../entity/user_tbl.dart';

class MyPageController extends GetxController{

  UserRepository userRepository = UserRepository();
  Users? users;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    users = await userRepository.getUserInfoUseId(prefs.getString('id')!);
    textEditingController.text = "${users?.name}";
     // 사용자 정보를 가져온 후 UI를 업데이트하기 위해 setState 호출
  }

  final TextEditingController textEditingController = TextEditingController();

  var text = "".obs;

  var userUpdated = false.obs; // Add this line
}