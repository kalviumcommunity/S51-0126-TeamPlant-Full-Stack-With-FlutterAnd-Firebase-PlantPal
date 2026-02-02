import 'package:flutter/material.dart';
import '../../widgets/plant_card.dart';
import '../../widgets/plant_filter_sheet.dart';
import '../../constants/app_colors.dart';
import '../../models/plant_model.dart';
import '../../services/firestore_service.dart';
import '../profile/profile_screen.dart';
import '../plant_detail/plant_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  String _searchQuery = '';
  bool _isGridView = true;
  PlantFilters _activeFilters = PlantFilters.empty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Plants'),
        automaticallyImplyLeading: false,
        actions: [
          // Filter button with badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: _showFilterSheet,
                tooltip: 'Filter plants',
              ),
              if (_activeFilters.hasActiveFilters)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_activeFilters.activeFilterCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
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
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search plants...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Active filter chips
          if (_activeFilters.hasActiveFilters)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Active Filters:',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _activeFilters = PlantFilters.empty;
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Clear all',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      ..._activeFilters.sunlightLevels.map((s) => Chip(
                            label: Text(s, style: const TextStyle(fontSize: 11)),
                            deleteIcon: const Icon(Icons.close, size: 14),
                            onDeleted: () {
                              setState(() {
                                final updated = Set<String>.from(
                                    _activeFilters.sunlightLevels)
                                  ..remove(s);
                                _activeFilters = _activeFilters.copyWith(
                                    sunlightLevels: updated);
                              });
                            },
                            backgroundColor: Colors.orange[50],
                            side: BorderSide(color: Colors.orange[200]!),
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          )),
                      ..._activeFilters.wateringFrequencies.map((w) => Chip(
                            label: Text(w, style: const TextStyle(fontSize: 11)),
                            deleteIcon: const Icon(Icons.close, size: 14),
                            onDeleted: () {
                              setState(() {
                                final updated = Set<String>.from(
                                    _activeFilters.wateringFrequencies)
                                  ..remove(w);
                                _activeFilters = _activeFilters.copyWith(
                                    wateringFrequencies: updated);
                              });
                            },
                            backgroundColor: Colors.blue[50],
                            side: BorderSide(color: Colors.blue[200]!),
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          )),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          // Plant List
          Expanded(
            child: StreamBuilder<List<PlantModel>>(
              stream: _firestoreService.streamAllPlants(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return _buildErrorState(snapshot.error.toString());
                }

                final plants = snapshot.data ?? [];

                if (plants.isEmpty) {
                  return _buildEmptyState();
                }

                // Apply all filters (search + sunlight + watering)
                final filteredPlants = _applyFilters(plants);

                if (filteredPlants.isEmpty) {
                  return _buildNoResultsState();
                }

                return _isGridView
                    ? _buildGridView(filteredPlants)
                    : _buildListView(filteredPlants);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _seedSampleData,
        icon: const Icon(Icons.add),
        label: const Text('Add Plants'),
      ),
    );
  }

  Widget _buildGridView(List<PlantModel> plants) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: plants.length,
      itemBuilder: (context, index) {
        final plant = plants[index];
        return PlantCard(
          plant: plant,
          onTap: () => _navigateToDetail(plant),
        );
      },
    );
  }

  Widget _buildListView(List<PlantModel> plants) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: plants.length,
      itemBuilder: (context, index) {
        final plant = plants[index];
        return Card(
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
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _navigateToDetail(plant),
          ),
        );
      },
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
              'No Plants Yet!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Tap the button below to add sample plants to your collection.',
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

  Widget _buildNoResultsState() {
    final hasFilters = _activeFilters.hasActiveFilters;
    final hasSearch = _searchQuery.isNotEmpty;

    String message;
    if (hasFilters && hasSearch) {
      message = 'Try adjusting your search or filters';
    } else if (hasFilters) {
      message = 'Try adjusting your filters';
    } else {
      message = 'Try a different search term';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          const Text(
            'No plants found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(color: AppColors.textSecondary),
          ),
          if (hasFilters) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _activeFilters = PlantFilters.empty;
                });
              },
              icon: const Icon(Icons.filter_list_off),
              label: const Text('Clear Filters'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => setState(() {}),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(PlantModel plant) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlantDetailScreen(plant: plant),
      ),
    );
  }

  void _showFilterSheet() {
    PlantFilterSheet.show(
      context: context,
      currentFilters: _activeFilters,
      onApply: (filters) {
        setState(() {
          _activeFilters = filters;
        });
      },
    );
  }

  /// Apply all filters (search + sunlight + watering) to the plant list
  List<PlantModel> _applyFilters(List<PlantModel> plants) {
    var filtered = plants;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((plant) {
        return plant.name.toLowerCase().contains(query) ||
            plant.scientificName.toLowerCase().contains(query);
      }).toList();
    }

    // Apply sunlight filter
    if (_activeFilters.sunlightLevels.isNotEmpty) {
      filtered = filtered.where((plant) {
        final sunlight = plant.sunlightRequirement.toLowerCase();
        return _activeFilters.sunlightLevels.any(
          (level) => sunlight.contains(level.toLowerCase()),
        );
      }).toList();
    }

    // Apply watering filter
    if (_activeFilters.wateringFrequencies.isNotEmpty) {
      filtered = filtered.where((plant) {
        final watering = plant.wateringFrequency.toLowerCase();
        return _activeFilters.wateringFrequencies.any(
          (freq) => watering.contains(freq.toLowerCase()),
        );
      }).toList();
    }

    return filtered;
  }

  Future<void> _seedSampleData() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Adding sample plants...'),
            ],
          ),
        ),
      );

      await _firestoreService.seedPlantData();

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sample plants added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add plants: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
