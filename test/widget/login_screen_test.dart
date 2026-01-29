import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plantpal/screens/auth/login_screen.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('displays Login in app bar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Login'),
      ), findsOneWidget);
    });

    testWidgets('displays Welcome Back text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      expect(find.text('Welcome Back!'), findsOneWidget);
    });

    testWidgets('displays eco icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      expect(find.byIcon(Icons.eco), findsOneWidget);
    });

    testWidgets('has email text field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    });

    testWidgets('has password text field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    });

    testWidgets('email field has email icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('password field has lock icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      expect(find.byIcon(Icons.lock), findsOneWidget);
    });

    testWidgets('password field is obscured', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      final passwordField = tester.widget<TextField>(
        find.widgetWithText(TextField, 'Password'),
      );
      expect(passwordField.obscureText, true);
    });

    testWidgets('email field has email keyboard type', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      final emailField = tester.widget<TextField>(
        find.widgetWithText(TextField, 'Email'),
      );
      expect(emailField.keyboardType, TextInputType.emailAddress);
    });

    testWidgets('has Login button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    });

    testWidgets('has Sign Up link', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      expect(find.text("Don't have an account? Sign Up"), findsOneWidget);
    });

    testWidgets('has 2 text fields', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      expect(find.byType(TextField), findsNWidgets(2));
    });
  });
}
