import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/data/data_source/schedule_data_source.dart';
import 'package:schedule_with/domain/use_case/schedule_usecase.dart';
import 'package:schedule_with/entity/schedule_tbl.dart';
import 'package:schedule_with/ui/schedule/widget/calendar_cell_custom.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleController extends GetxController {

  // useCase
  final ScheduleUseCase scheduleUseCase;
  // UseCase를 매개변수로 받는다
  ScheduleController(this.scheduleUseCase);

  // 텍스트필드 컨트롤러 생성 및 초기값 설정
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController contentEditingController = TextEditingController();

  // 초기엔 일정 데이터가 없는 빈 리스트로 선언
  var _dataSource = ScheduleDataSource([]).obs;

  // entity
  var schedule = Schedule(
    id: '',
    idx: 0,
    title: '',
    color: lightPink,
    startDt: DateTime.now(),
    endDt: DateTime.now(),
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    status: '',
    public: '',
    regDt: DateTime.now(),
    modDt: DateTime.now(),
    content: '',
    userIdx: 0,
    groupIdx: 0,
    alarmIdx: 0,
  );


  // Schedule 객체의 리스트를 저장하는 변수
  // obs = 데이터가 변경 될 때 이를 자동으로 감지하여 UI 업데이트
  var schedules = <Schedule>[];

  // 데이터를 로드하는 동안 true
  var isLoading = true.obs;

  // DatePicker로 선택한 날짜 업데이트
  var isStartDt = false.obs;
  var isEndDt = false.obs;

  var selectedStartDt = DateTime.now().obs;
  var selectedEndDt = DateTime.now().obs;

  // TimePicker로 선택한 시간 업데이트
  var isStartTm = false.obs;
  var isEndTm = false.obs;

  // 시간 초기값 텍스트를 '선택'으로 띄우기 위해 null로 설정
  var selectedStartTm = Rx<DateTime?>(null);
  var selectedEndTm = Rx<DateTime?>(null);

  // 공개 여부
  var public = '전체공개'.obs;
  var showAll = false.obs;
  var showTitle = false.obs;
  var showNothing = false.obs;

  // RxString 형태로 색상을 관리
  // var colorString = "0xFFFF9E9E".obs;
  // Rx<Color> 형태로 색상을 관리
  var color = lightPink.obs;

  // 알람에 추가 여부
  var isAlarm = false.obs;

  // Y: 정상, D: 삭제
  var status = 'Y'.obs;


  // onClose = 컨트롤러가 더이상 사용되지 않을 때 호출되는 메서드 (메모리 누수 방지)
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
    fetchCalendarDataSource();
  }

  // 바텀시트 열 때마다 필드값 초기화
  void resetFields() {
    titleEditingController.clear();
    contentEditingController.clear();
    public.value = '전체 공개';
    color.value = lightPink;
    isAlarm.value = false;
  }

  // 캘린더에서 날짜 선택 시 해당 날짜로 시작 날짜 업데이트
  void updateStartDt(DateTime newDate){
    selectedStartDt.value = newDate;
  }

  // 캘린더에서 날짜 선택 시 해당 날짜로 마침 날짜 업데이트
  void updateEndDt(DateTime newDate){
    selectedEndDt.value = newDate;
  }

  void updateStartTm(DateTime newTime){
    selectedStartTm.value = newTime;
  }

  void updateEndTm(DateTime newTime){
    selectedEndTm.value = newTime;
  }

  // 서버에서 데이터를 가져와 로컬 상태를 갱신함
  void fetchSchedules() async {
    isLoading.value = true;
    scheduleUseCase.readSchedules().listen((scheduleList) {
      schedules = scheduleList;
      isLoading.value = false;
    }, onError: (error) {
      // 오류 처리
      isLoading.value = false;
    });
  }


  // 데이터가 갱신될 때만 업데이트
  void fetchCalendarDataSource() async {
    scheduleUseCase.getCalendarDataSource().listen((dataSource) {
      _dataSource.value = dataSource;
    });
  }

  // ScheduleDataSource 타입의 실제 데이터를 반환
  ScheduleDataSource get dataSource => _dataSource.value;

  // 사용자가 입력한 값을 서버에 저장하고 로컬 리스트에 추가하는 메서드
  void addSchedule() async {
    isLoading.value = true;

    Schedule newSchedule = Schedule(
      id: '',
      idx: schedules.length, // 새로운 인덱스 설정
      title: titleEditingController.text,
      color: color.value,
      startDt: selectedStartDt.value,
      endDt: selectedEndDt.value,
      startTime: selectedStartTm.value ?? DateTime.now(),
      endTime: selectedEndTm.value ?? DateTime.now(),
      status: status.value,
      public: public.value,
      regDt: DateTime.now(),
      modDt: DateTime.now(),
      content: contentEditingController.text,
      userIdx: 0, // 필요에 따라 설정
      groupIdx: 0, // 필요에 따라 설정
      alarmIdx: 0, // 필요에 따라 설정
    );

    try {
      // 서버에 새로운 스케줄 저장
      await scheduleUseCase.createSchedule(newSchedule);

      // 서버에 성공적으로 저장되면 로컬 리스트에 추가
      schedules.add(newSchedule);
    } catch (e) {
      // 오류 처리
      print('Error adding schedule: $e');
    } finally {
      isLoading.value = false;
    }
  }

}
