class PlumbingData {
  final DateTime tillDate;
  final String plumbingType;
  final String plumbingMaterial;
  final String imagePath;
  final String information;
  final String userLongitude;
  final String userLatitude;

  PlumbingData({
    required this.tillDate,
    required this.plumbingType,
    required this.plumbingMaterial,
    required this.imagePath,
    required this.information,
    required this.userLongitude,
    required this.userLatitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'tillDate': tillDate,
      'plumbingType': plumbingType,
      'plumbingMaterial': plumbingMaterial,
      'imagePath': imagePath,
      'information': information,
      'userLongitude': userLongitude,
      'userLatitude': userLatitude,
    };
  }
}
