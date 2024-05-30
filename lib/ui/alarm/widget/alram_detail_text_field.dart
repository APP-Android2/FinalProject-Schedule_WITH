import 'package:flutter/material.dart';

import '../../../assets/colors/color.dart';

class AlramDetailTextField extends StatefulWidget {
  final String titleText;
  final String textHint;

  const AlramDetailTextField({
    required this.titleText,
    required this.textHint,
    Key? key,
    }): super(key: key);

  @override
  State<AlramDetailTextField> createState() => _AlramDetailTextButtonState();
}

class _AlramDetailTextButtonState extends State<AlramDetailTextField> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
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
                // TextField(
                //   controller: _textController,
                //   onSubmitted: sendMsg,
                //   decoration: InputDecoration(
                //     hintText: "알람",
                //     border: null,
                //   ),
                // )
              ],
            ),
          ),
        ),
    );
  }
}
