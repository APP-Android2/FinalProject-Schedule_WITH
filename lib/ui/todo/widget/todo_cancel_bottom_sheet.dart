import 'package:flutter/material.dart';

import '../../../assets/colors/color.dart';

class TodoCancelBottomSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onContinue;

  const TodoCancelBottomSheet({
    super.key,
    required this.onConfirm,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: '수정사항을 ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              children: [
                TextSpan(
                  text: '취소',
                  style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' 하시겠습니까?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the confirmation bottom sheet
              WidgetsBinding.instance.addPostFrameCallback((_) {
                onConfirm();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: mainBrown, // 배경색 갈색
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 모서리 둥글게
              ),
              padding: const EdgeInsets.symmetric(vertical: 16), // 버튼 높이 조절
            ),
            child: const Center(
              child: Text(
                '예',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
              ),

            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the confirmation bottom sheet
              onContinue();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: mainOrange, // 배경색 주황색
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 모서리 둥글게
              ),
              padding: const EdgeInsets.symmetric(vertical: 16), // 버튼 높이 조절
            ),
            child: const Center(
              child: Text(
                '계속 작성',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
