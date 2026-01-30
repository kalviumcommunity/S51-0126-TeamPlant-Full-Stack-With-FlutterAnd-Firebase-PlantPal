import 'package:flutter_test/flutter_test.dart';
import 'package:plantpal/models/user_model.dart';

void main() {
  group('UserModel Tests', () {
    UserModel createSampleUser() {
      return UserModel(
        uid: 'test-uid-123',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: DateTime(2025, 1, 1),
        lastLogin: DateTime(2025, 1, 15),
      );
    }

    test('creates UserModel with all required fields', () {
      final user = createSampleUser();

      expect(user.uid, 'test-uid-123');
      expect(user.email, 'test@example.com');
      expect(user.displayName, 'Test User');
    });

    test('UserModel has correct createdAt date', () {
      final user = createSampleUser();

      expect(user.createdAt, DateTime(2025, 1, 1));
    });

    test('UserModel has correct lastLogin date', () {
      final user = createSampleUser();

      expect(user.lastLogin, DateTime(2025, 1, 15));
    });

    test('UserModel toMap returns correct data', () {
      final user = createSampleUser();
      final map = user.toMap();

      expect(map['uid'], 'test-uid-123');
      expect(map['email'], 'test@example.com');
      expect(map['displayName'], 'Test User');
    });

    test('UserModel copyWith creates new instance with updated values', () {
      final user = createSampleUser();
      final updatedUser = user.copyWith(displayName: 'New Name');

      expect(updatedUser.displayName, 'New Name');
      expect(updatedUser.email, user.email);
      expect(updatedUser.uid, user.uid);
    });

    test('UserModel copyWith can update email', () {
      final user = createSampleUser();
      final updatedUser = user.copyWith(email: 'new@example.com');

      expect(updatedUser.email, 'new@example.com');
      expect(updatedUser.displayName, user.displayName);
    });

    test('UserModel copyWith can update lastLogin', () {
      final user = createSampleUser();
      final newLoginTime = DateTime(2025, 2, 1);
      final updatedUser = user.copyWith(lastLogin: newLoginTime);

      expect(updatedUser.lastLogin, newLoginTime);
    });

    test('UserModel toString contains uid', () {
      final user = createSampleUser();
      final stringRep = user.toString();

      expect(stringRep.contains('test-uid-123'), isTrue);
    });

    test('UserModel toString contains email', () {
      final user = createSampleUser();
      final stringRep = user.toString();

      expect(stringRep.contains('test@example.com'), isTrue);
    });

    test('UserModel equality works correctly', () {
      final createdAt = DateTime(2025, 1, 1);
      final lastLogin = DateTime(2025, 1, 15);

      final user1 = UserModel(
        uid: 'same-uid',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: createdAt,
        lastLogin: lastLogin,
      );

      final user2 = UserModel(
        uid: 'same-uid',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: createdAt,
        lastLogin: lastLogin,
      );

      // Equality based on all fields
      expect(user1 == user2, isTrue);
    });

    test('UserModel with different uid are not equal', () {
      final user1 = UserModel(
        uid: 'uid-1',
        email: 'test@example.com',
        displayName: 'User',
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );

      final user2 = UserModel(
        uid: 'uid-2',
        email: 'test@example.com',
        displayName: 'User',
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );

      expect(user1 == user2, isFalse);
    });

    test('UserModel hashCode is consistent for same data', () {
      final createdAt = DateTime(2025, 1, 1);
      final lastLogin = DateTime(2025, 1, 15);

      final user1 = UserModel(
        uid: 'test-uid',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: createdAt,
        lastLogin: lastLogin,
      );

      final user2 = UserModel(
        uid: 'test-uid',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: createdAt,
        lastLogin: lastLogin,
      );

      expect(user1.hashCode, user2.hashCode);
    });

    test('UserModel can be created with minimal data', () {
      final user = UserModel(
        uid: 'min-uid',
        email: 'min@test.com',
        displayName: '',
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );

      expect(user.uid, 'min-uid');
      expect(user.displayName, '');
    });

    test('UserModel preserves all fields on copyWith with no changes', () {
      final user = createSampleUser();
      final copied = user.copyWith();

      expect(copied.uid, user.uid);
      expect(copied.email, user.email);
      expect(copied.displayName, user.displayName);
      expect(copied.createdAt, user.createdAt);
      expect(copied.lastLogin, user.lastLogin);
    });
  });
}
