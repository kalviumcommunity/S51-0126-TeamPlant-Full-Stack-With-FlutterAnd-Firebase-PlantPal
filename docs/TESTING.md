# Testing Strategy for PlantPal

## Overview

PlantPal follows a comprehensive testing approach to ensure quality and reliability across all features. This document outlines the testing strategy, best practices, and guidelines for the development team.

## Testing Pyramid

The PlantPal testing strategy follows the testing pyramid approach:

```
        /\
       /  \
      / IT \      Integration Tests (Fewer)
     /______\
    /        \
   /  Widget  \   Widget Tests (More)
  /____________\
 /              \
/   Unit Tests   \ Unit Tests (Most)
/__________________\
```

### Unit Tests (`test/unit/`)

Unit tests verify individual functions, classes, and methods in isolation.

**What to test:**
- Business logic in services (AuthService, FirestoreService)
- Data model validation and serialization
- Utility functions and helpers
- State management logic

**Characteristics:**
- Fast execution (milliseconds)
- No dependencies on external systems
- High coverage target (80%+)
- Use mocks for dependencies

**Examples:**
```dart
// test/unit/auth_service_test.dart
test('signIn returns user when credentials are valid', () async {
  // Arrange
  final mockAuth = MockFirebaseAuth();
  final authService = AuthService(auth: mockAuth);

  // Act
  final user = await authService.signIn('test@example.com', 'password123');

  // Assert
  expect(user, isNotNull);
  expect(user?.email, 'test@example.com');
});
```

---

### Widget Tests (`test/widget/`)

Widget tests verify UI components render correctly and handle user interactions.

**What to test:**
- Individual screens and widgets
- User interactions (taps, text input, gestures)
- Widget state changes
- UI validation and error messages

**Characteristics:**
- Medium execution speed
- Test UI in isolation
- Use widget tester utilities
- Mock business logic dependencies

**Examples:**
```dart
// test/widget/login_screen_test.dart
testWidgets('Login button is disabled when fields are empty', (tester) async {
  await tester.pumpWidget(MaterialApp(home: LoginScreen()));

  final loginButton = find.byType(ElevatedButton);
  expect(tester.widget<ElevatedButton>(loginButton).enabled, false);
});
```

---

### Integration Tests (`test/integration/`)

Integration tests verify complete feature flows end-to-end.

**What to test:**
- Complete user journeys (sign up → login → view plants → logout)
- Navigation between screens
- Firebase integration (with test Firebase instance)
- Data persistence and retrieval

**Characteristics:**
- Slower execution (seconds)
- Test multiple components together
- Use real or test backend services
- Fewer tests, but critical paths

**Examples:**
```dart
// test/integration/auth_flow_test.dart
testWidgets('Complete authentication flow', (tester) async {
  await tester.pumpWidget(PlantPalApp());

  // Navigate to signup
  await tester.tap(find.text('Sign Up'));
  await tester.pumpAndSettle();

  // Fill form and submit
  await tester.enterText(find.byType(TextField).first, 'test@example.com');
  await tester.enterText(find.byType(TextField).at(1), 'password123');
  await tester.tap(find.text('Create Account'));
  await tester.pumpAndSettle();

  // Verify navigation to home screen
  expect(find.text('Plant List'), findsOneWidget);
});
```

---

## Running Tests

### Command Reference

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage

# Run tests in watch mode
flutter test --watch

# Run only unit tests
flutter test test/unit

# Run only widget tests
flutter test test/widget

# Run only integration tests
flutter test test/integration

# Run tests with verbose output
flutter test --verbose

# Run tests on specific platform
flutter test --platform chrome
```

---

## CI/CD Pipeline

### GitHub Actions Workflow

Every pull request and push to `main` automatically triggers:

1. **Code Formatting Check**
   ```bash
   dart format --output=none --set-exit-if-changed .
   ```
   Ensures consistent code formatting across the project.

2. **Static Analysis**
   ```bash
   flutter analyze
   ```
   Checks for code quality issues, potential bugs, and linting violations.

3. **Automated Tests**
   ```bash
   flutter test --coverage
   ```
   Runs all tests and generates coverage report.

4. **Build Verification**
   ```bash
   flutter build apk --debug
   ```
   Ensures the app builds successfully.

### Workflow Configuration

The CI workflow is defined in `.github/workflows/flutter_ci.yml` and runs on:
- All pull requests to `main` and `feature/*` branches
- Direct pushes to `main` branch

### Pipeline Status

Check the status of your PR in the GitHub Actions tab or on the PR page.

---

## Test Coverage Goals

### Coverage Targets

| Component | Target Coverage | Priority |
|-----------|----------------|----------|
| Services (AuthService, FirestoreService) | 80%+ | High |
| Models (User, Plant) | 80%+ | High |
| Utilities | 80%+ | Medium |
| Screens (UI) | 60%+ | Medium |
| Widgets | 70%+ | Medium |

### Viewing Coverage

```bash
# Generate coverage report
flutter test --coverage

# View coverage in terminal (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## Writing Good Tests

### Do's ✅

1. **Write descriptive test names**
   ```dart
   ✅ test('signUp throws error when email is already in use', () {});
   ❌ test('test signup', () {});
   ```

2. **Follow Arrange-Act-Assert pattern**
   ```dart
   test('example', () {
     // Arrange: Set up test data and mocks
     final service = AuthService();

     // Act: Execute the code being tested
     final result = service.validateEmail('test@example.com');

     // Assert: Verify the outcome
     expect(result, true);
   });
   ```

3. **Test one thing per test**
   ```dart
   ✅ test('validateEmail returns true for valid email', () {});
   ✅ test('validateEmail returns false for invalid email', () {});
   ❌ test('validateEmail works correctly', () {}); // Too broad
   ```

4. **Use setUp() and tearDown() for common setup**
   ```dart
   late AuthService authService;

   setUp(() {
     authService = AuthService();
   });

   tearDown(() {
     authService.dispose();
   });
   ```

5. **Mock external dependencies**
   ```dart
   // Use mocks for Firebase, HTTP, etc.
   final mockFirestore = MockFirebaseFirestore();
   final service = PlantService(firestore: mockFirestore);
   ```

### Don'ts ❌

1. **Don't test Flutter framework code**
   - No need to test that `setState()` works
   - Focus on your business logic

2. **Don't write tests that depend on execution order**
   ```dart
   ❌ test('first test sets up data', () {});
   ❌ test('second test uses data from first', () {}); // BAD
   ```

3. **Don't skip cleanup in tearDown**
   ```dart
   tearDown(() {
     // Always clean up resources
     mockFirebase.reset();
     testDatabase.clear();
   });
   ```

4. **Don't use real Firebase in unit tests**
   - Use mocks or fake implementations
   - Save real Firebase for integration tests

5. **Don't ignore failing tests**
   - Fix or remove failing tests immediately
   - Never commit code with failing tests

---

## Mocking Firebase

### Firebase Auth Mocking

```yaml
# pubspec.yaml
dev_dependencies:
  firebase_auth_mocks: ^0.13.0
```

```dart
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

final mockUser = MockUser(
  uid: 'test-uid',
  email: 'test@example.com',
  displayName: 'Test User',
);

final mockAuth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
final authService = AuthService(auth: mockAuth);
```

### Firestore Mocking

```yaml
# pubspec.yaml
dev_dependencies:
  fake_cloud_firestore: ^2.4.0
```

```dart
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

final fakeFirestore = FakeFirebaseFirestore();
await fakeFirestore.collection('plants').add({
  'name': 'Snake Plant',
  'wateringFrequency': 'Every 2-3 weeks',
});

final plantService = PlantService(firestore: fakeFirestore);
```

---

## Manual Testing Checklist

Before marking a PR as ready for review, ensure:

- [ ] App builds without errors (`flutter build apk --debug`)
- [ ] No analyzer warnings (`flutter analyze`)
- [ ] All automated tests pass (`flutter test`)
- [ ] Manual smoke test on physical device or emulator
- [ ] UI looks correct on different screen sizes (phone, tablet)
- [ ] No console errors during app usage
- [ ] App handles network errors gracefully
- [ ] Navigation flows work as expected
- [ ] Forms validate input correctly
- [ ] Loading states display properly

---

## Testing Best Practices

### For UI/Flutter Lead (Monesh)

- Write widget tests for all new screens
- Test form validation and error states
- Verify navigation between screens
- Test responsive layouts on different screen sizes

### For Firebase/Backend Lead (Jaswant)

- Write unit tests for all service methods
- Mock Firebase dependencies in tests
- Test error handling for network failures
- Verify data serialization/deserialization

### For Testing/Deployment Lead (Kirtik)

- Maintain test infrastructure
- Monitor CI/CD pipeline health
- Review and improve test coverage
- Document testing processes
- Perform manual testing before releases

---

## Debugging Failed Tests

### Common Issues and Solutions

**Issue**: Widget test fails with "setState() called after dispose()"
```dart
// Solution: Use addTearDown to clean up
testWidgets('example', (tester) async {
  final controller = TextEditingController();
  addTearDown(controller.dispose);
  // ... test code
});
```

**Issue**: Async test times out
```dart
// Solution: Use pumpAndSettle() or increase timeout
await tester.pumpAndSettle(Duration(seconds: 5));
```

**Issue**: Firebase mock not working
```dart
// Solution: Ensure mock is properly injected
final authService = AuthService(auth: mockFirebaseAuth); // Pass explicitly
```

---

## Future Testing Enhancements

### Planned Improvements

1. **Integration Test Package**
   - Add `integration_test` package for E2E tests
   - Test complete user journeys on real devices

2. **Performance Testing**
   - Add performance benchmarks
   - Monitor app startup time
   - Track memory usage

3. **Visual Regression Testing**
   - Implement screenshot comparison tests
   - Detect unintended UI changes

4. **Test Data Factories**
   - Create test data builders for complex models
   - Improve test data management

5. **Code Coverage Dashboard**
   - Integrate Codecov or similar service
   - Track coverage trends over time

---

## Resources

- [Flutter Testing Documentation](https://flutter.dev/docs/testing)
- [Widget Testing](https://flutter.dev/docs/cookbook/testing/widget)
- [Integration Testing](https://flutter.dev/docs/testing/integration-tests)
- [Firebase Testing](https://firebase.google.com/docs/emulator-suite)
- [Mockito Package](https://pub.dev/packages/mockito)
- [Bloc Testing](https://pub.dev/packages/bloc_test)

---

## Support

For testing-related questions or issues:
- Contact: Kirtik (Testing & Deployment Lead)
- Email: kiruthik.j@kalvium.community
- Review this document regularly for updates

---

**Last Updated**: January 2026
**Maintained By**: Kirtik (Testing & Deployment Lead)
