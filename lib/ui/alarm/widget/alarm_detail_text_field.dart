import 'package:flutter/material.dart';

import '../../../assets/colors/color.dart';

class AlarmDetailTextField extends StatefulWidget {
  final String titleText;
  final String textHint;

  const AlarmDetailTextField({
    required this.titleText,
    required this.textHint,
    Key? key,
    }): super(key: key);

  @override
  State<AlarmDetailTextField> createState() => _AlarmDetailTextButtonState();
}

class _AlarmDetailTextButtonState extends State<AlarmDetailTextField> {
  final TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: grey2, width: 1)
            ),
          ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( '${widget.titleText}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: 300,
                    child: TextField(
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        // 작성하는 글자 밑줄 제거
                        decorationThickness: 0
                      ),
                      decoration: InputDecoration(
                        // maxLength 표시 지우기
                        counterText: '',
                        border: InputBorder.none,
                        hintText: widget.textHint,
                        hintStyle: TextStyle(
                          color: grey3
                        ),
                        // border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.text,
                      maxLength: 20,
                      controller: title,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
