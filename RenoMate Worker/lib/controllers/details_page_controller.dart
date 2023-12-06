import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DetailsPageController extends GetxController {
  // XFile? _image;
  // XFile? _image2;

  Rx<XFile> stage1 = XFile.fromData(Uint8List(0)).obs;
  Rx<XFile> stage2 = XFile.fromData(Uint8List(0)).obs;

  // Function to open the camera and capture a photo
  // Future<void> _openCamera() async {
  //   final picker = ImagePicker();
  //   final image = await picker.pickImage(source: ImageSource.camera);

  //   if (image != null) {
  //     setState(() {
  //       stage1.value = XFile(image.path);
  //     });
  //   }
  // }

  // Future<void> _openCamera2() async {
  //   final picker = ImagePicker();
  //   final image = await picker.pickImage(source: ImageSource.camera);

  //   if (image != null) {
  //     setState(() {
  //       stage2.value = XFile(image.path);
  //     });
  //   }
  // }
}
