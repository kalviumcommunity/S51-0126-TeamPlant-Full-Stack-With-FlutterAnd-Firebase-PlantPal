import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plantpal/screens/splash_screen.dart';

void main() {
  group('SplashScreen Widget Tests', () {
    testWidgets('displays app name PlantPal', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SplashScreen()),
      );

      expect(find.text('PlantPal'), findsOneWidget);
    });

    testWidgets('displays tagline', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SplashScreen()),
      );

      expect(find.text('Your Plant Care Companion'), findsOneWidget);
    });

    testWidgets('displays plant icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SplashScreen()),
      );

      expect(find.byIcon(Icons.local_florist), findsOneWidget);
    });

    testWidgets('icon has correct size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SplashScreen()),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.local_florist));
      expect(icon.size, 100);
    });

    testWidgets('app name has correct font size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SplashScreen()),
      );

      final text = tester.widget<Text>(find.text('PlantPal'));
      expect(text.style?.fontSize, 36);
      expect(text.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('has white background', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SplashScreen()),
      );

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, Colors.white);
    });

    testWidgets('content is centered', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SplashScreen()),
      );

      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('has correct widget hierarchy', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SplashScreen()),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('does not have an AppBar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SplashScreen()),
      );

      expect(find.byType(AppBar), findsNothing);
    });
  });
}
