// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:plantpal/main.dart';

void main() {
  testWidgets('PlantPal app smoke test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const PlantPalApp());

    // Verify PlantPal title exists
    expect(find.text('PlantPal'), findsOneWidget);

    // Verify splash screen icon is displayed
    expect(find.byIcon(Icons.local_florist), findsOneWidget);

    // Verify tagline exists
    expect(find.text('Your Plant Care Companion'), findsOneWidget);
  });

  testWidgets('App uses Material3 theme', (WidgetTester tester) async {
    await tester.pumpWidget(const PlantPalApp());

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(materialApp.theme?.useMaterial3, true);
    expect(materialApp.title, 'PlantPal');
  });
}
