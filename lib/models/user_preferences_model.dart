import 'package:cloud_firestore/cloud_firestore.dart';

/// Theme mode options for the app
enum AppThemeMode {
  light('light', 'Light'),
  dark('dark', 'Dark'),
  system('system', 'System');

  final String value;
  final String displayName;

  const AppThemeMode(this.value, this.displayName);

  static AppThemeMode fromString(String value) {
    return AppThemeMode.values.firstWhere(
      (mode) => mode.value == value,
      orElse: () => AppThemeMode.system,
    );
  }
}

/// Default reminder times
enum DefaultReminderTime {
  morning('morning', 'Morning (8:00 AM)', 8),
  noon('noon', 'Noon (12:00 PM)', 12),
  afternoon('afternoon', 'Afternoon (3:00 PM)', 15),
  evening('evening', 'Evening (6:00 PM)', 18);

  final String value;
  final String displayName;
  final int hour;

  const DefaultReminderTime(this.value, this.displayName, this.hour);

  static DefaultReminderTime fromString(String value) {
    return DefaultReminderTime.values.firstWhere(
      (time) => time.value == value,
      orElse: () => DefaultReminderTime.morning,
    );
  }
}

/// Model representing user preferences and settings
class UserPreferencesModel {
  final String uid;

  // Notification preferences
  final bool notificationsEnabled;
  final bool emailNotifications;
  final bool pushNotifications;
  final DefaultReminderTime defaultReminderTime;

  // Display preferences
  final AppThemeMode themeMode;
  final bool showPlantImages;
  final bool compactView;

  // Care reminder defaults
  final int defaultWaterReminderDays;
  final int defaultFertilizeReminderDays;

  // App behavior
  final bool confirmBeforeDelete;
  final bool autoMarkOverdue;

  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;

  UserPreferencesModel({
    required this.uid,
    this.notificationsEnabled = true,
    this.emailNotifications = false,
    this.pushNotifications = true,
    this.defaultReminderTime = DefaultReminderTime.morning,
    this.themeMode = AppThemeMode.system,
    this.showPlantImages = true,
    this.compactView = false,
    this.defaultWaterReminderDays = 7,
    this.defaultFertilizeReminderDays = 30,
    this.confirmBeforeDelete = true,
    this.autoMarkOverdue = false,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create default preferences for a new user
  factory UserPreferencesModel.defaults(String uid) {
    final now = DateTime.now();
    return UserPreferencesModel(
      uid: uid,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'notificationsEnabled': notificationsEnabled,
      'emailNotifications': emailNotifications,
      'pushNotifications': pushNotifications,
      'defaultReminderTime': defaultReminderTime.value,
      'themeMode': themeMode.value,
      'showPlantImages': showPlantImages,
      'compactView': compactView,
      'defaultWaterReminderDays': defaultWaterReminderDays,
      'defaultFertilizeReminderDays': defaultFertilizeReminderDays,
      'confirmBeforeDelete': confirmBeforeDelete,
      'autoMarkOverdue': autoMarkOverdue,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  /// Create from Firestore map
  factory UserPreferencesModel.fromMap(Map<String, dynamic> map) {
    return UserPreferencesModel(
      uid: map['uid'] ?? '',
      notificationsEnabled: map['notificationsEnabled'] ?? true,
      emailNotifications: map['emailNotifications'] ?? false,
      pushNotifications: map['pushNotifications'] ?? true,
      defaultReminderTime: DefaultReminderTime.fromString(
        map['defaultReminderTime'] ?? 'morning',
      ),
      themeMode: AppThemeMode.fromString(map['themeMode'] ?? 'system'),
      showPlantImages: map['showPlantImages'] ?? true,
      compactView: map['compactView'] ?? false,
      defaultWaterReminderDays: map['defaultWaterReminderDays'] ?? 7,
      defaultFertilizeReminderDays: map['defaultFertilizeReminderDays'] ?? 30,
      confirmBeforeDelete: map['confirmBeforeDelete'] ?? true,
      autoMarkOverdue: map['autoMarkOverdue'] ?? false,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  /// Create from Firestore document
  factory UserPreferencesModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserPreferencesModel.fromMap(data);
  }

  /// Create a copy with updated fields
  UserPreferencesModel copyWith({
    String? uid,
    bool? notificationsEnabled,
    bool? emailNotifications,
    bool? pushNotifications,
    DefaultReminderTime? defaultReminderTime,
    AppThemeMode? themeMode,
    bool? showPlantImages,
    bool? compactView,
    int? defaultWaterReminderDays,
    int? defaultFertilizeReminderDays,
    bool? confirmBeforeDelete,
    bool? autoMarkOverdue,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserPreferencesModel(
      uid: uid ?? this.uid,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      defaultReminderTime: defaultReminderTime ?? this.defaultReminderTime,
      themeMode: themeMode ?? this.themeMode,
      showPlantImages: showPlantImages ?? this.showPlantImages,
      compactView: compactView ?? this.compactView,
      defaultWaterReminderDays:
          defaultWaterReminderDays ?? this.defaultWaterReminderDays,
      defaultFertilizeReminderDays:
          defaultFertilizeReminderDays ?? this.defaultFertilizeReminderDays,
      confirmBeforeDelete: confirmBeforeDelete ?? this.confirmBeforeDelete,
      autoMarkOverdue: autoMarkOverdue ?? this.autoMarkOverdue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'UserPreferencesModel(uid: $uid, theme: ${themeMode.displayName}, notifications: $notificationsEnabled)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserPreferencesModel && other.uid == uid;
  }

  @override
  int get hashCode => uid.hashCode;
}
