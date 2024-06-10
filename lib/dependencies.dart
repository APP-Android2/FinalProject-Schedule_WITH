import 'package:get/get.dart';
import 'package:schedule_with/ui/mypage/controller/mypage_controller.dart';
import 'package:schedule_with/domain/repository/schedule_repository.dart';
import 'package:schedule_with/domain/use_case/schedule_usecase.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';
import 'package:schedule_with/ui/schedule/widget/calendar_cell_custom.dart';

// Get.put으로 의존성 주입 설정
void setupDependencies() {
  // 캘린더 관련
  Get.put(ScheduleRepository());
  Get.put(ScheduleUseCase(Get.find<ScheduleRepository>()));
  Get.put(ScheduleController(Get.find<ScheduleUseCase>()));
  Get.put(CustomCalendarController());
  
  // 마이페이지 관련
  Get.put(MyPageController());
}