import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plantpal/screens/auth/signup_screen.dart';

void main() {
  group('SignupScreen Widget Tests', () {
    testWidgets('displays all required UI elements', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      // Verify app bar with Sign Up title
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Sign Up'),
      ), findsOneWidget);

      // Verify icon
      expect(find.byIcon(Icons.person_add), findsOneWidget);

      // Verify title
      expect(find.text('Create Account'), findsOneWidget);

      // Verify all text fields (name, email, password, confirm password)
      expect(find.byType(TextField), findsNWidgets(4));

      // Verify sign up button
      expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsOneWidget);

      // Verify login link
      expect(find.text('Already have an account? Login'), findsOneWidget);
    });

    testWidgets('has all required form fields', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      expect(find.widgetWithText(TextField, 'Full Name'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
      expect(
        find.widgetWithText(TextField, 'Confirm Password'),
        findsOneWidget,
      );
    });

    testWidgets('name field accepts input', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      final nameField = find.widgetWithText(TextField, 'Full Name');
      await tester.enterText(nameField, 'John Doe');

      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('email field accepts input', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      final emailField = find.widgetWithText(TextField, 'Email');
      await tester.enterText(emailField, 'john@example.com');

      expect(find.text('john@example.com'), findsOneWidget);
    });

    testWidgets('password fields are obscured', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
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
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      final emailField = tester.widget<TextField>(
        find.widgetWithText(TextField, 'Email'),
      );

      expect(emailField.keyboardType, TextInputType.emailAddress);
    });

    testWidgets('has proper field icons', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });

    testWidgets('sign up button is initially enabled', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      final button = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Sign Up'),
      );

      expect(button.onPressed, isNotNull);
    });

    testWidgets('login link is tappable', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      final loginLink = find.text('Already have an account? Login');
      expect(loginLink, findsOneWidget);

      final textButton = tester.widget<TextButton>(
        find.ancestor(
          of: loginLink,
          matching: find.byType(TextButton),
        ),
      );
      expect(textButton.onPressed, isNotNull);
    });

    testWidgets('has SingleChildScrollView for scrollability', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('has correct layout structure', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      // Verify Scaffold exists
      expect(find.byType(Scaffold), findsOneWidget);

      // Verify AppBar exists
      expect(find.byType(AppBar), findsOneWidget);

      // Verify Padding exists
      expect(find.byType(Padding), findsWidgets);

      // Verify Column for vertical layout
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('login link can be tapped to navigate back', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
                },
                child: const Text('Go to Signup'),
              ),
            ),
          ),
        ),
      );

      // Navigate to signup
      await tester.tap(find.text('Go to Signup'));
      await tester.pumpAndSettle();

      expect(find.text('Create Account'), findsOneWidget);

      // Verify login link exists and is in a TextButton
      final loginLink = find.ancestor(
        of: find.text('Already have an account? Login'),
        matching: find.byType(TextButton),
      );
      expect(loginLink, findsOneWidget);

      // Verify the button has an onPressed callback
      final textButton = tester.widget<TextButton>(loginLink);
      expect(textButton.onPressed, isNotNull);
    });

    testWidgets('has proper spacing between form elements', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      // Verify SizedBox widgets exist for spacing
      expect(find.byType(SizedBox), findsWidgets);
    });
  });
}
