import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/plant_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  CollectionReference get _usersCollection => _firestore.collection('users');
  CollectionReference get _plantsCollection => _firestore.collection('plants');

  // ==================== USER OPERATIONS ====================

  /// Create or update user document in Firestore
  Future<void> createUser(UserModel user) async {
    try {
      await _usersCollection.doc(user.uid).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  /// Get user document by UID
  Future<UserModel?> getUser(String uid) async {
    try {
      final doc = await _usersCollection.doc(uid).get();
      if (doc.exists) {
        return UserModel.fromDocument(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  /// Update user document
  Future<void> updateUser(String uid, Map<String, dynamic> updates) async {
    try {
      await _usersCollection.doc(uid).update(updates);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  /// Update user's last login timestamp
  Future<void> updateLastLogin(String uid) async {
    try {
      await _usersCollection.doc(uid).update({
        'lastLogin': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to update last login: $e');
    }
  }

  /// Delete user document
  Future<void> deleteUser(String uid) async {
    try {
      await _usersCollection.doc(uid).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  /// Stream user data in real-time
  Stream<UserModel?> streamUser(String uid) {
    return _usersCollection.doc(uid).snapshots().map((doc) {
      if (doc.exists) {
        return UserModel.fromDocument(doc);
      }
      return null;
    });
  }

  // ==================== PLANT OPERATIONS ====================

  /// Get all plants
  Future<List<PlantModel>> getAllPlants() async {
    try {
      final snapshot = await _plantsCollection
          .orderBy('name', descending: false)
          .get();
      return snapshot.docs
          .map((doc) => PlantModel.fromDocument(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get plants: $e');
    }
  }

  /// Get plant by ID
  Future<PlantModel?> getPlant(String plantId) async {
    try {
      final doc = await _plantsCollection.doc(plantId).get();
      if (doc.exists) {
        return PlantModel.fromDocument(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get plant: $e');
    }
  }

  /// Search plants by name
  Future<List<PlantModel>> searchPlantsByName(String query) async {
    try {
      final snapshot = await _plantsCollection
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: '$query\uf8ff')
          .get();
      return snapshot.docs
          .map((doc) => PlantModel.fromDocument(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to search plants: $e');
    }
  }

  /// Stream all plants in real-time
  Stream<List<PlantModel>> streamAllPlants() {
    return _plantsCollection
        .orderBy('name', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PlantModel.fromDocument(doc))
          .toList();
    });
  }

  /// Stream plant by ID in real-time
  Stream<PlantModel?> streamPlant(String plantId) {
    return _plantsCollection.doc(plantId).snapshots().map((doc) {
      if (doc.exists) {
        return PlantModel.fromDocument(doc);
      }
      return null;
    });
  }

  // ==================== ADMIN OPERATIONS (for seeding data) ====================

  /// Add a new plant (admin only)
  Future<String> addPlant(PlantModel plant) async {
    try {
      final docRef = await _plantsCollection.add(plant.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add plant: $e');
    }
  }

  /// Update plant (admin only)
  Future<void> updatePlant(String plantId, Map<String, dynamic> updates) async {
    try {
      await _plantsCollection.doc(plantId).update(updates);
    } catch (e) {
      throw Exception('Failed to update plant: $e');
    }
  }

  /// Delete plant (admin only)
  Future<void> deletePlant(String plantId) async {
    try {
      await _plantsCollection.doc(plantId).delete();
    } catch (e) {
      throw Exception('Failed to delete plant: $e');
    }
  }

  /// Seed initial plant data (for testing/demo purposes)
  Future<void> seedPlantData() async {
    try {
      final samplePlants = [
        PlantModel(
          id: '',
          name: 'Snake Plant',
          scientificName: 'Sansevieria trifasciata',
          description: 'A hardy, low-maintenance succulent with striking upright leaves. Perfect for beginners and thrives on neglect.',
          wateringFrequency: 'Every 2-3 weeks',
          sunlightRequirement: 'Low to bright indirect light',
          temperatureRange: '15-29°C (60-85°F)',
          soilType: 'Well-draining cactus or succulent mix',
          maintenanceTips: [
            'Water when soil is completely dry',
            'Avoid overwatering to prevent root rot',
            'Wipe leaves occasionally to remove dust',
            'Tolerates low light but grows faster in bright light',
          ],
          imageUrl: null,
          createdAt: DateTime.now(),
        ),
        PlantModel(
          id: '',
          name: 'Pothos',
          scientificName: 'Epipremnum aureum',
          description: 'A popular trailing vine with heart-shaped leaves. Known for its air-purifying qualities and easy care.',
          wateringFrequency: 'Once a week',
          sunlightRequirement: 'Low to bright indirect light',
          temperatureRange: '18-29°C (65-85°F)',
          soilType: 'Well-draining potting soil',
          maintenanceTips: [
            'Allow top 2 inches of soil to dry between waterings',
            'Trim yellow leaves to encourage new growth',
            'Can be propagated easily in water',
            'Variegated varieties need more light',
          ],
          imageUrl: null,
          createdAt: DateTime.now(),
        ),
        PlantModel(
          id: '',
          name: 'Spider Plant',
          scientificName: 'Chlorophytum comosum',
          description: 'A resilient plant with arching leaves and baby plantlets. Excellent for hanging baskets and air purification.',
          wateringFrequency: 'Twice a week',
          sunlightRequirement: 'Bright indirect light',
          temperatureRange: '18-32°C (65-90°F)',
          soilType: 'Well-draining potting mix',
          maintenanceTips: [
            'Keep soil lightly moist but not soggy',
            'Brown leaf tips indicate fluoride in water - use filtered water',
            'Propagate baby plantlets in water or soil',
            'Feed monthly during growing season',
          ],
          imageUrl: null,
          createdAt: DateTime.now(),
        ),
        PlantModel(
          id: '',
          name: 'Peace Lily',
          scientificName: 'Spathiphyllum',
          description: 'Elegant plant with glossy leaves and white flowers. Known for its air-purifying abilities and low-light tolerance.',
          wateringFrequency: 'Once a week',
          sunlightRequirement: 'Low to medium indirect light',
          temperatureRange: '18-26°C (65-80°F)',
          soilType: 'Rich, well-draining potting soil',
          maintenanceTips: [
            'Water when leaves start to droop slightly',
            'Mist leaves regularly for humidity',
            'Remove spent flowers and yellow leaves',
            'Keep away from pets - toxic if ingested',
          ],
          imageUrl: null,
          createdAt: DateTime.now(),
        ),
        PlantModel(
          id: '',
          name: 'Aloe Vera',
          scientificName: 'Aloe barbadensis miller',
          description: 'Medicinal succulent with thick, fleshy leaves containing healing gel. Extremely drought-tolerant.',
          wateringFrequency: 'Every 3 weeks',
          sunlightRequirement: 'Bright indirect light',
          temperatureRange: '13-27°C (55-80°F)',
          soilType: 'Cactus or succulent mix',
          maintenanceTips: [
            'Water deeply but infrequently',
            'Soil must dry completely between waterings',
            'Provide 6-8 hours of indirect sunlight',
            'Harvest outer leaves for gel as needed',
          ],
          imageUrl: null,
          createdAt: DateTime.now(),
        ),
      ];

      for (final plant in samplePlants) {
        await addPlant(plant);
      }
    } catch (e) {
      throw Exception('Failed to seed plant data: $e');
    }
  }

  // ==================== USER PLANT COLLECTION OPERATIONS ====================

  /// Get user's saved plants subcollection reference
  CollectionReference _userPlantsCollection(String uid) {
    return _usersCollection.doc(uid).collection('savedPlants');
  }

  /// Add a plant to user's collection
  Future<void> addPlantToCollection(String uid, String plantId) async {
    try {
      await _userPlantsCollection(uid).doc(plantId).set({
        'plantId': plantId,
        'savedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to add plant to collection: $e');
    }
  }

  /// Remove a plant from user's collection
  Future<void> removePlantFromCollection(String uid, String plantId) async {
    try {
      await _userPlantsCollection(uid).doc(plantId).delete();
    } catch (e) {
      throw Exception('Failed to remove plant from collection: $e');
    }
  }

  /// Check if a plant is in user's collection
  Future<bool> isPlantInCollection(String uid, String plantId) async {
    try {
      final doc = await _userPlantsCollection(uid).doc(plantId).get();
      return doc.exists;
    } catch (e) {
      throw Exception('Failed to check plant in collection: $e');
    }
  }

  /// Get user's saved plant IDs
  Future<List<String>> getUserSavedPlantIds(String uid) async {
    try {
      final snapshot = await _userPlantsCollection(uid)
          .orderBy('savedAt', descending: true)
          .get();
      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      throw Exception('Failed to get saved plant IDs: $e');
    }
  }

  /// Get user's saved plants with full plant data
  Future<List<PlantModel>> getUserSavedPlants(String uid) async {
    try {
      final plantIds = await getUserSavedPlantIds(uid);
      final plants = <PlantModel>[];

      for (final plantId in plantIds) {
        final plant = await getPlant(plantId);
        if (plant != null) {
          plants.add(plant);
        }
      }

      return plants;
    } catch (e) {
      throw Exception('Failed to get saved plants: $e');
    }
  }

  /// Stream user's saved plant IDs in real-time
  Stream<List<String>> streamUserSavedPlantIds(String uid) {
    return _userPlantsCollection(uid)
        .orderBy('savedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  /// Stream user's saved plants with full data in real-time
  Stream<List<PlantModel>> streamUserSavedPlants(String uid) {
    return _userPlantsCollection(uid)
        .orderBy('savedAt', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final plants = <PlantModel>[];
      for (final doc in snapshot.docs) {
        final plant = await getPlant(doc.id);
        if (plant != null) {
          plants.add(plant);
        }
      }
      return plants;
    });
  }

  /// Get count of user's saved plants
  Future<int> getUserSavedPlantsCount(String uid) async {
    try {
      final snapshot = await _userPlantsCollection(uid).get();
      return snapshot.docs.length;
    } catch (e) {
      throw Exception('Failed to get saved plants count: $e');
    }
  }

  /// Toggle plant in user's collection (add if not present, remove if present)
  Future<bool> togglePlantInCollection(String uid, String plantId) async {
    try {
      final isInCollection = await isPlantInCollection(uid, plantId);
      if (isInCollection) {
        await removePlantFromCollection(uid, plantId);
        return false; // Plant was removed
      } else {
        await addPlantToCollection(uid, plantId);
        return true; // Plant was added
      }
    } catch (e) {
      throw Exception('Failed to toggle plant in collection: $e');
    }
  }

  // ==================== BATCH OPERATIONS ====================

  /// Batch write operations for efficiency
  Future<void> batchCreateUsers(List<UserModel> users) async {
    try {
      final batch = _firestore.batch();
      for (final user in users) {
        final docRef = _usersCollection.doc(user.uid);
        batch.set(docRef, user.toMap());
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to batch create users: $e');
    }
  }

  /// Batch delete operations
  Future<void> batchDeletePlants(List<String> plantIds) async {
    try {
      final batch = _firestore.batch();
      for (final id in plantIds) {
        final docRef = _plantsCollection.doc(id);
        batch.delete(docRef);
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to batch delete plants: $e');
    }
  }
}
