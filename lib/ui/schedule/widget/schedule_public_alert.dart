import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/controller/schedule_controller.dart';

class SchedulePublicAlert extends StatefulWidget {
  // final title;
  final msg;
  final showAll;
  final showTitle;
  final showNothing;

  const SchedulePublicAlert(
      {super.key, this.msg, this.showAll, this.showTitle, this.showNothing});

  @override
  State<SchedulePublicAlert> createState() => _MainAlertState();
}

class _MainAlertState extends State<SchedulePublicAlert> {
  final ScheduleController scheduleController = Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
      return GestureDetector(
        child: Dialog(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 제목
              Container(
                alignment: Alignment.center,
                width: 500,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  border: Border(),
                  color: Colors.white,
                ),
                child: Text(
                  widget.msg,
                ),
              ),
              // 공개 버튼들
              _buildPublicButton('전체 공개', scheduleController.showAll, () {
                _updatePublicState('전체 공개', scheduleController.showAll);
              }),
              _buildPublicButton('일부 공개', scheduleController.showTitle, () {
                _updatePublicState('일부 공개', scheduleController.showTitle);
              }),
              _buildPublicButton('비공개', scheduleController.showNothing, () {
                _updatePublicState('비공개', scheduleController.showNothing);
              }),
            ],
          ),
        ),
      );
    }



    Widget _buildPublicButton(String text, RxBool isActive, VoidCallback onTap) {
    return InkWell(
      child: Obx(() =>
          Container(
            height: 45,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: text == '비공개'
                    ? BorderRadius.vertical(bottom: Radius.circular(10))
                    : null,
                color: isActive.value ? mainOrange : grey1),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isActive.value ? Colors.white : mainBrown),
            ),
          )),
      onTap: onTap,
    );
  }

  void _updatePublicState(String publicState, RxBool activeState) {
    scheduleController.public.value = publicState;
    scheduleController.showAll.value = false;
    scheduleController.showTitle.value = false;
    scheduleController.showNothing.value = false;
    activeState.toggle();
    Get.back();
  }
}
