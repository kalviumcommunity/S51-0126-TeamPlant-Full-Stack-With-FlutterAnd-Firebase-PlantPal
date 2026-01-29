import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plantpal/screens/auth/signup_screen.dart';

void main() {
  group('SignupScreen Widget Tests', () {
    testWidgets('displays Sign Up in app bar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Sign Up'),
      ), findsOneWidget);
    });

    testWidgets('displays Create Account text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.text('Create Account'), findsOneWidget);
    });

    testWidgets('displays person add icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.byIcon(Icons.person_add), findsOneWidget);
    });

    testWidgets('has Full Name text field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.widgetWithText(TextField, 'Full Name'), findsOneWidget);
    });

    testWidgets('has Email text field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    });

    testWidgets('has Password text field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    });

    testWidgets('has Confirm Password text field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.widgetWithText(TextField, 'Confirm Password'), findsOneWidget);
    });

    testWidgets('has 4 text fields', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.byType(TextField), findsNWidgets(4));
    });

    testWidgets('has person icon for name field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('has email icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('has lock icons for password fields', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.byIcon(Icons.lock), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });

    testWidgets('password fields are obscured', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      final passwordField = tester.widget<TextField>(
        find.widgetWithText(TextField, 'Password'),
      );
      final confirmPasswordField = tester.widget<TextField>(
        find.widgetWithText(TextField, 'Confirm Password'),
      );

      expect(passwordField.obscureText, true);
      expect(confirmPasswordField.obscureText, true);
    });

    testWidgets('email field has email keyboard type', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      final emailField = tester.widget<TextField>(
        find.widgetWithText(TextField, 'Email'),
      );
      expect(emailField.keyboardType, TextInputType.emailAddress);
    });

    testWidgets('has Sign Up button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsOneWidget);
    });

    testWidgets('has Login link', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.text('Already have an account? Login'), findsOneWidget);
    });

    testWidgets('is scrollable', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SignupScreen()),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
