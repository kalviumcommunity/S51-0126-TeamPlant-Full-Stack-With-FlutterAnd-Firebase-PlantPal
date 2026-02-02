import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Filter options for plant browsing
class PlantFilters {
  final Set<String> sunlightLevels;
  final Set<String> wateringFrequencies;

  const PlantFilters({
    this.sunlightLevels = const {},
    this.wateringFrequencies = const {},
  });

  bool get hasActiveFilters =>
      sunlightLevels.isNotEmpty || wateringFrequencies.isNotEmpty;

  int get activeFilterCount =>
      sunlightLevels.length + wateringFrequencies.length;

  PlantFilters copyWith({
    Set<String>? sunlightLevels,
    Set<String>? wateringFrequencies,
  }) {
    return PlantFilters(
      sunlightLevels: sunlightLevels ?? this.sunlightLevels,
      wateringFrequencies: wateringFrequencies ?? this.wateringFrequencies,
    );
  }

  static const PlantFilters empty = PlantFilters();
}

/// Bottom sheet widget for filtering plants
class PlantFilterSheet extends StatefulWidget {
  final PlantFilters initialFilters;
  final ValueChanged<PlantFilters> onApply;

  const PlantFilterSheet({
    super.key,
    required this.initialFilters,
    required this.onApply,
  });

  /// Show the filter sheet as a modal bottom sheet
  static Future<void> show({
    required BuildContext context,
    required PlantFilters currentFilters,
    required ValueChanged<PlantFilters> onApply,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => PlantFilterSheet(
        initialFilters: currentFilters,
        onApply: onApply,
      ),
    );
  }

  @override
  State<PlantFilterSheet> createState() => _PlantFilterSheetState();
}

class _PlantFilterSheetState extends State<PlantFilterSheet> {
  late Set<String> _selectedSunlight;
  late Set<String> _selectedWatering;

  // Available filter options
  static const List<String> sunlightOptions = [
    'Low',
    'Medium',
    'Bright',
    'Direct',
  ];

  static const List<String> wateringOptions = [
    'Daily',
    'Twice a week',
    'Weekly',
    'Bi-weekly',
    'Monthly',
  ];

  @override
  void initState() {
    super.initState();
    _selectedSunlight = Set.from(widget.initialFilters.sunlightLevels);
    _selectedWatering = Set.from(widget.initialFilters.wateringFrequencies);
  }

  void _toggleSunlight(String value) {
    setState(() {
      if (_selectedSunlight.contains(value)) {
        _selectedSunlight.remove(value);
      } else {
        _selectedSunlight.add(value);
      }
    });
  }

  void _toggleWatering(String value) {
    setState(() {
      if (_selectedWatering.contains(value)) {
        _selectedWatering.remove(value);
      } else {
        _selectedWatering.add(value);
      }
    });
  }

  void _clearAll() {
    setState(() {
      _selectedSunlight.clear();
      _selectedWatering.clear();
    });
  }

  void _applyFilters() {
    widget.onApply(PlantFilters(
      sunlightLevels: _selectedSunlight,
      wateringFrequencies: _selectedWatering,
    ));
    Navigator.pop(context);
  }

  bool get _hasChanges =>
      _selectedSunlight.isNotEmpty || _selectedWatering.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Plants',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Sunlight section
          _buildSectionHeader(
            icon: Icons.wb_sunny,
            title: 'Sunlight Requirement',
            color: Colors.orange,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: sunlightOptions.map((option) {
              final isSelected = _selectedSunlight.contains(option);
              return FilterChip(
                label: Text(option),
                selected: isSelected,
                onSelected: (_) => _toggleSunlight(option),
                selectedColor: Colors.orange[100],
                checkmarkColor: Colors.orange[700],
                labelStyle: TextStyle(
                  color: isSelected ? Colors.orange[800] : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Watering section
          _buildSectionHeader(
            icon: Icons.water_drop,
            title: 'Watering Frequency',
            color: Colors.blue,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: wateringOptions.map((option) {
              final isSelected = _selectedWatering.contains(option);
              return FilterChip(
                label: Text(option),
                selected: isSelected,
                onSelected: (_) => _toggleWatering(option),
                selectedColor: Colors.blue[100],
                checkmarkColor: Colors.blue[700],
                labelStyle: TextStyle(
                  color: isSelected ? Colors.blue[800] : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _hasChanges ? _clearAll : null,
                  child: const Text('Clear All'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _applyFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    _hasChanges ? 'Apply Filters' : 'Show All Plants',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
