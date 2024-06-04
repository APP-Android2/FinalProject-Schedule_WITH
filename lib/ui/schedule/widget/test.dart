import 'package:flutter/material.dart';


class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom DatePicker'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _showCustomDatePicker(context);
            },
            child: Text('Open DatePicker'),
          ),
        ),
      ),
    );
  }

  void _showCustomDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith( // 배경색 변경
            colorScheme: ColorScheme.light(background: Colors.blue, primary: Colors.blue, onPrimary: Colors.blue, secondary: Colors.blue, onSecondary: Colors.blue, error: Colors.red),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      print('Selected date: $pickedDate');
    }
  }
}