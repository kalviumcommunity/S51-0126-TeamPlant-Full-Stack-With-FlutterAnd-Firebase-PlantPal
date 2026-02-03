import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../screens/reminders/reminders_screen.dart';

/// A compact card showing reminder summary for the home screen
class RemindersSummaryCard extends StatelessWidget {
  final int overdueCount;
  final int dueTodayCount;
  final VoidCallback? onTap;

  const RemindersSummaryCard({
    super.key,
    this.overdueCount = 0,
    this.dueTodayCount = 0,
    this.onTap,
  });

  int get totalDue => overdueCount + dueTodayCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: InkWell(
        onTap: onTap ?? () => _navigateToReminders(context),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIcon(),
                  color: _getIconColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTitle(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getSubtitle(),
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              // Badge and arrow
              if (totalDue > 0) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: overdueCount > 0 ? Colors.red : Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$totalDue',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (overdueCount > 0) {
      return Colors.red.withAlpha(30);
    } else if (dueTodayCount > 0) {
      return Colors.orange.withAlpha(30);
    }
    return Colors.green.withAlpha(30);
  }

  IconData _getIcon() {
    if (overdueCount > 0) {
      return Icons.warning_amber_rounded;
    } else if (dueTodayCount > 0) {
      return Icons.notifications_active;
    }
    return Icons.check_circle_outline;
  }

  Color _getIconColor() {
    if (overdueCount > 0) {
      return Colors.red;
    } else if (dueTodayCount > 0) {
      return Colors.orange;
    }
    return Colors.green;
  }

  String _getTitle() {
    if (overdueCount > 0) {
      return '$overdueCount overdue reminder${overdueCount > 1 ? 's' : ''}';
    } else if (dueTodayCount > 0) {
      return '$dueTodayCount reminder${dueTodayCount > 1 ? 's' : ''} due today';
    }
    return 'All caught up!';
  }

  String _getSubtitle() {
    if (overdueCount > 0) {
      return 'Your plants need attention';
    } else if (dueTodayCount > 0) {
      return 'Take care of your plants today';
    }
    return 'No reminders pending';
  }

  void _navigateToReminders(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RemindersScreen(),
      ),
    );
  }
}

/// A minimal reminder badge for showing in app bars or other compact spaces
class ReminderBadge extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;

  const ReminderBadge({
    super.key,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: onTap ?? () => _navigateToReminders(context),
          tooltip: 'Reminders',
        ),
        if (count > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                count > 9 ? '9+' : '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  void _navigateToReminders(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RemindersScreen(),
      ),
    );
  }
}
