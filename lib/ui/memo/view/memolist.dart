import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:schedule_with/assets/colors/color.dart';
import '../widget/memo_controller.dart';
import 'memo.dart';
import 'memo_item.dart';

class MemoListView extends StatelessWidget {
  final MemoController controller = Get.put(MemoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 40,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  child: Center(
                    child: Text(
                      '메모',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainOrange),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Obx(() => Icon(
                          controller.isExpanded.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: mainOrange)),
                      onPressed: controller.toggleExpansion,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1.5,
            thickness: 1.5,
            color: mainOrange,
          ),
          Obx(() => controller.isExpanded.value ? Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: controller.memos.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SwipeActionCell(
                      key: ObjectKey(controller.memos[index]),
                      backgroundColor: Colors.white,
                      trailingActions: <SwipeAction>[
                      SwipeAction(
                        title: "삭제",
                        onTap: (CompletionHandler handler) async {
                          await handler(true);
                          controller.memos.removeAt(index);
                          // setState(() {});
                        },
                        color:  mainBrown,
                        ),
                      ],
                      child: MemoItem(
                        memo: controller.memos[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MemoScreen(memo: controller.memos[index]),
                            ),
                          );
                        },
                        onDelete: () {
                        controller.deleteMemo(index);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 1,
                        color: grey2,
                      ),
                    ),
                  ],
                );
              },
            ),
          ) : Offstage()),
        ],
      ),
    );
  }
}