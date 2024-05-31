import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedule_with/assets/colors/color.dart';

class PayMemo {
  String date;
  String title;
  String amounttitle;
  String amount;
  bool isCompleted;

  PayMemo({required this.date, required this.title, required this.amounttitle, required this.amount, this.isCompleted = false});
}

class MemoItem extends StatelessWidget {
  final PayMemo paymemo;

  const MemoItem({Key? key, required this.paymemo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor = paymemo.isCompleted ? mainOrange : mainBrown;
    List<String> amounts = paymemo.amount.split(' | ');
    String totalAmount = amounts[0];
    String personalAmount = amounts[1];

    return Container(
      padding: EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 날짜 타이틀
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(paymemo.date, style: TextStyle(fontSize: 10, color: grey4)),
                    Text(paymemo.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              // Status indicator vertically centered
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                width: 60,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor, width: 1),
                ),
                child: Center(
                  child: Text(
                    paymemo.isCompleted ? '정산완료' : '정산중',
                    style: TextStyle(color: statusColor, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  paymemo.amounttitle,
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Spacer(),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$totalAmount",
                          style: TextStyle(color: grey4, fontSize: 10),
                        ),
                        TextSpan(
                          text: " | $personalAmount",
                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
      ]
      ),
    );
  }
}

class PayMemoListView extends StatefulWidget {
  final List<PayMemo> memos = [
    PayMemo(date: '24.05.16', title: '24.05.16 인천 정모~!', amounttitle: '금액', amount: '334,000원 | 68,000원', isCompleted: true),
    PayMemo(date: '24.05.16', title: '24.05.16 인천 정모~!', amounttitle: '금액', amount: '234,000원 | 78,000원', isCompleted: false),
  ];

  @override
  _PayMemoListViewState createState() => _PayMemoListViewState();
}

class _PayMemoListViewState extends State<PayMemoListView> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 40,
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(child: SizedBox()),
                    Expanded( // Centered title
                      child: Center(child: Text('금액 계산', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainOrange))),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: mainOrange),
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  child: ListView(
                    children: isExpanded ? widget.memos.map((memo) => MemoItem(paymemo: memo)).toList() : [],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height * 0.045,
            child: Container(
                height: 1.5,
                color: mainOrange
            ),
          ),
        ],
      ),
    );
  }
}
