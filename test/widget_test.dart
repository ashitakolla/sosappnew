// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sosappnew/main.dart';


void main() {
  testWidgets('Basic widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the initial route is the welcome page.
    expect(find.text('Welcome'), findsOneWidget); // Change 'Welcome' to a text widget you expect to find

    // Verify that other pages are not displayed initially.
    expect(find.text('Feature Buttons'), findsNothing); // Change 'Feature Buttons' to a text widget for another page
  });
}