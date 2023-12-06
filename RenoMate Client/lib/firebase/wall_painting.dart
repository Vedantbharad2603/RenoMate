import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:renomateclient/models/wall_painting_model.dart';

class WallFirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadWallPainting(WallPaintingModel wallPainting) async {
    try {
      // Get the current user's ID
      String userId = _auth.currentUser!.uid;

      // Upload images to Firebase Storage
      String imageFileName =
          'wall_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      String referenceImageFileName =
          'reference_image_${DateTime.now().millisecondsSinceEpoch}.jpg';

      await _storage
          .ref('users/$userId/images/$imageFileName')
          .putFile(File(wallPainting.imagePath));

      // Use null-aware operator to provide a default value if referenceImagePath is null
      await _storage
          .ref('users/$userId/images/$referenceImageFileName')
          .putFile(File(wallPainting.referenceImagePath ?? ''));

      // Get download URLs for the images
      String imageUrl = await _storage
          .ref('users/$userId/images/$imageFileName')
          .getDownloadURL();

      // Use null-aware operator to provide a default value if referenceImagePath is null
      String referenceImageUrl = await _storage
          .ref('users/$userId/images/$referenceImageFileName')
          .getDownloadURL();

      // Create a WallPaintingModel with the download URLs
      WallPaintingModel modelWithUrls = WallPaintingModel(
        tillDate: wallPainting.tillDate,
        selectedType: wallPainting.selectedType,
        imagePath: imageUrl,
        // Provide a default value if referenceImagePath is null
        referenceImagePath: referenceImageUrl ?? '',
        information: wallPainting.information,
        budget: wallPainting.budget,
        userLatitude: wallPainting.userLatitude,
        userLongitude: wallPainting.userLongitude,
      );

      // Upload data to Firestore
      await _firestore
          .collection('wall_paintings')
          .doc(userId)
          .set(modelWithUrls.toMap());
    } catch (e) {
      print('Error uploading data: $e');
    }
  }
}
