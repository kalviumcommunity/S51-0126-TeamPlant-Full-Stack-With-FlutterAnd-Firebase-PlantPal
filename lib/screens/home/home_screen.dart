import 'package:flutter/material.dart';
import '../../widgets/plant_card.dart';
import '../../constants/app_colors.dart';
import '../profile/profile_screen.dart';
import '../plant_detail/plant_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Sample plant data (will be replaced with Firestore data)
  static const List<Map<String, String>> _samplePlants = [
    {
      'name': 'Snake Plant',
      'scientificName': 'Sansevieria trifasciata',
      'wateringFrequency': '2-3 weeks',
      'sunlight': 'Low-Bright',
      'description': 'A hardy, low-maintenance succulent with striking upright leaves.',
    },
    {
      'name': 'Pothos',
      'scientificName': 'Epipremnum aureum',
      'wateringFrequency': 'Weekly',
      'sunlight': 'Low-Bright',
      'description': 'A popular trailing vine with heart-shaped leaves.',
    },
    {
      'name': 'Spider Plant',
      'scientificName': 'Chlorophytum comosum',
      'wateringFrequency': 'Twice/week',
      'sunlight': 'Bright',
      'description': 'A resilient plant with arching leaves and baby plantlets.',
    },
    {
      'name': 'Peace Lily',
      'scientificName': 'Spathiphyllum',
      'wateringFrequency': 'Weekly',
      'sunlight': 'Low-Medium',
      'description': 'Elegant plant with glossy leaves and white flowers.',
    },
    {
      'name': 'Aloe Vera',
      'scientificName': 'Aloe barbadensis',
      'wateringFrequency': '3 weeks',
      'sunlight': 'Bright',
      'description': 'Medicinal succulent with thick, fleshy leaves.',
    },
    {
      'name': 'Rubber Plant',
      'scientificName': 'Ficus elastica',
      'wateringFrequency': '1-2 weeks',
      'sunlight': 'Medium-Bright',
      'description': 'Bold plant with large, glossy dark green leaves.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Plants'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search coming soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: _samplePlants.isEmpty ? _buildEmptyState() : _buildPlantGrid(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add plant feature coming soon!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.yard,
              size: 100,
              color: Colors.green[300],
            ),
            const SizedBox(height: 24),
            const Text(
              'No plants yet!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Tap the + button to add your first plant.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_samplePlants.length} Plants',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _samplePlants.length,
              itemBuilder: (context, index) {
                final plant = _samplePlants[index];
                return PlantCard(
                  name: plant['name']!,
                  scientificName: plant['scientificName']!,
                  wateringFrequency: plant['wateringFrequency']!,
                  sunlight: plant['sunlight']!,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PlantDetailScreen(
                          plantName: plant['name']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
