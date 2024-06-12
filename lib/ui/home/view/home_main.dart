import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/home/widget/icon_and_text.dart';
import 'package:schedule_with/widget/main_app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../todo/controller/todo_controller.dart';
import '../../todo/widget/calendar_cell_custom.dart';
import '../../todo/widget/todo_add_bottom_sheet.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {

  var adImages = [
    Image.asset("lib/assets/image/logo.png"),
    Image.asset("lib/assets/image/logo.png"),
    Image.asset("lib/assets/image/logo.png"),
    Image.asset("lib/assets/image/logo.png"),
    Image.asset("lib/assets/image/logo.png")
  ];

  var imagePosition = 0;

  final TodoController todoController = Get.put(TodoController());
  final CustomCalendarController calendarController = Get.put(CustomCalendarController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale("ko","KR")
      ],
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // 화면 배경색 설정
        backgroundColor: Colors.white,
        // 상단 툴바
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: MainAppBar(),
        ),
        // 홈화면에 보여줄 부분
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 그룹
              Container(
                // 그룹View의 여백 설정
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                // 그룹View의 그림자 및 radius 설정
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 0,
                        blurRadius: 8.0,
                        offset: Offset(0, 5), // changes position of shadow
                      )
                    ]
                ),
                // 그룹 내용
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 아이콘 및 "그룹" 텍스트 출력
                    Container(
                      child: IconAndText(
                        iconRoute: 'lib/assets/icon/icon_group_outline.svg',
                        text: "그룹",
                        height: 14,
                      ),
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    ),
                    // 그룹 초대 및 그룹들 리스트
                    Container(
                      height: 100, // 원하는 높이 설정
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                      child: ListView.builder(
                        // 가로 스크롤
                        scrollDirection: Axis.horizontal,
                        // 보여질 항목의 개수
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return GroupListItem();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // 메모
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 0,
                        blurRadius: 8.0,
                        offset: Offset(0, 5), // changes position of shadow
                      )
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: IconAndText(
                        iconRoute: 'lib/assets/icon/icon_write1.svg',
                        text: "메모",
                        height: 16,
                      ),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.메모내용입니다.",
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                              flex: 1,
                              child: Image.asset("lib/assets/image/logo.png"),
                            )
                          ],
                        )
                    ),
                  ],
                ),
              ),
              // TODO리스트
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 0,
                        blurRadius: 8.0,
                        offset: Offset(0, 5), // changes position of shadow
                      )
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconAndText(
                                iconRoute: 'lib/assets/icon/icon_todo.svg',
                                text: "TODO 리스트",
                                height: 18,
                              ),
                              Padding(padding: EdgeInsets.only(right: 5)),
                              Obx(() {
                                var todosForDate = todoController.getTodosForDate(calendarController.selectedDate.value);
                                double completionPercentage = todosForDate.isEmpty
                                    ? 0.0
                                    : todosForDate.where((todo) => todo.check.value).length / todosForDate.length * 100;
                                return Text("${completionPercentage.toStringAsFixed(0)}%", style: TextStyle(color: mainOrange));
                              }),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return TodoAddBottomSheet();
                                },
                              );
                            },
                            child: SvgPicture.asset(
                              "lib/assets/icon/icon_plus2.svg",
                              width: 17,
                              height: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      var todosForDate = todoController.getTodosForDate(calendarController.selectedDate.value);
                      return todosForDate.isNotEmpty
                          ? Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: todosForDate.length,
                          itemBuilder: (_, index) {
                            var todo = todosForDate[index];
                            return ListTile(
                              leading: Obx(() {
                                return Checkbox(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity,
                                  ),
                                  checkColor: Colors.white,
                                  activeColor: Colors.white,
                                  fillColor: todo.check.value
                                      ? MaterialStatePropertyAll(mainOrange)
                                      : MaterialStatePropertyAll(Colors.white),
                                  side: MaterialStateBorderSide.resolveWith(
                                        (states) => BorderSide(width: 1.0, color: mainOrange),
                                  ),
                                  value: todo.check.value,
                                  onChanged: (value) {
                                    todoController.toggleTodoCheck(todo);
                                  },
                                );
                              }),
                              title: Text(todo.title),
                            );
                          },
                        ),
                      )
                          : Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                        child: Center(
                          child: Text(
                            "등록된 TODO 리스트가 없습니다.",
                            style: TextStyle(
                              color: grey3,
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
              // 오늘의 스케쥴
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 0,
                        blurRadius: 8.0,
                        offset: Offset(0, 5), // changes position of shadow
                      )
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Column(
                          children: [
                            IconAndText(
                              iconRoute: 'lib/assets/icon/icon_calender_outline.svg',
                              text: "오늘의 스케쥴",
                              height: 16,
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Container(
                              height: 500,
                              child: SfCalendar(
                                view: CalendarView.day,
                                headerHeight: 0,
                                viewHeaderHeight: 0,
                                backgroundColor: Colors.white,
                                showCurrentTimeIndicator: false,
                                viewNavigationMode: ViewNavigationMode.none,
                                timeSlotViewSettings: TimeSlotViewSettings(
                                    startHour: 5,
                                    endHour: 24,
                                    timeFormat: 'a HH:mm',
                                    timeRulerSize: 70
                                ),
                              ),
                            ),
                          ],
                        )

                    ),
                  ],
                ),
              ),
              // 광고
              Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 0,
                          blurRadius: 8.0,
                          offset: Offset(0, 5), // changes position of shadow
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      CarouselSlider(
                        items: adImages,
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 5),
                          onPageChanged: (index, reason) {
                            setState(() {
                              imagePosition = index;
                            });
                          },
                        ),
                      ),
                      AnimatedSmoothIndicator(
                        activeIndex: imagePosition,
                        count: adImages.length,
                        effect: JumpingDotEffect(
                            dotWidth: 5,
                            dotHeight: 5,
                            dotColor: grey3,
                            paintStyle: PaintingStyle.fill,
                            activeDotColor: mainOrange
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 7))
                    ],
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}

// 그룹 항목들의 리스트 아이템
Widget GroupListItem() {
  return InkWell(
    onTap: () {
      Get.toNamed('/groupInvite');
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5), // 아이템 간의 간격을 설정
      child: Column(
        children: [
          // 그룹 프사 설정
          Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: grey1,
                  border: Border.all(color: grey2,width: 0.5)
              ),
              margin: EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                "lib/assets/icon/icon_plus.svg",
                width: 15,
                height: 15,
                fit: BoxFit.scaleDown,
              )
          ),
          // "그룹추가" 텍스트 출력
          Text(
            "그룹 추가",
            style: TextStyle(
              color: grey4,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}
