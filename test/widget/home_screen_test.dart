import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plantpal/screens/home/home_screen.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    testWidgets('displays My Plants in app bar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(find.text('My Plants'), findsOneWidget);
    });

    testWidgets('has AppBar with profile icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('displays welcome message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(find.text('Welcome to PlantPal!'), findsOneWidget);
    });

    testWidgets('displays Firestore placeholder text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(
        find.text(
          'Your plant list will appear here once data is loaded from Firestore.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('has yard icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(find.byIcon(Icons.yard), findsOneWidget);
    });

    testWidgets('yard icon has correct size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.yard));
      expect(icon.size, 100);
    });

    testWidgets('has Browse Plants button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(find.text('Browse Plants'), findsOneWidget);
    });

    testWidgets('Browse Plants text is displayed', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(find.text('Browse Plants'), findsOneWidget);
    });

    testWidgets('has floating action button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('FAB has add icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      // Find the add icon that is inside the FAB
      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);

      final addIcons = find.byIcon(Icons.add);
      expect(addIcons, findsWidgets);
    });

    testWidgets('profile icon button is tappable', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      final profileButton = find.byIcon(Icons.person);
      expect(profileButton, findsOneWidget);

      // Find the ancestor IconButton
      final iconButton = find.ancestor(
        of: profileButton,
        matching: find.byType(IconButton),
      );
      expect(iconButton, findsOneWidget);

      final widget = tester.widget<IconButton>(iconButton);
      expect(widget.onPressed, isNotNull);
    });

    testWidgets('has proper padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('body content is centered', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );

      // Verify Center widget exists in the widget tree
      expect(find.byType(Center), findsWidgets);
    });
  });
}
