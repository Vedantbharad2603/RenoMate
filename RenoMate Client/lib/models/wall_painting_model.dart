import 'package:cloud_firestore/cloud_firestore.dart';

class WallPaintingModel {
  late DateTime tillDate;
  late String selectedType;
  late String imagePath;
  String? referenceImagePath; // Updated to allow null
  late String information;
  late String budget;
  double userLatitude;
  double userLongitude;

  WallPaintingModel({
    required this.tillDate,
    required this.selectedType,
    required this.imagePath,
    this.referenceImagePath,
    required this.information,
    required this.budget,
    required this.userLatitude,
    required this.userLongitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'tillDate': Timestamp.fromDate(tillDate),
      'selectedType': selectedType,
      'imagePath': imagePath,
      'referenceImagePath': referenceImagePath,
      'information': information,
      'budget': budget,
      'userLatitude': userLatitude,
      'userLongitude': userLongitude,
    };
  }

  factory WallPaintingModel.fromMap(Map<String, dynamic> map) {
    return WallPaintingModel(
      tillDate: (map['tillDate'] as Timestamp).toDate(),
      selectedType: map['selectedType'],
      imagePath: map['imagePath'],
      referenceImagePath: map['referenceImagePath'],
      information: map['information'],
      budget: map['budget'],
      userLatitude: map['userLatitude'],
      userLongitude: map['userLongitude'],
    );
  }
}
