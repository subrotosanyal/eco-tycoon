// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/main.dart';

void main() {
  testWidgets('App launches and shows start screen', (WidgetTester tester) async {
    // Set up a larger surface for testing
    tester.binding.window.physicalSizeTestValue = const Size(1280, 900);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: EcoTycoonApp()));
    await tester.pumpAndSettle(); // Wait for animations to complete

    // Verify that the start screen elements are displayed
    expect(find.text('Eco Tycoon'), findsOneWidget);
    expect(find.text('Save the Planet!'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
