import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/plant_model.dart';
import '../../services/auth_service.dart';
import '../../widgets/plant_card.dart';
import '../plant_detail/plant_detail_screen.dart';
import '../profile/profile_screen.dart';

class MyCollectionScreen extends StatefulWidget {
  const MyCollectionScreen({super.key});

  @override
  State<MyCollectionScreen> createState() => _MyCollectionScreenState();
}

class _MyCollectionScreenState extends State<MyCollectionScreen> {
  final AuthService _authService = AuthService();
  bool _isGridView = true;

  // Placeholder for saved plants - will be connected to Firestore in PR #17
  final List<PlantModel> _savedPlants = [];

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    final displayName = user?.displayName ?? 'Plant Lover';

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collection'),
        automaticallyImplyLeading: false,
        actions: [
          if (_savedPlants.isNotEmpty)
            IconButton(
              icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
              onPressed: () {
                setState(() {
                  _isGridView = !_isGridView;
                });
              },
              tooltip: _isGridView ? 'List View' : 'Grid View',
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
      body: _savedPlants.isEmpty
          ? _buildEmptyState(displayName)
          : _buildCollectionView(),
    );
  }

  Widget _buildEmptyState(String displayName) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.green[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bookmark_outline,
                size: 60,
                color: Colors.green[300],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Welcome, $displayName!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Your plant collection is empty.',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Browse plants and tap the bookmark icon to add them to your collection.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green[100]!),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: Colors.green[600]),
                      const SizedBox(width: 8),
                      const Text(
                        'Quick Tip',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Saving plants to your collection helps you track their care schedules and get personalized reminders.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Stats preview
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(Icons.eco, '0', 'Plants'),
                _buildStatItem(Icons.water_drop, '0', 'To Water'),
                _buildStatItem(Icons.wb_sunny, '0', 'Need Sun'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.grey[400], size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildCollectionView() {
    return Column(
      children: [
        // Collection Stats Header
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.green[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCollectionStat(
                Icons.eco,
                _savedPlants.length.toString(),
                'Total Plants',
              ),
              _buildCollectionStat(
                Icons.water_drop,
                '0',
                'Need Water',
              ),
              _buildCollectionStat(
                Icons.check_circle,
                '0',
                'Healthy',
              ),
            ],
          ),
        ),
        // Plant Grid/List
        Expanded(
          child: _isGridView
              ? _buildGridView()
              : _buildListView(),
        ),
      ],
    );
  }

  Widget _buildCollectionStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _savedPlants.length,
      itemBuilder: (context, index) {
        final plant = _savedPlants[index];
        return PlantCard(
          plant: plant,
          onTap: () => _navigateToDetail(plant),
        );
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _savedPlants.length,
      itemBuilder: (context, index) {
        final plant = _savedPlants[index];
        return Dismissible(
          key: Key(plant.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: AppColors.error,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          confirmDismiss: (direction) async {
            return await _showRemoveConfirmation(plant);
          },
          onDismissed: (direction) {
            _removePlant(plant);
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.eco,
                  color: Colors.green[700],
                  size: 28,
                ),
              ),
              title: Text(
                plant.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                plant.scientificName,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.bookmark, color: Colors.green),
                onPressed: () => _showRemoveConfirmation(plant),
              ),
              onTap: () => _navigateToDetail(plant),
            ),
          ),
        );
      },
    );
  }

  void _navigateToDetail(PlantModel plant) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlantDetailScreen(plant: plant),
      ),
    );
  }

  Future<bool> _showRemoveConfirmation(PlantModel plant) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Plant'),
        content: Text(
          'Remove ${plant.name} from your collection?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Remove',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _removePlant(PlantModel plant) {
    setState(() {
      _savedPlants.removeWhere((p) => p.id == plant.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${plant.name} removed from collection'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _savedPlants.add(plant);
            });
          },
        ),
      ),
    );
  }
}
