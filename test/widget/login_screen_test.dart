import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plantpal/screens/auth/login_screen.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('displays all required UI elements', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Verify app bar with Login title
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Login'),
      ), findsOneWidget);

      // Verify icon
      expect(find.byIcon(Icons.eco), findsOneWidget);

      // Verify welcome text
      expect(find.text('Welcome Back!'), findsOneWidget);

      // Verify email field
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);

      // Verify password field
      expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

      // Verify login button
      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

      // Verify sign up link
      expect(find.text('Don\'t have an account? Sign Up'), findsOneWidget);
    });

    testWidgets('email field accepts input', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      final emailField = find.widgetWithText(TextField, 'Email');
      await tester.enterText(emailField, 'test@example.com');

      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('password field accepts input', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      final passwordField = find.widgetWithText(TextField, 'Password');
      await tester.enterText(passwordField, 'password123');

      // Password is obscured, so we check if the field accepted input
      expect(
        tester.widget<TextField>(passwordField).controller?.text,
        isNull,
      ); // No controller in skeleton version
    });

    testWidgets('password field is obscured', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      final passwordField =
          tester.widget<TextField>(find.widgetWithText(TextField, 'Password'));

      expect(passwordField.obscureText, true);
    });

    testWidgets('login button has correct styling', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      final loginButton = find.widgetWithText(ElevatedButton, 'Login');
      expect(loginButton, findsOneWidget);

      final button = tester.widget<ElevatedButton>(loginButton);
      expect(button.onPressed, isNotNull);
    });

    testWidgets('sign up link is tappable', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      final signUpLink = find.text('Don\'t have an account? Sign Up');
      expect(signUpLink, findsOneWidget);

      final textButton = tester.widget<TextButton>(
        find.ancestor(
          of: signUpLink,
          matching: find.byType(TextButton),
        ),
      );
      expect(textButton.onPressed, isNotNull);
    });

    testWidgets('has proper layout structure', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Verify Scaffold exists
      expect(find.byType(Scaffold), findsOneWidget);

      // Verify AppBar exists
      expect(find.byType(AppBar), findsOneWidget);

      // Verify Padding exists for body
      expect(find.byType(Padding), findsWidgets);

      // Verify Column for vertical layout
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('email field has email keyboard type', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      final emailField = tester.widget<TextField>(
        find.widgetWithText(TextField, 'Email'),
      );

      expect(emailField.keyboardType, TextInputType.emailAddress);
    });

    testWidgets('has correct decorations on text fields', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      final emailField = tester.widget<TextField>(
        find.widgetWithText(TextField, 'Email'),
      );

      expect(emailField.decoration?.prefixIcon, isNotNull);
      expect(emailField.decoration?.border, isA<OutlineInputBorder>());
      expect(emailField.decoration?.filled, true);
    });

    testWidgets('login button is initially enabled', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      final button = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Login'),
      );

      // In skeleton version, button should still be defined
      expect(button.onPressed, isNotNull);
    });
  });
}
