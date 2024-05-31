import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../assets/colors/color.dart';
import '../../../widget/bottom_sheet_detail_button.dart';
import '../../../widget/date_picker.dart';

// 스케쥴 추가 바텀 시트 위젯
class AddScheduleBottomSheet extends StatelessWidget {
  AddScheduleBottomSheet({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          BottomSheetTitle(),
          Divider(),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              children: [
                // 시작날짜 선택 버튼
                BottomSheetDetailTextButton(
                    titleText: '시작 날짜',
                    detailText: '선택',
                    detailTextColor: grey4,
                    onTap: () {
                      Get.back(); // Close first
                      Get.bottomSheet(DatePicker(
                        back_page: AddScheduleBottomSheet(),
                        title: '날짜',
                      ));
                    }),
                // 마침날짜 선택 버튼
                BottomSheetDetailTextButton(
                    titleText: '마침 날짜',
                    detailText: '선택',
                    detailTextColor: grey4,
                    onTap: () {
                      Get.back(); // Close first
                      Get.bottomSheet(DatePicker(
                        back_page: AddScheduleBottomSheet(),
                        title: '날짜',
                      ));
                    }),
                // 공개여부 선택
                BottomSheetDetailTextButton(
                  titleText: '공개 여부',
                  detailText: '선택',
                  detailTextColor: grey4,
                  onTap: () {
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// 바텀 시트 제목 설정
class BottomSheetTitle extends StatelessWidget {
  BottomSheetTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: const EdgeInsets.only(top: 10),
          onPressed: () {
            Get.back;
          },
          icon: Icon(Icons.close),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '스케쥴 추가',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 40),
      ],
    );
  }
}

