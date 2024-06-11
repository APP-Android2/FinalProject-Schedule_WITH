import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/memo/view/paymemo.dart';
import 'package:schedule_with/ui/memo/view/paymemo_item.dart';

import '../../../domain/repository/memo/paymemo_repository.dart';
import '../../../domain/use_case/paymemo_use__case.dart';
import '../widget/paymemo_controller.dart';

class PayMemoListView extends StatelessWidget {
  final PayMemoController controller;
  // final PayMemoController controller = Get.put(PayMemoController());

  // PayMemoListView({super.key}) : controller = Get.put(PayMemoController(
  //     payMemoUseCase: PayMemoUseCase(PayMemoRepository()), userId: 'actual_user_id'
  // ));

  PayMemoListView({Key? key}) : controller = Get.put(PayMemoController(
      payMemoUseCase: PayMemoUseCase(PayMemoRepository()))), super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.zero, // 추가된 패딩 제거
      child: Column(
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
                      '금액 계산',
                      style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: mainOrange),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Obx(() =>
                          Icon(
                              controller.isExpanded.value ? Icons
                                  .keyboard_arrow_up : Icons
                                  .keyboard_arrow_down,
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
          Obx(() =>
          controller.isExpanded.value ? Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: controller.paymemos.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SwipeActionCell(
                    key: ObjectKey(controller.paymemos[index]),
                    backgroundColor: Colors.white,
                    trailingActions: <SwipeAction>[
                    SwipeAction(
                    title: "삭제",
                    onTap: (CompletionHandler handler) async {
                    await handler(true);
                    controller.paymemos.removeAt(index);
                    // setState(() {});
                      },
                      color:  mainBrown,
                      ),
                    ],
                    child: PayMemoItem(
                      paymemo: controller.paymemos[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PayMemoScreen(paymemo: controller.paymemos[index]),
                          ),
                        );
                      },
                      onDelete: () {
                        controller.deletePayMemo(index);
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