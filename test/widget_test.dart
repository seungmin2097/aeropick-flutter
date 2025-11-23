// This is a basic Flutter widget test for the Airline App.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:airline_app/main.dart';

void main() {
  testWidgets('Airline app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AirlineApp());

    // Verify that our app starts with the home screen.
    expect(find.text('항공 예약'), findsOneWidget);
    expect(find.text('어디로 떠나시나요?'), findsOneWidget);
    expect(find.text('항공편 검색'), findsOneWidget);

    // Verify that the bottom navigation bar is present.
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('홈'), findsOneWidget);
    expect(find.text('검색'), findsOneWidget);
    expect(find.text('예약'), findsOneWidget);
    expect(find.text('프로필'), findsOneWidget);
  });
}
