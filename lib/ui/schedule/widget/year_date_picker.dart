import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/view/schedule_main.dart';
import 'package:schedule_with/ui/schedule/widget/test.dart';
import 'package:schedule_with/widget/date_picker.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


class YearDatePickerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.dialog(
            // YearDatePickerDialog()
          Test()
        );
            },
      child: Text('연도 선택하기'),
    );
  }
}

class YearDatePickerDialog extends SfDateRangePicker {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: SfDateRangePicker(
          view: DateRangePickerView.year,
          backgroundColor: Colors.white,
          // onCancel:
          // onSubmit:
          // onViewChanged:
          // onSelectionChanged:
          //   headerStyle = const DateRangePickerHeaderStyle(),
          allowViewNavigation: true,
          cancelText: '취소',
          todayHighlightColor: mainOrange,
          confirmText: '확인',
          toggleDaySelection: true,
          selectionColor: mainOrange,
          showNavigationArrow: true,
          showActionButtons: true,
          enablePastDates: true,
          ),

        ),
    );
  }
}
