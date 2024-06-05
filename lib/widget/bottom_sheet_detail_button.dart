import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:schedule_with/assets/colors/color.dart';


class BottomSheetDetailTextButton extends StatefulWidget {
  final String titleText;
  // 사용자의 선택에 따라 업데이트 할 번수
  final Rx detailText;
  final Color detailTextColor;
  final VoidCallback? onTap;


  const BottomSheetDetailTextButton({
    required this.titleText,
    required this.detailTextColor,
    required this.detailText,
    this.onTap,
    Key? key,
  }): super(key: key);

  @override
  State<BottomSheetDetailTextButton> createState() => _BottomSheetDetailButtonState();
}

class _BottomSheetDetailButtonState extends State<BottomSheetDetailTextButton> {
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: widget.onTap,
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
                  Text( '${widget.titleText}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Obx(()
                  => Text("${widget.detailText}",
                      style: TextStyle(
                        fontSize: 16,
                        color: widget.detailTextColor,
                      )),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}