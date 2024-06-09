import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_color_palette_detail.dart';


// 컬러 피커 전체 색상
class ScheduleColorPalette extends StatelessWidget {
  const ScheduleColorPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(width: 12, height: 24),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: lightPink),
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: apricot),
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: lemon),
                SizedBox(width: 12, height: 12)
              ]
          ),
          SizedBox(width: 12, height: 12),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: neonGreen),
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: lightBlue),
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: navyBlue),
                SizedBox(width: 12, height: 12)
              ]
          )
          , SizedBox(width: 12, height: 12),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: lightPurple),
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: lightPink),
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: lightGrey),
                SizedBox(width: 12, height: 12)
              ]
          )
        ],
      ),
    );
  }
}