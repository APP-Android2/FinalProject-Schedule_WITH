import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';

class FriendSearchBar extends StatefulWidget {
  const FriendSearchBar({super.key});


  @override
  State<FriendSearchBar> createState() => _FriendSearchBarState();
}

class _FriendSearchBarState extends State<FriendSearchBar> {
  String? inputText;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      leading: Icon(CupertinoIcons.search),
      // 검색창 내부 여백
      padding: MaterialStateProperty.all(EdgeInsets.only(left: 16)),
      backgroundColor: MaterialStatePropertyAll(Colors.white),
      // overlayColor: MaterialStatePropertyAll(grey2),
      elevation: MaterialStatePropertyAll(0),
      shadowColor: WidgetStatePropertyAll(grey1),
      constraints:
      BoxConstraints(minWidth: 330, maxWidth: 330, minHeight: 46),
      side: MaterialStateProperty.all(
          BorderSide(color: grey2, width: 1)),
      shape: MaterialStateProperty.all(ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(15))),
      textStyle: MaterialStateProperty.all(
          TextStyle(color: Colors.black, fontSize: 18)),
      hintText: "검색",
      hintStyle: MaterialStateProperty.all(
          TextStyle(color: Colors.grey, fontSize: 18)),
      // hintStyle: MaterialStateProperty.all(TextStyle(color: Colors.grey.shade400)),
      // 검색 완료시 작동
      onSubmitted: (value) {
        setState(() => inputText = value);
        Text('Input Text = $inputText');
      },
      // 검색어 입력하는 동안 반응
      onChanged: (value) {
        setState(() => inputText = value);
        Text('Input Text = $inputText');
      },
    );
  }
}

