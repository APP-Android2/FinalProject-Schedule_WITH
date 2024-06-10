import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/schedule/widget/schedule_edit_bottom_sheet.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class MainCalendarMonth extends StatefulWidget {

  const MainCalendarMonth({super.key});

  @override
  State<MainCalendarMonth> createState() => _MainCalendarMonthState();
}

// 월간, 주간 캘린더
class _MainCalendarMonthState extends State<MainCalendarMonth> {
  // 현재 달력 범위를 벗어나는 날짜 클릭시 테두리 색을 다르게 설정하기 위한 변수
  bool isCurrentMonth = true;
  var currentView = CalendarView.month;

  // 월별 -> 일별 전환시 현재 시간으로 이동
  final DateTime _jumpToTime = DateTime.now();

  // 캘린더 컨트롤러
  final CalendarController _calendarController = CalendarController();

  // 선택된 셀의 날짜 확인
  void _onCalendarTap(CalendarTapDetails details) {
    var todayAppoint = details.appointments?.isNotEmpty ?? false;

    if (todayAppoint == true) {
      showModalBottomSheet(
        // 바텀 시트 높이 지정하려면 isScrollControlled: true,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context){
            return EditScheduleBottomSheet();
          });
    } else {
      // 약속이 없을 때의 동작 추가 (필요한 경우)
    }

    // 선택한 요소의 인덱스 (0 = 헤더 , 1 = 요일 , 2 = 셀)
    var onTapElement = details.targetElement.index;
    // 선택된 날짜
    var userSelectMonth = _calendarController.selectedDate?.month;
    // 달력상 날짜
    var calendarMonth = _calendarController.displayDate?.month;
    if (onTapElement == 2) {
      // UI 변경
      setState(() {
        if (userSelectMonth == calendarMonth) {
          isCurrentMonth = true;
        } else {
          isCurrentMonth = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   width: double.infinity,
        //   height: 40,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        // 커스텀 date picker
        //       YearDatePickerButton(),
        //       // CalendarChangeViewButton(),
        //     ],
        //   ),
        // ),
        SizedBox(
          // 캘린더가 차지할 높이
          height: MediaQuery.of(context).size.height * 0.65,
          child: SfCalendar(
          // 최초 표시형식 (월)
            view: currentView,
            initialDisplayDate: _jumpToTime,
            controller: _calendarController,
            onTap: _onCalendarTap,

            // 임시 데이터 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 나중에 삭제 해야됨
            // 변경 가능한 표시형식 (월, 주)
            allowedViews: const [
              CalendarView.month,
              CalendarView.week,
              CalendarView.schedule
            ],
            // 배경색
            backgroundColor: Colors.white,
            // 오늘 날짜 강조색
            todayHighlightColor: mainOrange,
            todayTextStyle: TextStyle(color: Colors.white),
            // 연월 고르는 버튼 활성화
            showDatePickerButton: true,
            // 오늘 날짜로 돌아가는 버튼
            showTodayButton: true,
            cellBorderColor: grey3,
            // 달력 헤더 스타일 설정
            headerDateFormat: 'yyyy년 MM월',
            headerHeight: 50,
            headerStyle: const CalendarHeaderStyle(
              backgroundColor: Colors.white,
              textStyle: TextStyle(
                fontSize: 14,
                // fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // 특정 날짜 선택시 셀 스타일 설정
            selectionDecoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: isCurrentMonth ? mainOrange : Colors.transparent,
                width: 2,
              ),
            ),
            // 달력 표시
            cellEndPadding: 0,
            monthViewSettings: MonthViewSettings(
              numberOfWeeksInView: 6, // 나타낼 주 수
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment, // 약속 제목 표시
              appointmentDisplayCount: 3, // 셀 하나에 약속 표시 갯수
            ),
            appointmentBuilder: buildAppointmentWidget,
            // week 설정
            timeSlotViewSettings: TimeSlotViewSettings(
              timeRulerSize: 50,
              timeTextStyle: TextStyle(color: grey4, fontWeight: FontWeight.bold),
              timeIntervalHeight: 100,
              timeIntervalWidth: 200,
              timelineAppointmentHeight: 30,
              timeInterval: Duration(hours: 1),
              timeFormat: 'a h:mm',
            ),
          ),
        ),
      ],
    );
  }
}


// 더보기 아이콘
Widget buildAppointmentWidget(BuildContext context, CalendarAppointmentDetails details) {
  if (details.isMoreAppointmentRegion) {
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      child: Center(
        child: Icon(
          Icons.more_horiz, // 원하는 아이콘으로 변경
          size: 16, // 아이콘 크기 조정
          color: Colors.red, // 아이콘 색상 조정
        ),
      ),
    );
  } else {
    final Appointment appointment = details.appointments.first;
    return Container(
      decoration: BoxDecoration(
        color: appointment.color,
        // borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          appointment.subject,
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }
}

