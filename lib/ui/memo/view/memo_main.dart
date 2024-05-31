import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/memo/view/paymemo.dart';
import '../../../widget/main_tab_bar.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: MemoListView(),
          ),
          Expanded(
            child: PayMemoListView(),
          ),
        ],
      ),
      floatingActionButton: buildExpandableFAB(),
    );
  }

  Widget buildExpandableFAB() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isFABOpen) ...[
          SizedBox(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PayMemoScreen()),
                );
              },
              backgroundColor: mainBrown,
              child: Padding(
                padding: const EdgeInsets.only(left: 0, bottom: 0),
                child: SvgPicture.asset("lib/assets/icon/icon_paymemo_add.svg",
                    color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoScreen()),
                );
              },
              backgroundColor: mainBrown,
              child: Padding(
                // 아이콘의 위치 조정
                padding: const EdgeInsets.only(left: 2, bottom: 1.5),
                child: SvgPicture.asset(
                    "lib/assets/icon/icon_memo_add.svg", color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: 10),
        ],
        SizedBox(
          child: FloatingActionButton(
            onPressed: toggleFAB,
            backgroundColor: mainOrange,
            child: Icon(
                isFABOpen ? Icons.close : Icons.add, color: Colors.white),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ],
    );
  }

  void toggleFAB() {
    setState(() {
      isFABOpen = !isFABOpen;
    });
  }

}