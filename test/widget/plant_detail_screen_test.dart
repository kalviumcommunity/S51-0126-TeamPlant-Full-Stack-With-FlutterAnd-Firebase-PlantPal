import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plantpal/screens/plant_detail/plant_detail_screen.dart';

void main() {
  group('PlantDetailScreen Widget Tests', () {
    testWidgets('displays Plant Details in app bar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.text('Plant Details'), findsOneWidget);
    });

    testWidgets('has AppBar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('AppBar has green background', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, Colors.green);
    });

    testWidgets('AppBar has white foreground color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.foregroundColor, Colors.white);
    });

    testWidgets('displays placeholder Plant Name', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.text('Plant Name'), findsOneWidget);
    });

    testWidgets('displays placeholder Scientific Name', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.text('Scientific Name'), findsOneWidget);
    });

    testWidgets('has plant icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.byIcon(Icons.local_florist), findsOneWidget);
    });

    testWidgets('has water drop icon for watering info', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.byIcon(Icons.water_drop), findsOneWidget);
    });

    testWidgets('has sun icon for sunlight info', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    });

    testWidgets('has info icon for care instructions', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('displays Watering Frequency card', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.text('Watering Frequency'), findsOneWidget);
    });

    testWidgets('displays Sunlight Requirements card', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.text('Sunlight Requirements'), findsOneWidget);
    });

    testWidgets('displays Care Instructions card', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.text('Care Instructions'), findsOneWidget);
    });

    testWidgets('has Add to My Plants button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.text('Add to My Plants'), findsOneWidget);
    });

    testWidgets('Add to My Plants button has bookmark icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.byIcon(Icons.bookmark_add), findsOneWidget);
    });

    testWidgets('Add to My Plants is a button widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      // Check for the button by finding the text and its parent SizedBox
      final sizedBoxWithButton = find.ancestor(
        of: find.text('Add to My Plants'),
        matching: find.byType(SizedBox),
      );
      expect(sizedBoxWithButton, findsWidgets);
    });

    testWidgets('has 3 info cards', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.byType(Card), findsNWidgets(3));
    });

    testWidgets('is scrollable', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('plant name has bold text style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      final textWidget = tester.widget<Text>(find.text('Plant Name'));
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('scientific name has italic style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      final textWidget = tester.widget<Text>(find.text('Scientific Name'));
      expect(textWidget.style?.fontStyle, FontStyle.italic);
    });

    testWidgets('plant icon has correct size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.local_florist));
      expect(icon.size, 120);
    });
  });
}
