import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedule_with/assets/color/color.dart';
import '../../../widget/main_button.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: false,
              context: context,
              builder: (BuildContext context) {
                return Wrap(
                  children: [
                    BottomSheetWidget(),
                  ],
                );
              },
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              barrierColor: Colors.grey.withOpacity(0.5),
            );
          },
          child: Text('돼돼도대대돼라고!!!!!'),
        ),
      ),
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController usageFieldUnderlineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          height: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text('사용 내역', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(width: 48),
                ],
              ),
              UsageFieldUnderline(usageFieldUnderlineController: usageFieldUnderlineController),
              CostFieldUnderline(costController: costController),
              Spacer(flex: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: MainButton(
                  text: '확인',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: mainOrange,
                ),
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class CostFieldUnderline extends StatelessWidget {
  final TextEditingController costController;

  const CostFieldUnderline({Key? key, required this.costController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: grey2))),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text('금액', style: TextStyle(fontSize: 14)),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: costController,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: '금액을 입력해 주세요.',
                  hintStyle: TextStyle(fontSize: 14, color: grey3),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UsageFieldUnderline extends StatefulWidget {
  final TextEditingController usageFieldUnderlineController;

  const UsageFieldUnderline({Key? key, required this.usageFieldUnderlineController}) : super(key: key);

  @override
  UsageFieldUnderlineState createState() => UsageFieldUnderlineState();
}

class UsageFieldUnderlineState extends State<UsageFieldUnderline> {
  String dropdownValue = '지출내역';
  final Map<String, Color> colorMap = {
    '지출내역': mainBrown,
    '수입내역': mainOrange,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: grey2)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: PopupMenuButton<String>(
                onSelected: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    widget.usageFieldUnderlineController.text = "";
                  });
                  FocusScope.of(context).unfocus(); // 포커스 해제
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        dropdownValue,
                        style: TextStyle(color: colorMap[dropdownValue], fontSize: 14),
                      ),
                      SizedBox(width: 8), // Reduce space between text and icon
                      Icon(Icons.arrow_drop_down, color: colorMap[dropdownValue]),
                    ],
                  ),
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: '지출내역',
                    child: Text('지출내역', style: TextStyle(color: colorMap['지출내역'])),
                  ),
                  PopupMenuItem<String>(
                    value: '수입내역',
                    child: Text('수입내역', style: TextStyle(color: colorMap['수입내역'])),
                  ),
                ],
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: widget.usageFieldUnderlineController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: '내역을 입력해 주세요.',
                  hintStyle: TextStyle(fontSize: 14, color: grey3),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
