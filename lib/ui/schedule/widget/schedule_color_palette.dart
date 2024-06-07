import 'package:flutter/material.dart';
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
                ScheduleColorPaletteDetail(colorName: Color(0xFFFF9E9E)),
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: Color(0xFFFFD39E)),
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: Color(0xFFFFFB94)),
                SizedBox(width: 12, height: 12)
              ]
          ),
          SizedBox(width: 12, height: 12),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: Color(0xFFA5FB97)),
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: Color(0xFF9EDCFF)),
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: Color(0xFF84A6FF)),
                SizedBox(width: 12, height: 12)
              ]
          )
          , SizedBox(width: 12, height: 12),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: Color(0xFFC99EFF)),
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: Color(0xFFFFB6DD)),
                SizedBox(width: 12, height: 12),
                ScheduleColorPaletteDetail(colorName: Color(0xFFC2C2C2)),
                SizedBox(width: 12, height: 12)
              ]
          )
        ],
      ),
    );
  }
}