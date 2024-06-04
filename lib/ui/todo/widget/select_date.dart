import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectDate extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const SelectDate({
    required this.onDateSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  late DateTime selectDate;

  @override
  void initState() {
    super.initState();
    selectDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    widget.onDateSelected(selectDate);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(CupertinoIcons.back),
                  color: Colors.grey,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 45,
                  child: Text(
                    '날짜',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                  color: Colors.grey,
                ),
              ],
            ),
            Divider(color: Colors.grey),
            Container(
              height: 200,
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(fontSize: 20),
                  ),
                ),
                child: CupertinoDatePicker(
                  initialDateTime: selectDate,
                  maximumYear: 2300,
                  minimumYear: 2000,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (dateTime) {
                    setState(() {
                      selectDate = dateTime;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
