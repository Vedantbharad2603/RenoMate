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
import 'package:renomateclient/models/plumbing_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlumbingPageController extends GetxController {
  var tillDate = DateTime.now().obs;
  Rx<XFile> pickedImage = XFile.fromData(Uint8List(0)).obs;

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
    'Repair plumbing',
    'New Plumbing Fitting',
  ];

  final typesmaterials = [
    'Not Selected',
    'Steel',
    'Stainless steel',
    'Brass',
    'Galvanized Pipe',
  ];

  var selectedType = 'Not Selected'.obs;
  var selectedMaterial = 'Not Selected'.obs;

  late String userLongitude;
  late String userlatitude;

  bool isInformationComplete() {
    return tillDate.value.isAfter(DateTime.now()) &&
        selectedType.value != 'Not Selected' &&
        selectedMaterial.value != 'Not Selected' &&
        informationController.text.isNotEmpty;
  }

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

  // void addPlumbingDataToFirebase(BuildContext context) async {
  //   if (isInformationComplete()) {
  //     // Get current user location
  //     getusercuttentlocation();

  //     // Create a PlumbingData object
  //     PlumbingData plumbingData = PlumbingData(
  //       tillDate: tillDate.value,
  //       plumbingType: selectedType.value,
  //       plumbingMaterial: selectedMaterial.value,
  //       imagePath: pickedImage.value.path,
  //       information: informationController.text,
  //       userLongitude: userLongitude,
  //       userLatitude: userlatitude,
  //     );
  //     _showPlumbingInfoDialog(context, plumbingData);
  //     // Add data to Firebase
  //     // try {
  //     //   await FirebaseFirestore.instance.collection('plumbingData').add(
  //     //         plumbingData.toMap(),
  //     //       );

  //     //   // Data added successfully, you can navigate or show a success message
  //     // } catch (e) {
  //     //   print('Error adding plumbing data to Firebase: $e');
  //     //   // Handle error as needed
  //     // }
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Incomplete Information'),
  //           content: Text('Please fill in all the required information.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
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
    String plumbingImagePath =
        await uploadImageToFirebase(pickedImage.value, 'plumbing_images');

    // Store data in Firestore

    await SharedPreferences.getInstance().then((prefs) {
      CollectionReference plumbingImages =
          FirebaseFirestore.instance.collection('works/works/plumbing');
      CollectionReference userWork = FirebaseFirestore.instance
          .collection('client/${prefs.getString("phoneNumber")}/mywork');

      String docId = "";
      plumbingImages
          .add({
            'tillDate': tillDate.value,
            'selectedType': selectedType.value,
            'selectedMaterial': selectedMaterial.value,
            'imagePath': plumbingImagePath,
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
              "workType": "Plumbing",
              "time":
                  "${DateFormat('dd/MM/yyyy').format(DateTime.now())} to ${DateFormat('dd/MM/yyyy').format(tillDate.value)}",
              "amount": budgetController.text,
              'redirectPath': 'plumbing/$docId'
            });
            Get.back();
          });
      EasyLoading.dismiss();
    });

    void _showPlumbingInfoDialog(
        BuildContext context, PlumbingData plumbingData) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Plumbing Information'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Till Date: ${DateFormat('dd/MM/yyyy').format(plumbingData.tillDate)}'),
                Text('Plumbing Type: ${plumbingData.plumbingType}'),
                Text('Plumbing Material: ${plumbingData.plumbingMaterial}'),
                Text('Image Path: ${plumbingData.imagePath}'),
                Text('Information: ${plumbingData.information}'),
                Text('User Latitude: ${plumbingData.userLatitude}'),
                Text('User Longitude: ${plumbingData.userLongitude}'),
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
