
import 'package:flutter/material.dart';

class SelectDialog extends StatefulWidget {
  const SelectDialog({super.key});

  @override
  State<SelectDialog> createState() => _SelectDialogState();
}

class _SelectDialogState extends State<SelectDialog> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          color: Colors.white,
          child: Expanded(
            child:
            Column(
              children: [
                Text('공유 상태 변경'),
                // 전체 공개
                Container(
                  child: Text('전체 공개'),
                ),
                // 일부 공개
                Container(
                  child: Text('일부 공개'),
                ),
                // 비공개
                Container(
                  child: Text('비공개'),
                ),
                // 비공개
              ],
            ),
          )
      ),
    );
  }
}