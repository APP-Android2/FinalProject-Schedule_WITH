import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../assets/colors/color.dart';
import '../widget/my_page_inquiry_item.dart';

class MyPageInquiry extends StatefulWidget {

  // 공지사항에 작성할 리스트(작성을 원하면 여기서 작성하면 됨)
  final List<Inquiry> inquirys = [
    Inquiry(InquiryTitle: '1. 스케쥴 추가를 어떻게 하는지 잘 모르겠습니다', InquiryContent: '하단 메뉴의 스케쥴 메뉴를 클릭하여 오른쪽 하단의 +버튼을 누르면 새로운 스케쥴을 작성할 수 있습니다.'),
    Inquiry(InquiryTitle: '2. 본인의 프로필 수정은 어디서 할 수 있나요', InquiryContent: '마이페이지 및 본인 프로필 클릭시 설정 아이콘을 통해 프로필을 수정할 수 있습니다.'),
    Inquiry(InquiryTitle: '3. 캘린더를 달 단위가 아닌 주 단위로 볼 수 있나요', InquiryContent: '볼 수 있습니다. 캘린더 우측 상단에 ‘달’이라는 버튼을 클릭 시 ‘주’로 변경되며, 다시 클릭 시 ‘달’로 변경되어 달 단위 및 주 단위로 모두 볼 수 있습니다.'),
    Inquiry(InquiryTitle: '4. 친구 또는 그룹에서 TODO 수정하고 싶어요', InquiryContent: '하단 메뉴의 스케쥴 메뉴를 클릭하여 오른쪽 하단의 +버튼을 누르면 새로운 스케쥴을 작성할 수 있습니다.'),
    Inquiry(InquiryTitle: '5. 금액계산 메모에서 은행명을 수정하고 싶어요', InquiryContent: '금액계산 메모 수정 화면에서 작성한 은행명을 클릭시 수정이 가능합니다.'),
    Inquiry(InquiryTitle: '6. 친구가 나의 일정이 보이지 않아요', InquiryContent: '스케쥴 작성 시 공개 상태를 전체공개 또는 일부공개를 하였는지 확인하여 주시고, 수정 해주시면 됩니다.'),

  ];


  @override
  State<MyPageInquiry> createState() => _MyPageInquiryState();
}

class _MyPageInquiryState extends State<MyPageInquiry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
              backgroundColor: Colors.white,
              // 뒤로가기 버튼
              leading: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(CupertinoIcons.back,color: grey4),
                onPressed: () {
                  Get.back();
                },
              ),
              // 타이틀
              centerTitle: true,
              title: Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  "문의하기",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: widget.inquirys.map((inquiry) => InquiryListItem(inquiry: inquiry)).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(text: "해결이 되지 않았거나 추가로 문의하실 사항이 있으신가요?\n",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black)),
                    TextSpan(text: "이메일(",style: TextStyle(fontSize: 12,color: Colors.black)),
                    TextSpan(
                        text: "schedule_with@gmail.com",
                        style: TextStyle(fontSize: 12,color: mainOrange,fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("이메일 클릭 됨");
                          }
                    ),
                    TextSpan(text: ")로 문의하기",style: TextStyle(fontSize: 12,color: Colors.black)),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
