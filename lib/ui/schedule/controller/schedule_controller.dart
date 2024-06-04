import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';

class ScheduleController extends GetxController {
  // 사용자가 선택하기 전 초기값
  Rx<DateTime> selectedDateTime = DateTime.now().obs;
  RxString visibility = '전체 공개'.obs;
  Rx<Color> selectedColor = grey4.obs;

  // 공개 여부 값 업데이트
  void settingVisibility(String newValue) {
    visibility.value = newValue;
  }

  // 시작날짜, 마침날짜 업데이트
  void settingDate(DateTime newValue) {
    selectedDateTime.value = newValue;
  }

  // 색깔 업데이트
  void settingColor(Color newValue) {
    selectedColor.value = newValue;
  }

}