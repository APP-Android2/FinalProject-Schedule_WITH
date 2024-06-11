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
import '../../../domain/repository/memo_repository.dart';
import '../../../domain/repository/schedule_repository.dart';
import '../../../domain/repository/todo_repository.dart';
import '../../../domain/use_case/memo_use_case.dart';
import '../../../domain/use_case/schedule_use_case.dart';
import '../../../domain/use_case/todo_use_case.dart';
import '../../../entity/schedule_tbl.dart';
import '../controller/home_memo_controller.dart';
import '../controller/home_schedule_controller.dart';
import '../controller/home_todo_controller.dart';

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

  @override
  void initState() {
    super.initState();
    final scheduleRepository = ScheduleRepository();
    final scheduleUseCase = ScheduleUseCase(scheduleRepository);
    Get.put(HomeScheduleController(scheduleUseCase: scheduleUseCase));

    final memoRepository = MemoRepository();
    final memoUseCase = MemoUseCase(memoRepository);
    Get.put(HomeMemoController(memoUseCase: memoUseCase));

    final todoRepository = TodoRepository();
    final todoUseCase = TodoUseCase(todoRepository);
    Get.put(HomeTodoController(todoUseCase: todoUseCase));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale("ko", "KO")
      ],
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: MainAppBar(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 그룹
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
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: IconAndText(
                        iconRoute: 'lib/assets/icon/icon_group_outline.svg',
                        text: "그룹",
                        height: 14,
                      ),
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    ),
                    Container(
                      height: 100,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
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
                      offset: Offset(0, 5),
                    )
                  ],
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
                      child: Obx(() {
                        final memoController = Get.find<HomeMemoController>();
                        if (memoController.memos.isEmpty) {
                          return Text(
                            "등록된 메모가 없습니다.",
                            style: TextStyle(color: grey3),
                          );
                        }
                        final memo = memoController.memos.first;
                        return Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                  memo.content,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            if (memo.title.isNotEmpty) // 이미지가 있다면 이미지 표시
                              Expanded(
                                flex: 1,
                                child: Image.network(memo.title), // title 필드를 이미지 URL로 사용
                              ),
                          ],
                        );
                      }),
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
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndText(
                            iconRoute: 'lib/assets/icon/icon_todo.svg',
                            text: "TODO 리스트",
                            height: 18,
                          ),
                          SvgPicture.asset(
                            "lib/assets/icon/icon_plus2.svg",
                            width: 17,
                            height: 17,
                          ),
                        ],
                      ),
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                      child: Obx(() {
                        final todoController = Get.find<HomeTodoController>();
                        if (todoController.todos.isEmpty) {
                          return Text(
                            "등록된 TODO 리스트가 없습니다.",
                            style: TextStyle(color: grey3),
                          );
                        }
                        return Column(
                          children: todoController.todos.map((todo) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 0, right: 16.0), // 패딩을 통해 제목을 왼쪽으로 이동
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: todo.todoStatus == 'Y',
                                    onChanged: (bool? value) {
                                      if (value != null) {
                                        todoController.toggleTodoStatus(todo.idx, value);
                                      }
                                    },
                                    activeColor: Color(0xFF627BFF), // 체크박스 테두리 색상 설정
                                    checkColor: Colors.white, // 체크표시 색상 설정
                                    side: BorderSide(color: Color(0xFF627BFF)), // 체크박스 테두리 색상 설정
                                  ),
                                  Expanded(
                                    child: Text(todo.title),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ),
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
                      offset: Offset(0, 5),
                    )
                  ],
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
                            child: Obx(() {
                              final scheduleController = Get.find<HomeScheduleController>();
                              if (scheduleController.schedules.isEmpty) {
                                return SfCalendar(
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
                                    timeRulerSize: 70,
                                  ),
                                );
                              }
                              return SfCalendar(
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
                                  timeRulerSize: 70,
                                ),
                                dataSource: ScheduleDataSource(scheduleController.schedules),
                                appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details) {
                                  final Schedule schedule = details.appointments.first;
                                  return Container(
                                    margin: EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
                                    decoration: BoxDecoration(
                                      color: Color(int.parse('0xff${schedule.color ?? 'ffffff'}')),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        schedule.title ?? '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
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
                      offset: Offset(0, 5),
                    )
                  ],
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
                        activeDotColor: mainOrange,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 7)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget GroupListItem() {
  return InkWell(
    onTap: () {
      Get.toNamed('/groupInvite');
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: grey1,
              border: Border.all(color: grey2, width: 0.5),
            ),
            margin: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(
              "lib/assets/icon/icon_plus.svg",
              width: 15,
              height: 15,
              fit: BoxFit.scaleDown,
            ),
          ),
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

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<Schedule> schedules) {
    appointments = schedules.map((schedule) {
      return Appointment(
        startTime: schedule.startDt!,
        endTime: schedule.endDt!,
        subject: schedule.title ?? '',
        color: Color(int.parse('0xff${schedule.color ?? 'ffffff'}')),
      );
    }).toList();
  }
}
