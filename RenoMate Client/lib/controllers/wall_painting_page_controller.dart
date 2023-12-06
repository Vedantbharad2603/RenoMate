import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:renomateclient/models/wall_painting_model.dart';
import 'package:renomateclient/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WallPaintingPageController extends GetxController {
  var tillDate = DateTime.now().obs;

  Rx<XFile> pickedImage = XFile.fromData(Uint8List(0)).obs;
  Rx<XFile> referenceImage = XFile.fromData(Uint8List(0)).obs;
  // XFile pickedImage = XFile.fromData(Uint8List(0));
  // XFile referenceImage = XFile.fromData(Uint8List(0));

  TextEditingController informationController = TextEditingController();
  TextEditingController budgetController = TextEditingController();

  void showDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    ).then((value) {
      if (value != null) {
        tillDate.value = value;
      }
    });
  }

  final types = [
    'Not Selected',
    'Enamel paint',
    'Satin and Flat Paints',
    'Matte Finish',
    'Textured Paint',
  ];

  var selectedType = 'Not Selected'.obs;

  late String userLongitude;
  late String userlatitude;

  void getusercuttentlocation() async {
    //check location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("permission not given");
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      userLongitude = currentPosition.longitude.toString();
      userlatitude = currentPosition.latitude.toString();
    }
  }

  // void showData(BuildContext context) {
  //   print("save clicked sdsd");
  // WallPaintingModel painting = WallPaintingModel(
  //   tillDate: tillDate.value,
  //   selectedType: selectedType.value,
  //   imagePath: pickedImage.value.path,
  //   referenceImagePath: referenceImage.value.path,
  //   information: informationController.text,
  //   budget: budgetController.text,
  //   userLatitude: double.parse(userlatitude),
  //   userLongitude: double.parse(userLongitude),
  // );

  // Now you have the download URLs of the uploaded images
  // Use these URLs to store in your Firestore document or wherever needed.

  // WallPaintingModel painting = WallPaintingModel(
  //   tillDate: tillDate.value,
  //   selectedType: selectedType.value,
  //   imagePath: wallImagePath,
  //   referenceImagePath: referenceImagePath,
  //   information: informationController.text,
  //   userLatitude: double.parse(userlatitude),
  //   userLongitude: double.parse(userLongitude),
  // );

  // // Save the data to Firebase (if needed)
  // FirebaseService().saveDataToFirebase(painting, selectedType,
  //     pickedImage!.path, referenceImage?.path);

  // Show the information dialog
  // _showInfoDialog(context, painting);

  // }

  Future<String> uploadImageToFirebase(
      XFile imageFile, String folderName) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(folderName)
        .child(DateTime.now().millisecondsSinceEpoch.toString() +
            imageFile.name.toString());
    await ref.putFile(File(imageFile.path));
    return await ref.getDownloadURL();
  }

  Future<void> saveDataWork(BuildContext context) async {
    EasyLoading.show(status: 'Please Wait ...');
    String wallImagePath =
        await uploadImageToFirebase(pickedImage.value, 'wall_paint_images');
    String referenceImagePath = await uploadImageToFirebase(
        referenceImage.value, 'wall_paint_reference_images');

    // Store data in Firestore

    await SharedPreferences.getInstance().then((prefs) {
      CollectionReference wallPaintings =
          FirebaseFirestore.instance.collection('works/works/wall_paintings');
      CollectionReference userWork = FirebaseFirestore.instance
          .collection('client/${prefs.getString("phoneNumber")}/mywork');

      String docId = "";

      wallPaintings
          .add({
            'tillDate': tillDate.value,
            'selectedType': selectedType.value,
            'imagePath': wallImagePath,
            'referenceImagePath': referenceImagePath,
            'information': informationController.text,
            'budget': budgetController.text,
            'userLatitude': double.parse(userlatitude),
            'userLongitude': double.parse(userLongitude),
            'user': prefs.getString("phoneNumber")
          })
          .then((value) => docId = value.id)
          .whenComplete(() {
            userWork.add({
              'workID': (DateTime.now().millisecondsSinceEpoch % 100000000).toString(),
              "isdone": false,
              "workType": "Wall Painting",
              "time":
                  "${DateFormat('dd/MM/yyyy').format(DateTime.now())} to ${DateFormat('dd/MM/yyyy').format(tillDate.value)}",
              "amount": budgetController.text,
              'redirectPath': 'wall_paintings/$docId'
            });
            Get.back();
          });
      EasyLoading.dismiss();
    });

    void _showInfoDialog(BuildContext context, WallPaintingModel painting) {
      // print('Till Date: ${DateFormat('dd/MM/yyyy').format(painting.tillDate)}');
      // print('Paint Type: ${painting.selectedType}');
      // print('Image Path: ${painting.imagePath}');
      // print('Reference Image Path: ${painting.referenceImagePath ?? 'N/A'}');
      // print('Information: ${painting.information}');
      // print('User Latitude: ${painting.userLatitude}');
      // print('User Longitude: ${painting.userLongitude}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Worker Information'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Till Date: ${DateFormat('dd/MM/yyyy').format(painting.tillDate)}'),
                Text('Paint Type: ${painting.selectedType}'),
                Text('Image Path: ${painting.imagePath}'),
                Text(
                    'Reference Image Path: ${painting.referenceImagePath ?? 'N/A'}'),
                Text('Information: ${painting.information}'),
                Text('User Latitude: ${painting.userLatitude}'),
                Text('User Longitude: ${painting.userLongitude}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
