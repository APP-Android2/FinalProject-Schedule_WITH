import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/main.dart';
void main() {
  testWidgets('TodoMainScreen has tabs and changes color on selection', (WidgetTester tester) async {
    // 앱을 빌드하고 트리거합니다.
    await tester.pumpWidget(const MyApp());

    // TODO 탭이 초기 선택된 상태인지 확인합니다.
    expect(find.text('TODO'), findsOneWidget);

    // 캘린더 탭을 찾고 탭합니다.
    await tester.tap(find.text('캘린더'));
    await tester.pump();

    // 캘린더 탭이 선택된 상태인지 확인합니다.
    final calendarTab = tester.widget<Container>(find.byWidgetPredicate(
          (Widget widget) =>
      widget is Container &&
          widget.decoration != null &&
          (widget.decoration as BoxDecoration).color == mainOrange,
    ));
    expect(calendarTab, isNotNull);

    // 메모 탭을 찾고 탭합니다.
    await tester.tap(find.text('메모'));
    await tester.pump();

    // 메모 탭이 선택된 상태인지 확인합니다.
    final memoTab = tester.widget<Container>(find.byWidgetPredicate(
          (Widget widget) =>
      widget is Container &&
          widget.decoration != null &&
          (widget.decoration as BoxDecoration).color == mainOrange,
    ));
    expect(memoTab, isNotNull);
  });
}
