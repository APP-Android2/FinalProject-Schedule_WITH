import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_color_option.dart';

class BottomSheetDetailColorButton extends StatelessWidget {


  final String titleText;
  // 사용자의 선택에 따라 업데이트 할 번수
  final Rx<Color> detailColor;
  final VoidCallback? onTap;


  const BottomSheetDetailColorButton({
    required this.titleText,
    required this.detailColor,
    this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: grey2, width: 1)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( '${titleText}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  // controller 값 변경시 UI 업데이트
                  Obx(() => DisplayColor(colorName: detailColor.value))]
                )
              ),
            ),
          ),
        );
  }
}
