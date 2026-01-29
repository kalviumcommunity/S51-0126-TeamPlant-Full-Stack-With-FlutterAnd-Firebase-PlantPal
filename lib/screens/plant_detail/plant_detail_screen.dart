import 'package:flutter/material.dart';
import '../../models/plant_model.dart';
import '../../constants/app_colors.dart';

class PlantDetailScreen extends StatelessWidget {
  final PlantModel plant;

  const PlantDetailScreen({
    super.key,
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsible App Bar with Plant Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                plant.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.green[400]!,
                      Colors.green[700]!,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getPlantIcon(),
                    size: 80,
                    color: Colors.white.withAlpha(180),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share feature coming soon!')),
                  );
                },
              ),
            ],
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Scientific Name
                  Text(
                    plant.scientificName,
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    plant.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Care Details Section
                  const Text(
                    'Care Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Care Cards Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildCareCard(
                        icon: Icons.water_drop,
                        title: 'Watering',
                        value: plant.wateringFrequency,
                        color: Colors.blue,
                      ),
                      _buildCareCard(
                        icon: Icons.wb_sunny,
                        title: 'Sunlight',
                        value: plant.sunlightRequirement,
                        color: Colors.orange,
                      ),
                      _buildCareCard(
                        icon: Icons.thermostat,
                        title: 'Temperature',
                        value: plant.temperatureRange,
                        color: Colors.red,
                      ),
                      _buildCareCard(
                        icon: Icons.grass,
                        title: 'Soil Type',
                        value: plant.soilType,
                        color: Colors.brown,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Maintenance Tips Section
                  const Text(
                    'Maintenance Tips',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tips List
                  ...plant.maintenanceTips.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${entry.key + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: const TextStyle(
                                fontSize: 15,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 24),

                  // Add to My Plants Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${plant.name} added to your collection!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      icon: const Icon(Icons.bookmark_add),
                      label: const Text('Add to My Plants'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getPlantIcon() {
    final name = plant.name.toLowerCase();
    if (name.contains('snake') || name.contains('aloe')) {
      return Icons.grass;
    } else if (name.contains('lily') || name.contains('flower')) {
      return Icons.local_florist;
    } else if (name.contains('pothos') || name.contains('ivy')) {
      return Icons.forest;
    } else if (name.contains('spider')) {
      return Icons.spa;
    } else {
      return Icons.eco;
    }
  }

  Widget _buildCareCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...maintenanceTips.map((tip) => _buildTipItem(tip)),
      ],
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
