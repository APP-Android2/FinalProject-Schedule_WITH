import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_color_user_selected.dart';

class BottomSheetDetailEndTime extends StatelessWidget {
  final ScheduleController scheduleController = Get.find<ScheduleController>();
  final DateFormat formatter = DateFormat('a hh:mm');

  final String titleText;
  final String detailText;
  final Color detailTextColor;
  final VoidCallback? onTap;

  BottomSheetDetailEndTime({
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
                    Obx(() =>
                        Text(
                            scheduleController.selectedEndTm.value == null
                                ? '선택'
                                : formatter.format(scheduleController.selectedEndTm.value!),
                            style: TextStyle(fontSize: 16, color: detailTextColor)))
                  ])),
        ),
      ),
    );
  }
}
