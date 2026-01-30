import 'package:flutter_test/flutter_test.dart';
import 'package:plantpal/models/plant_model.dart';

void main() {
  // Create a sample plant for testing
  PlantModel createSamplePlant({String name = 'Snake Plant'}) {
    return PlantModel(
      id: 'test-id',
      name: name,
      scientificName: 'Sansevieria trifasciata',
      description: 'A hardy, low-maintenance succulent.',
      wateringFrequency: 'Every 2-3 weeks',
      sunlightRequirement: 'Low to bright indirect light',
      temperatureRange: '15-29°C',
      soilType: 'Well-draining cactus mix',
      maintenanceTips: ['Water when dry', 'Avoid overwatering'],
      createdAt: DateTime.now(),
    );
  }

  group('PlantModel Tests', () {
    test('creates PlantModel with all required fields', () {
      final plant = createSamplePlant();

      expect(plant.id, 'test-id');
      expect(plant.name, 'Snake Plant');
      expect(plant.scientificName, 'Sansevieria trifasciata');
      expect(plant.description, 'A hardy, low-maintenance succulent.');
    });

    test('PlantModel has correct watering frequency', () {
      final plant = createSamplePlant();

      expect(plant.wateringFrequency, 'Every 2-3 weeks');
    });

    test('PlantModel has correct sunlight requirement', () {
      final plant = createSamplePlant();

      expect(plant.sunlightRequirement, 'Low to bright indirect light');
    });

    test('PlantModel has correct temperature range', () {
      final plant = createSamplePlant();

      expect(plant.temperatureRange, '15-29°C');
    });

    test('PlantModel has correct soil type', () {
      final plant = createSamplePlant();

      expect(plant.soilType, 'Well-draining cactus mix');
    });

    test('PlantModel has maintenance tips list', () {
      final plant = createSamplePlant();

      expect(plant.maintenanceTips, isA<List<String>>());
      expect(plant.maintenanceTips.length, 2);
      expect(plant.maintenanceTips.first, 'Water when dry');
    });

    test('PlantModel has createdAt timestamp', () {
      final plant = createSamplePlant();

      expect(plant.createdAt, isA<DateTime>());
    });

    test('PlantModel toMap returns correct data', () {
      final plant = createSamplePlant();
      final map = plant.toMap();

      expect(map['name'], 'Snake Plant');
      expect(map['scientificName'], 'Sansevieria trifasciata');
      expect(map['wateringFrequency'], 'Every 2-3 weeks');
    });

    test('PlantModel copyWith creates new instance with updated values', () {
      final plant = createSamplePlant();
      final updatedPlant = plant.copyWith(name: 'Aloe Vera');

      expect(updatedPlant.name, 'Aloe Vera');
      expect(updatedPlant.scientificName, plant.scientificName);
    });

    test('PlantModel toString contains name', () {
      final plant = createSamplePlant();
      final stringRep = plant.toString();

      expect(stringRep.contains('Snake Plant'), isTrue);
    });

    test('PlantModel equality works correctly', () {
      final plant1 = PlantModel(
        id: 'same-id',
        name: 'Snake Plant',
        scientificName: 'Sansevieria',
        description: 'Test',
        wateringFrequency: 'Weekly',
        sunlightRequirement: 'Bright',
        temperatureRange: '20-25°C',
        soilType: 'Sandy',
        maintenanceTips: [],
        createdAt: DateTime.now(),
      );

      final plant2 = PlantModel(
        id: 'same-id',
        name: 'Snake Plant',
        scientificName: 'Sansevieria',
        description: 'Different description',
        wateringFrequency: 'Different',
        sunlightRequirement: 'Different',
        temperatureRange: '15-30°C',
        soilType: 'Different',
        maintenanceTips: ['Tip'],
        createdAt: DateTime.now(),
      );

      expect(plant1 == plant2, isTrue);
    });

    test('PlantModel imageUrl can be null', () {
      final plant = createSamplePlant();

      expect(plant.imageUrl, isNull);
    });

    test('PlantModel copyWith preserves imageUrl when not specified', () {
      final plantWithImage = PlantModel(
        id: 'test',
        name: 'Test',
        scientificName: 'Test',
        description: 'Test',
        wateringFrequency: 'Weekly',
        sunlightRequirement: 'Bright',
        temperatureRange: '20°C',
        soilType: 'Sandy',
        maintenanceTips: [],
        imageUrl: 'https://example.com/image.jpg',
        createdAt: DateTime.now(),
      );

      final copied = plantWithImage.copyWith(name: 'New Name');

      expect(copied.imageUrl, 'https://example.com/image.jpg');
      expect(copied.name, 'New Name');
    });
  });
}
