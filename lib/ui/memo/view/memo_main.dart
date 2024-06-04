import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/memo/view/paymemo.dart';
import '../widget/memo_controller.dart';
import 'memo.dart';
import 'paymemolist.dart';
import 'memolist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MemoMainScreen(),
    );
  }
}

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
  }

  @override
  Widget build(BuildContext context) {
    final PayMemoController payMemoController = Get.put(PayMemoController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Obx(() => Flexible(
            flex: payMemoController.isExpanded.value ? 4 : 0,
            child: PayMemoListView(),
          )),
          Obx(() => Flexible(
            flex: payMemoController.isExpanded.value ? 6 : 9,
            child: Container(
              margin: EdgeInsets.only(top: payMemoController.isExpanded.value ? 0 : 0),
              child: MemoListView(),
            ),
          )),
          Spacer(),
        ],
      ),
      floatingActionButton: buildExpandableFAB(),
    );
  }

  Widget buildExpandableFAB() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isFABOpen) ...[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PayMemoScreen()),
                );
              },
              backgroundColor: mainBrown,
              child: Padding(
                padding: const EdgeInsets.only(left: 2, bottom: 1.5),
                child: SvgPicture.asset(
                    "lib/assets/icon/icon_paymemo_add.svg",
                    color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoScreen()),
                );
              },
              backgroundColor: mainBrown,
              child: Padding(
                padding: const EdgeInsets.only(left: 0, bottom: 0),
                child: SvgPicture.asset("lib/assets/icon/icon_memo_add.svg",
                    color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            SizedBox(
              width: 10,
            ),
          ],
          FloatingActionButton(
            onPressed: toggleFAB,
            backgroundColor: mainOrange,
            child: Icon(
                isFABOpen ? Icons.close : Icons.add, color: Colors.white),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ],
      ),
    );
  }

  void toggleFAB() {
    setState(() {
      isFABOpen = !isFABOpen;
    });
  }
}
