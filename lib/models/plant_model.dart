import 'package:cloud_firestore/cloud_firestore.dart';

class PlantModel {
  final String id;
  final String name;
  final String scientificName;
  final String description;
  final String wateringFrequency;
  final String sunlightRequirement;
  final String temperatureRange;
  final String soilType;
  final List<String> maintenanceTips;
  final String? imageUrl;
  final DateTime createdAt;

  PlantModel({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.description,
    required this.wateringFrequency,
    required this.sunlightRequirement,
    required this.temperatureRange,
    required this.soilType,
    required this.maintenanceTips,
    this.imageUrl,
    required this.createdAt,
  });

  // Convert PlantModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'scientificName': scientificName,
      'description': description,
      'wateringFrequency': wateringFrequency,
      'sunlightRequirement': sunlightRequirement,
      'temperatureRange': temperatureRange,
      'soilType': soilType,
      'maintenanceTips': maintenanceTips,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Create PlantModel from Firestore document
  factory PlantModel.fromMap(Map<String, dynamic> map, String documentId) {
    return PlantModel(
      id: documentId,
      name: map['name'] ?? '',
      scientificName: map['scientificName'] ?? '',
      description: map['description'] ?? '',
      wateringFrequency: map['wateringFrequency'] ?? '',
      sunlightRequirement: map['sunlightRequirement'] ?? '',
      temperatureRange: map['temperatureRange'] ?? '',
      soilType: map['soilType'] ?? '',
      maintenanceTips: List<String>.from(map['maintenanceTips'] ?? []),
      imageUrl: map['imageUrl'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // Create PlantModel from Firestore DocumentSnapshot
  factory PlantModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PlantModel.fromMap(data, doc.id);
  }

  // Create a copy of PlantModel with updated fields
  PlantModel copyWith({
    String? id,
    String? name,
    String? scientificName,
    String? description,
    String? wateringFrequency,
    String? sunlightRequirement,
    String? temperatureRange,
    String? soilType,
    List<String>? maintenanceTips,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return PlantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      description: description ?? this.description,
      wateringFrequency: wateringFrequency ?? this.wateringFrequency,
      sunlightRequirement: sunlightRequirement ?? this.sunlightRequirement,
      temperatureRange: temperatureRange ?? this.temperatureRange,
      soilType: soilType ?? this.soilType,
      maintenanceTips: maintenanceTips ?? this.maintenanceTips,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'PlantModel(id: $id, name: $name, scientificName: $scientificName, wateringFrequency: $wateringFrequency)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlantModel &&
        other.id == id &&
        other.name == name &&
        other.scientificName == scientificName;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ scientificName.hashCode;
  }
}
