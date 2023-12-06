import 'package:cloud_firestore/cloud_firestore.dart';

class WallPaintingModel {
  late DateTime tillDate;
  late String selectedType;
  late String imagePath;
  String? referenceImagePath; // Updated to allow null
  late String information;
  double userLatitude;
  double userLongitude;

  WallPaintingModel({
    required this.tillDate,
    required this.selectedType,
    required this.imagePath,
    this.referenceImagePath,
    required this.information,
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
      userLatitude: map['userLatitude'],
      userLongitude: map['userLongitude'],
    );
  }
}

class FirebaseService {
  final CollectionReference wallPaintingsCollection =
      FirebaseFirestore.instance.collection('wall_paintings');

  Future<void> saveDataToFirebase(WallPaintingModel painting,
      String selectedType, String path, String? refpath) async {
    try {
      await wallPaintingsCollection.add(painting.toMap());
    } catch (e) {
      print('Error saving data to Firebase: $e');
      // Handle error as needed
    }
  }
}
