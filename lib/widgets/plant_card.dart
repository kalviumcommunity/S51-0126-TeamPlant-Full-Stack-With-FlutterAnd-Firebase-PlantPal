import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class PlantCard extends StatelessWidget {
  final String name;
  final String scientificName;
  final String wateringFrequency;
  final String sunlight;
  final VoidCallback? onTap;

  const PlantCard({
    super.key,
    required this.name,
    required this.scientificName,
    required this.wateringFrequency,
    required this.sunlight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Plant icon placeholder
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.local_florist,
                  size: 40,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 12),
              // Plant name
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              // Scientific name
              Text(
                scientificName,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              // Care info row
              Row(
                children: [
                  _buildCareChip(Icons.water_drop, wateringFrequency),
                  const SizedBox(width: 8),
                  _buildCareChip(Icons.wb_sunny, sunlight),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCareChip(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: AppColors.primary),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
