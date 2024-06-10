import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BottomSheetDetailStartDate extends StatelessWidget {
  final ScheduleController _scheduleController = Get.find<ScheduleController>();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  final String titleText;
  final String detailText;
  final Color detailTextColor;
  final VoidCallback? onTap;

  BottomSheetDetailStartDate({
    required this.titleText,
    required this.detailText,
    required this.detailTextColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: grey2, width: 1)),
          ),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${titleText}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    // 스케줄 추가 바텀시트 UI에 나타나는 값
                    // controller 값 변경시 UI 업데이트 되는 부분
                    Obx(() => Text(
                        '${formatter.format(_scheduleController.selectedStartDt.value)}',
                        style: TextStyle(fontSize: 16, color: detailTextColor)))
                  ])),
        ),
      ),
    );
  }
}
