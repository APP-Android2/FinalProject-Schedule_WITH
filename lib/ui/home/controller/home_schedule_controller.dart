import 'package:get/get.dart';
import 'package:schedule_with/entity/schedule_tbl.dart';
import '../../../domain/use_case/schedule_use_case.dart';

class HomeScheduleController extends GetxController {
  final ScheduleUseCase scheduleUseCase;
  var schedules = <Schedule>[].obs;

  HomeScheduleController({required this.scheduleUseCase});

  @override
  void onInit() {
    super.onInit();
    scheduleUseCase.getSchedules().listen((data) {
      print(data); // 데이터 로그 출력
      schedules.value = data;
    });
  }
}
