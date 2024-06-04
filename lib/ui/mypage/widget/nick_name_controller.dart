import 'package:get/get.dart';

class NickNameController extends GetxController {
  var nickNameChangeState = false.obs;

  void setNickNameChangeState(bool value) {
    nickNameChangeState.value = value;
  }
}
