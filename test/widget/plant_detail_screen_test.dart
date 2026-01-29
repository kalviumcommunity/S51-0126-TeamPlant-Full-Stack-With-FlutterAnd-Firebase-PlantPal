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

    testWidgets('displays plant icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.byIcon(Icons.local_florist), findsOneWidget);
    });

    testWidgets('plant icon has correct size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.local_florist));
      expect(icon.size, 120);
    });

    testWidgets('displays Plant Name placeholder', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.text('Plant Name'), findsOneWidget);
    });

    testWidgets('displays Scientific Name placeholder', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.text('Scientific Name'), findsOneWidget);
    });

    testWidgets('displays Watering Frequency card', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.text('Watering Frequency'), findsOneWidget);
      expect(find.byIcon(Icons.water_drop), findsOneWidget);
    });

    testWidgets('displays Sunlight Requirements card', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.text('Sunlight Requirements'), findsOneWidget);
      expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    });

    testWidgets('displays Care Instructions card', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.text('Care Instructions'), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('has Add to My Plants button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.text('Add to My Plants'), findsOneWidget);
      expect(find.byIcon(Icons.bookmark_add), findsOneWidget);
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

    testWidgets('has proper padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('plant name has correct font style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      final text = tester.widget<Text>(find.text('Plant Name'));
      expect(text.style?.fontSize, 28);
      expect(text.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('scientific name has italic style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PlantDetailScreen()),
      );

      final text = tester.widget<Text>(find.text('Scientific Name'));
      expect(text.style?.fontStyle, FontStyle.italic);
    });
  });
}
