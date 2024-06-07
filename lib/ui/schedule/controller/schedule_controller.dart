import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/domain/use_case/schedule_usecase.dart';
import 'package:schedule_with/entity/schedule_tbl.dart';

class ScheduleController extends GetxController {
  // 텍스트필드 컨트롤러 생성 및 초기값 설정
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController contentEditingController = TextEditingController();
  // useCase
  final ScheduleUseCase scheduleUseCase;


  // 스케줄 추가 다이얼로그 관련 설정들

  // DatePicker로 선택한 시작 날짜, 종료 시간 업데이트
  // 시작 날짜, 종료 날짜 설정 변수
  var isStartDt = false.obs;
  var isEndDt = false.obs;

  var selectedStartDt = DateTime.now().obs;
  var selectedEndDt = DateTime.now().obs;

  void updateStartDt(DateTime newDate){
    selectedStartDt.value = newDate;
  }

  void updateEndDt(DateTime newDate){
    selectedEndDt.value = newDate;
  }


  // TimePicker로 선택한 시작 시간, 종료 시간 업데이트
  // 시작시간 또는 종료시간 변경 여부 확인하는 변수
  // 시간 초기값 '선택'으로 띄우기 위해 null로 설정
  var isStartTm = false.obs;
  var isEndTm = false.obs;

  var selectedStartTm = Rx<DateTime?>(null);
  var selectedEndTm = Rx<DateTime?>(null);

  void updateStartTm(DateTime newTime){
    selectedStartTm.value = newTime;
  }

  void updateEndTm(DateTime newTime){
    selectedEndTm.value = newTime;
  }

  // 공개 여부
  var public = '전체공개'.obs;
  var showAll = false.obs;
  var showTitle = false.obs;
  var showNothing = false.obs;

  // 알람에 추가 여부
  var isAlarm = false.obs;



  // UseCase를 매개변수로 받는다
  ScheduleController(this.scheduleUseCase);

  var schedules = <Schedule>[].obs;
  var isLoading = true.obs;

  var endDt = DateTime.now().obs;





  // 파이어베이스엔 Color 타입이 없으니 String 으로 넣어야 하고
  // UI에 띄우려면 Color 타입이어야 해서
  // 둘다 관리
  // RxString 형태로 색상을 관리
  var colorString = "0xFFFF9E9E".obs;

  // Rx<Color> 형태로 색상을 관리
  var color = lightPink.obs;


  // onClose = 컨트롤러가 더이상 사용되지 않을 때 호출되는 메서드
  // 메모리 누수 방지
  @override
  void onClose(){
    // 텍스트필드 컨트롤러 해제
    titleEditingController.dispose();
    contentEditingController.dispose();
    super.onClose();

  }

  @override
  void onInit() {
    super.onInit();
    fetchSchedules();
  }

  // 서버에서 데이터를 가져와 로컬 상태를 갱신함
  void fetchSchedules() async {
    isLoading.value = true;
    scheduleUseCase.readSchedules().listen((scheduleList) {
      schedules.value = scheduleList;
      isLoading.value = false;
    }, onError: (error) {
      // 오류 처리
      isLoading.value = false;
    });
  }

  // 새로운 스케줄을 생성하고 서버에 저장
  void createSchedule({
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
  }) async {
    Schedule newSchedule = Schedule(
      id: '',
      idx: idx,
      title: title,
      color: color,
      startDt: startDt,
      endDt: endDt,
      startTime: startTime,
      endTime: endTime,
      status: status,
      public: public,
      regDt: regDt,
      modDt: modDt,
      content: content,
      userIdx: userIdx,
      groupIdx: groupIdx,
      alarmIdx: alarmIdx,
    );
    // await scheduleUseCase.createSchedule(newSchedule);


    // 기존 스케줄의 정보를 수정하여 서버에 업데이트. 서버 데이터를 변경
    void updateSchedule({
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
    }) async {
      Schedule updatedSchedule = Schedule(
        id: id,
        idx: idx,
        title: title,
        color: color,
        startDt: startDt,
        endDt: endDt,
        startTime: startTime,
        endTime: endTime,
        status: status,
        public: public,
        regDt: regDt,
        modDt: modDt,
        content: content,
        userIdx: userIdx,
        groupIdx: groupIdx,
        alarmIdx: alarmIdx,
      );
      await scheduleUseCase.updateSchedule(updatedSchedule);
    }


    // 특정 스케줄을 서버에서 삭제
    void deleteSchedule(String id) async {
      await scheduleUseCase.deleteSchedule(id);
    }
  }
}