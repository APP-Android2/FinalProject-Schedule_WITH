import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../domain/repository/memo/paymemo_repository.dart';
import '../../../domain/use_case/paymemo_use__case.dart';
import '../widget/memo_floatingactionbutton_expandable.dart';
import '../widget/paymemo_controller.dart';
import 'paymemolist.dart';
import 'memolist.dart';

class MemoMainScreen extends StatefulWidget {
  const MemoMainScreen({super.key});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MemoMainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFABOpen = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 2);

    final payMemoUseCase = PayMemoUseCase(PayMemoRepository());
    final PayMemoController payMemoController = Get.put(PayMemoController(payMemoUseCase: payMemoUseCase));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Obx(() =>
              Flexible(
                flex: Get.find<PayMemoController>().isExpanded.value ? 4 : 0,
                child: PayMemoListView(),
              )),
          Obx(() =>
              Flexible(
                flex: Get.find<PayMemoController>().isExpanded.value ? 6 : 9,
                child: Container(
                  margin: EdgeInsets.only(
                      top: Get.find<PayMemoController>().isExpanded.value ? 0 : 0),
                  child: MemoListView(),
                ),
              )),
          Spacer(),
        ],
      ),
      floatingActionButton: ExpandableFAB(
        isFABOpen: isFABOpen,
        toggleFAB: () =>
            setState(() {
              isFABOpen = !isFABOpen;
            }),
      ),
    );
  }
}