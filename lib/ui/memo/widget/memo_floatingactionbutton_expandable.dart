import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/memo/view/memo.dart';
import 'package:schedule_with/ui/memo/view/paymemo.dart';

class ExpandableFAB extends StatelessWidget {
  final bool isFABOpen;
  final VoidCallback toggleFAB;

  const ExpandableFAB({
    Key? key,
    required this.isFABOpen,
    required this.toggleFAB,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}