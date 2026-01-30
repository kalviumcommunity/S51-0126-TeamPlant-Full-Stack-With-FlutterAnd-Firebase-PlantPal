import 'package:flutter/material.dart';
import '../models/plant_model.dart';
import '../constants/app_colors.dart';

class PlantCard extends StatelessWidget {
  final PlantModel plant;
  final VoidCallback? onTap;

  const PlantCard({
    super.key,
    required this.plant,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plant Image/Icon Header
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.green[300]!,
                    Colors.green[600]!,
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  _getPlantIcon(plant.name),
                  size: 60,
                  color: Colors.white.withAlpha(230),
                ),
              ),
            ),
            // Plant Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      plant.scientificName,
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    // Care indicators
                    Row(
                      children: [
                        _buildCareChip(
                          Icons.water_drop,
                          _getWateringShort(plant.wateringFrequency),
                          Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        _buildCareChip(
                          Icons.wb_sunny,
                          _getSunlightShort(plant.sunlightRequirement),
                          Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getPlantIcon(String plantName) {
    final name = plantName.toLowerCase();
    if (name.contains('snake') || name.contains('aloe')) {
      return Icons.grass;
    } else if (name.contains('lily') || name.contains('flower')) {
      return Icons.local_florist;
    } else if (name.contains('pothos') || name.contains('ivy')) {
      return Icons.forest;
    } else {
      return Icons.eco;
    }
  }

  String _getWateringShort(String frequency) {
    if (frequency.toLowerCase().contains('week')) {
      return 'Weekly';
    } else if (frequency.toLowerCase().contains('2-3')) {
      return '2-3 wks';
    } else if (frequency.toLowerCase().contains('3')) {
      return '3 wks';
    } else {
      return 'Regular';
    }
  }

  String _getSunlightShort(String sunlight) {
    final lower = sunlight.toLowerCase();
    if (lower.contains('low')) {
      return 'Low';
    } else if (lower.contains('bright')) {
      return 'Bright';
    } else if (lower.contains('medium')) {
      return 'Medium';
    } else {
      return 'Indirect';
    }
  }

  Widget _buildCareChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
