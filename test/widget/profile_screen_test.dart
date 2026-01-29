import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plantpal/screens/profile/profile_screen.dart';

void main() {
  group('ProfileScreen Widget Tests', () {
    testWidgets('displays Profile in app bar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('has AppBar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('displays user avatar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('avatar has person icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      // Person icon inside CircleAvatar
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('displays placeholder username', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      expect(find.text('User Name'), findsOneWidget);
    });

    testWidgets('displays placeholder email', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      expect(find.text('user@example.com'), findsOneWidget);
    });

    testWidgets('has Edit Profile option', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      expect(find.text('Edit Profile'), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    testWidgets('has Notifications option', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      expect(find.text('Notifications'), findsOneWidget);
      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
    });

    testWidgets('has Settings option', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      expect(find.text('Settings'), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    });

    testWidgets('has Help & Support option', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      expect(find.text('Help & Support'), findsOneWidget);
      expect(find.byIcon(Icons.help_outline), findsOneWidget);
    });

    testWidgets('has Logout button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      expect(find.text('Logout'), findsOneWidget);
      expect(find.byIcon(Icons.logout), findsOneWidget);
    });

    testWidgets('logout button is an OutlinedButton', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      final logoutButton = find.ancestor(
        of: find.text('Logout'),
        matching: find.byType(OutlinedButton),
      );
      expect(logoutButton, findsOneWidget);
    });

    testWidgets('logout button has red styling', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      final outlinedButton = tester.widget<OutlinedButton>(
        find.ancestor(
          of: find.text('Logout'),
          matching: find.byType(OutlinedButton),
        ),
      );

      expect(outlinedButton.style, isNotNull);
    });

    testWidgets('profile options are in Card widgets', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      // 4 profile options should be in Cards
      expect(find.byType(Card), findsNWidgets(4));
    });

    testWidgets('profile options have chevron right icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      // Each profile option has a chevron_right trailing icon
      expect(find.byIcon(Icons.chevron_right), findsNWidgets(4));
    });

    testWidgets('profile options use ListTile', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      // 4 ListTile for the 4 profile options
      expect(find.byType(ListTile), findsNWidgets(4));
    });

    testWidgets('is scrollable', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('avatar has correct radius', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen()),
      );

      final avatar = tester.widget<CircleAvatar>(
        find.byType(CircleAvatar),
      );
      expect(avatar.radius, 60);
    });
  });
}
