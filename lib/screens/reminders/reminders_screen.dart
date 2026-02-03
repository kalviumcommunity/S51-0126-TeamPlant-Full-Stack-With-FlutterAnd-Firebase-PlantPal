import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Model for displaying reminder items in the UI
class ReminderItem {
  final String id;
  final String plantName;
  final String reminderType;
  final String dueText;
  final bool isOverdue;
  final bool isDueToday;
  final IconData typeIcon;
  final Color typeColor;

  const ReminderItem({
    required this.id,
    required this.plantName,
    required this.reminderType,
    required this.dueText,
    this.isOverdue = false,
    this.isDueToday = false,
    required this.typeIcon,
    required this.typeColor,
  });
}

/// Screen displaying all plant care reminders organized by urgency
class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  // Sample data - will be replaced with Firestore data
  final List<ReminderItem> _overdueReminders = [
    ReminderItem(
      id: '1',
      plantName: 'Snake Plant',
      reminderType: 'Water',
      dueText: 'Overdue by 2 days',
      isOverdue: true,
      typeIcon: Icons.water_drop,
      typeColor: Colors.blue,
    ),
  ];

  final List<ReminderItem> _todayReminders = [
    ReminderItem(
      id: '2',
      plantName: 'Pothos',
      reminderType: 'Water',
      dueText: 'Due today',
      isDueToday: true,
      typeIcon: Icons.water_drop,
      typeColor: Colors.blue,
    ),
    ReminderItem(
      id: '3',
      plantName: 'Peace Lily',
      reminderType: 'Fertilize',
      dueText: 'Due today',
      isDueToday: true,
      typeIcon: Icons.eco,
      typeColor: Colors.green,
    ),
  ];

  final List<ReminderItem> _upcomingReminders = [
    ReminderItem(
      id: '4',
      plantName: 'Spider Plant',
      reminderType: 'Water',
      dueText: 'Due tomorrow',
      typeIcon: Icons.water_drop,
      typeColor: Colors.blue,
    ),
    ReminderItem(
      id: '5',
      plantName: 'Aloe Vera',
      reminderType: 'Repot',
      dueText: 'Due in 3 days',
      typeIcon: Icons.yard,
      typeColor: Colors.brown,
    ),
    ReminderItem(
      id: '6',
      plantName: 'Snake Plant',
      reminderType: 'Rotate',
      dueText: 'Due in 5 days',
      typeIcon: Icons.rotate_right,
      typeColor: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final totalDue = _overdueReminders.length + _todayReminders.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Care Reminders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddReminderSheet,
            tooltip: 'Add reminder',
          ),
        ],
      ),
      body: _overdueReminders.isEmpty &&
              _todayReminders.isEmpty &&
              _upcomingReminders.isEmpty
          ? _buildEmptyState()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary card
                  _buildSummaryCard(totalDue),
                  const SizedBox(height: 24),

                  // Overdue section
                  if (_overdueReminders.isNotEmpty) ...[
                    _buildSectionHeader(
                      'Overdue',
                      Icons.warning_amber_rounded,
                      Colors.red,
                      _overdueReminders.length,
                    ),
                    const SizedBox(height: 8),
                    ..._overdueReminders
                        .map((r) => _buildReminderCard(r, isUrgent: true)),
                    const SizedBox(height: 20),
                  ],

                  // Due today section
                  if (_todayReminders.isNotEmpty) ...[
                    _buildSectionHeader(
                      'Due Today',
                      Icons.today,
                      Colors.orange,
                      _todayReminders.length,
                    ),
                    const SizedBox(height: 8),
                    ..._todayReminders.map((r) => _buildReminderCard(r)),
                    const SizedBox(height: 20),
                  ],

                  // Upcoming section
                  if (_upcomingReminders.isNotEmpty) ...[
                    _buildSectionHeader(
                      'Upcoming',
                      Icons.schedule,
                      Colors.grey,
                      _upcomingReminders.length,
                    ),
                    const SizedBox(height: 8),
                    ..._upcomingReminders.map((r) => _buildReminderCard(r)),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryCard(int totalDue) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withAlpha(200),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(80),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.notifications_active,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      totalDue > 0 ? '$totalDue tasks need attention' : 'All caught up!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      totalDue > 0
                          ? 'Take care of your plants today'
                          : 'Your plants are happy',
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    IconData icon,
    Color color,
    int count,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReminderCard(ReminderItem reminder, {bool isUrgent = false}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isUrgent
            ? const BorderSide(color: Colors.red, width: 1)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () => _showReminderOptions(reminder),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Type icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: reminder.typeColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  reminder.typeIcon,
                  color: reminder.typeColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reminder.plantName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          reminder.reminderType,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          reminder.dueText,
                          style: TextStyle(
                            color: isUrgent ? Colors.red : AppColors.textSecondary,
                            fontSize: 13,
                            fontWeight: isUrgent ? FontWeight.w500 : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Complete button
              IconButton(
                icon: Icon(
                  Icons.check_circle_outline,
                  color: AppColors.primary,
                ),
                onPressed: () => _completeReminder(reminder),
                tooltip: 'Mark as done',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            const Text(
              'No Reminders Yet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Add reminders to keep track of your plant care schedule',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _showAddReminderSheet,
              icon: const Icon(Icons.add),
              label: const Text('Add Reminder'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddReminderSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Reminder',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Reminder creation will be available once you add plants to your collection.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Got it'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showReminderOptions(ReminderItem reminder) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.check_circle, color: AppColors.primary),
              title: const Text('Mark as Complete'),
              onTap: () {
                Navigator.pop(context);
                _completeReminder(reminder);
              },
            ),
            ListTile(
              leading: const Icon(Icons.snooze, color: Colors.orange),
              title: const Text('Snooze (1 day)'),
              onTap: () {
                Navigator.pop(context);
                _snoozeReminder(reminder);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_outlined, color: Colors.blue),
              title: const Text('Edit Reminder'),
              onTap: () {
                Navigator.pop(context);
                _editReminder(reminder);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Delete Reminder'),
              onTap: () {
                Navigator.pop(context);
                _deleteReminder(reminder);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _completeReminder(ReminderItem reminder) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${reminder.reminderType} completed for ${reminder.plantName}!'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            // Undo logic will be implemented with Firestore
          },
        ),
      ),
    );
  }

  void _snoozeReminder(ReminderItem reminder) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${reminder.reminderType} snoozed for 1 day'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _editReminder(ReminderItem reminder) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit reminder feature coming soon'),
      ),
    );
  }

  void _deleteReminder(ReminderItem reminder) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Reminder?'),
        content: Text(
          'Are you sure you want to delete the ${reminder.reminderType.toLowerCase()} reminder for ${reminder.plantName}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reminder deleted'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
