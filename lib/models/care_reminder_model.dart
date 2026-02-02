import 'package:cloud_firestore/cloud_firestore.dart';

/// Types of care reminders available
enum ReminderType {
  water('water', 'Water', 'Time to water your plant'),
  fertilize('fertilize', 'Fertilize', 'Time to fertilize your plant'),
  repot('repot', 'Repot', 'Consider repotting your plant'),
  prune('prune', 'Prune', 'Time to prune your plant'),
  rotate('rotate', 'Rotate', 'Rotate your plant for even growth');

  final String value;
  final String displayName;
  final String defaultMessage;

  const ReminderType(this.value, this.displayName, this.defaultMessage);

  static ReminderType fromString(String value) {
    return ReminderType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => ReminderType.water,
    );
  }
}

/// Model representing a plant care reminder
class CareReminderModel {
  final String id;
  final String plantId;
  final String plantName;
  final ReminderType reminderType;
  final int frequencyDays;
  final DateTime? lastCompleted;
  final DateTime nextDue;
  final bool enabled;
  final String? customMessage;
  final DateTime createdAt;

  CareReminderModel({
    required this.id,
    required this.plantId,
    required this.plantName,
    required this.reminderType,
    required this.frequencyDays,
    this.lastCompleted,
    required this.nextDue,
    this.enabled = true,
    this.customMessage,
    required this.createdAt,
  });

  /// Check if the reminder is due (or overdue)
  bool get isDue => DateTime.now().isAfter(nextDue);

  /// Check if the reminder is overdue by more than a day
  bool get isOverdue {
    final now = DateTime.now();
    return now.difference(nextDue).inDays > 0;
  }

  /// Get days until the reminder is due (negative if overdue)
  int get daysUntilDue {
    final now = DateTime.now();
    return nextDue.difference(now).inDays;
  }

  /// Get a human-readable status string
  String get statusText {
    final days = daysUntilDue;
    if (days < 0) {
      return 'Overdue by ${-days} day${-days == 1 ? '' : 's'}';
    } else if (days == 0) {
      return 'Due today';
    } else if (days == 1) {
      return 'Due tomorrow';
    } else {
      return 'Due in $days days';
    }
  }

  /// Get the notification message for this reminder
  String get notificationMessage {
    return customMessage ?? reminderType.defaultMessage;
  }

  /// Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'plantId': plantId,
      'plantName': plantName,
      'reminderType': reminderType.value,
      'frequencyDays': frequencyDays,
      'lastCompleted': lastCompleted != null
          ? Timestamp.fromDate(lastCompleted!)
          : null,
      'nextDue': Timestamp.fromDate(nextDue),
      'enabled': enabled,
      'customMessage': customMessage,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// Create from Firestore document
  factory CareReminderModel.fromMap(Map<String, dynamic> map, String documentId) {
    return CareReminderModel(
      id: documentId,
      plantId: map['plantId'] ?? '',
      plantName: map['plantName'] ?? '',
      reminderType: ReminderType.fromString(map['reminderType'] ?? 'water'),
      frequencyDays: map['frequencyDays'] ?? 7,
      lastCompleted: map['lastCompleted'] != null
          ? (map['lastCompleted'] as Timestamp).toDate()
          : null,
      nextDue: (map['nextDue'] as Timestamp).toDate(),
      enabled: map['enabled'] ?? true,
      customMessage: map['customMessage'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  /// Create from Firestore DocumentSnapshot
  factory CareReminderModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CareReminderModel.fromMap(data, doc.id);
  }

  /// Mark this reminder as completed and calculate next due date
  CareReminderModel markCompleted() {
    final now = DateTime.now();
    return CareReminderModel(
      id: id,
      plantId: plantId,
      plantName: plantName,
      reminderType: reminderType,
      frequencyDays: frequencyDays,
      lastCompleted: now,
      nextDue: now.add(Duration(days: frequencyDays)),
      enabled: enabled,
      customMessage: customMessage,
      createdAt: createdAt,
    );
  }

  /// Create a copy with updated fields
  CareReminderModel copyWith({
    String? id,
    String? plantId,
    String? plantName,
    ReminderType? reminderType,
    int? frequencyDays,
    DateTime? lastCompleted,
    DateTime? nextDue,
    bool? enabled,
    String? customMessage,
    DateTime? createdAt,
  }) {
    return CareReminderModel(
      id: id ?? this.id,
      plantId: plantId ?? this.plantId,
      plantName: plantName ?? this.plantName,
      reminderType: reminderType ?? this.reminderType,
      frequencyDays: frequencyDays ?? this.frequencyDays,
      lastCompleted: lastCompleted ?? this.lastCompleted,
      nextDue: nextDue ?? this.nextDue,
      enabled: enabled ?? this.enabled,
      customMessage: customMessage ?? this.customMessage,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'CareReminderModel(id: $id, plantName: $plantName, type: ${reminderType.displayName}, nextDue: $nextDue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CareReminderModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
