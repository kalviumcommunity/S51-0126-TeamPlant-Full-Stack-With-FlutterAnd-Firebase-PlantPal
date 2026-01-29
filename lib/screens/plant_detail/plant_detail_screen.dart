import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class PlantDetailScreen extends StatelessWidget {
  final String name;
  final String scientificName;
  final String description;
  final String wateringFrequency;
  final String sunlightRequirement;
  final String temperatureRange;
  final String soilType;
  final List<String> maintenanceTips;

  const PlantDetailScreen({
    super.key,
    required this.name,
    required this.scientificName,
    required this.description,
    required this.wateringFrequency,
    required this.sunlightRequirement,
    required this.temperatureRange,
    required this.soilType,
    required this.maintenanceTips,
  });

  // Factory constructor with sample data for testing
  factory PlantDetailScreen.sample({String plantName = 'Snake Plant'}) {
    final sampleData = _getSamplePlantData(plantName);
    return PlantDetailScreen(
      name: sampleData['name']!,
      scientificName: sampleData['scientificName']!,
      description: sampleData['description']!,
      wateringFrequency: sampleData['wateringFrequency']!,
      sunlightRequirement: sampleData['sunlightRequirement']!,
      temperatureRange: sampleData['temperatureRange']!,
      soilType: sampleData['soilType']!,
      maintenanceTips: (sampleData['maintenanceTips'] as String).split('|'),
    );
  }

  static Map<String, String> _getSamplePlantData(String plantName) {
    final plants = {
      'Snake Plant': {
        'name': 'Snake Plant',
        'scientificName': 'Sansevieria trifasciata',
        'description': 'A hardy, low-maintenance succulent with striking upright leaves. Perfect for beginners and thrives on neglect. Known for its air-purifying qualities.',
        'wateringFrequency': 'Every 2-3 weeks',
        'sunlightRequirement': 'Low to bright indirect light',
        'temperatureRange': '15-29°C (60-85°F)',
        'soilType': 'Well-draining cactus or succulent mix',
        'maintenanceTips': 'Water when soil is completely dry|Avoid overwatering to prevent root rot|Wipe leaves occasionally to remove dust|Tolerates low light but grows faster in bright light',
      },
      'Pothos': {
        'name': 'Pothos',
        'scientificName': 'Epipremnum aureum',
        'description': 'A popular trailing vine with heart-shaped leaves. Known for its air-purifying qualities and easy care. Great for hanging baskets.',
        'wateringFrequency': 'Once a week',
        'sunlightRequirement': 'Low to bright indirect light',
        'temperatureRange': '18-29°C (65-85°F)',
        'soilType': 'Well-draining potting soil',
        'maintenanceTips': 'Allow top 2 inches of soil to dry between waterings|Trim yellow leaves to encourage new growth|Can be propagated easily in water|Variegated varieties need more light',
      },
    };

    return plants[plantName] ?? plants['Snake Plant']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with plant image
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Colors.black45,
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
                      Colors.green[300]!,
                      Colors.green[600]!,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.local_florist,
                    size: 80,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Scientific name
                  Text(
                    scientificName,
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Quick care info chips
                  _buildQuickCareSection(),
                  const SizedBox(height: 24),

                  // Care details cards
                  _buildCareDetailCard(
                    icon: Icons.water_drop,
                    title: 'Watering',
                    content: wateringFrequency,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  _buildCareDetailCard(
                    icon: Icons.wb_sunny,
                    title: 'Sunlight',
                    content: sunlightRequirement,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  _buildCareDetailCard(
                    icon: Icons.thermostat,
                    title: 'Temperature',
                    content: temperatureRange,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 12),
                  _buildCareDetailCard(
                    icon: Icons.grass,
                    title: 'Soil Type',
                    content: soilType,
                    color: Colors.brown,
                  ),
                  const SizedBox(height: 24),

                  // Maintenance tips
                  _buildMaintenanceTipsSection(),
                  const SizedBox(height: 24),

                  // Action button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$name added to your plants!'),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add to My Plants'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCareSection() {
    return Row(
      children: [
        _buildQuickCareChip(Icons.water_drop, 'Water', Colors.blue),
        const SizedBox(width: 8),
        _buildQuickCareChip(Icons.wb_sunny, 'Light', Colors.orange),
        const SizedBox(width: 8),
        _buildQuickCareChip(Icons.eco, 'Easy Care', Colors.green),
      ],
    );
  }

  Widget _buildQuickCareChip(IconData icon, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withAlpha(26),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withAlpha(77)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCareDetailCard({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withAlpha(26),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceTipsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tips_and_updates, color: AppColors.primary),
            const SizedBox(width: 8),
            const Text(
              'Care Tips',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
