import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renomateworker/controllers/details_page_controller.dart';
import 'package:renomateworker/theme.dart';
import 'package:renomateworker/utils/my_timeline_tile.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key});

  final DetailsPageController controller = Get.put(DetailsPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          // "RenoMate",
          "R E N O M A T E",
          style: TextStyle(
            // fontSize: 30,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: MyTheme.accent,
        surfaceTintColor: MyTheme.accent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            MyTimeLineTile(
              isFirst: true,
              isLast: false,
              isPast: true,
              eventCard: Column(
                children: [
                  Text(
                    "Worker Found",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: true ? MyTheme.background : MyTheme.text),
                  ),
                  Text(
                    "Workername will come to your place soon",
                    style: TextStyle(
                        fontSize: 15,
                        color: true ? MyTheme.background : Colors.transparent),
                  ),
                ],
              ),
            ),
            MyTimeLineTile(
              isFirst: false,
              isLast: false,
              isPast: true,
              eventCard: Container(
                child: Column(
                  children: [
                    Text(
                      "Measurements Taken",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: true ? MyTheme.background : MyTheme.text,
                      ),
                    ),
                    buildStage1ImagePicker(context)
                    // ElevatedButton(
                    //   onPressed: _openCamera,
                    //   child: Text("Open Camera"),
                    // ),
                    // if (_image != null)
                    //   Column(
                    //     children: [
                    //       Container(
                    //         width: 100,
                    //         height: 100,
                    //         child: Image.file(File(_image!.path)),
                    //       ),
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Handle the upload image button action here
                    //         },
                    //         child: Text("Upload Image"),
                    //       ),
                    //     ],
                    //   ),
                  ],
                ),
              ),
            ),
            MyTimeLineTile(
              isFirst: false,
              isLast: false,
              isPast: true,
              eventCard: Container(
                child: Column(
                  children: [
                    Text(
                      "Work Done",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: true ? MyTheme.background : MyTheme.text,
                      ),
                    ),
                    buildStage2ImagePicker(context),
                    // ElevatedButton(
                    //   onPressed: _openCamera2,
                    //   child: Text("Open Camera"),
                    // ),
                    // if (_image2 != null)
                    //   Column(
                    //     children: [
                    //       Container(
                    //         width: 100,
                    //         height: 100,
                    //         child: Image.file(File(_image2!.path)),
                    //       ),
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Handle the upload payment button action here
                    //         },
                    //         child: Text("Upload image"),
                    //       ),
                    //     ],
                    //   ),
                  ],
                ),
              ),
            ),
            MyTimeLineTile(
              isFirst: false,
              isLast: true,
              isPast: false,
              eventCard: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const PaymentScreen()),
                  // );
                },
                child: Column(
                  children: [
                    Text(
                      "Payment Done",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: false ? MyTheme.background : MyTheme.text),
                    ),
                    Text(
                      "Payment Done",
                      style: TextStyle(
                          fontSize: 15,
                          color:
                              false ? MyTheme.background : Colors.transparent),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStage1ImagePicker(context) {
    return Obx(() => controller.stage1.value.path == ""
        ? buildImagePickerButton(context, "st1")
        : buildSelectedImage(context, controller.stage1.value.path, "st1"));
  }

  Widget buildStage2ImagePicker(context) {
    return Obx(() => controller.stage2.value.path == ""
        ? buildImagePickerButton(context, "st2")
        : buildSelectedImage(context, controller.stage2.value.path, "st2"));
  }

  Widget buildImagePickerButton(context, String type) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        // color: MyTheme.accent,
        borderRadius: BorderRadius.circular(height * 0.02),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyTheme.button2,
            ),
            onPressed: () {
              _pickImage(context, ImageSource.gallery,
                  isStage2: type == "st2" ? true : false);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Gallery ',
                  style: TextStyle(color: MyTheme.text),
                ),
                Icon(
                  Icons.photo_library,
                  color: MyTheme.text,
                )
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyTheme.button2,
            ),
            onPressed: () {
              _pickImage(context, ImageSource.camera,
                  isStage2: type == "st2" ? true : false);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Camera ',
                  style: TextStyle(color: MyTheme.text),
                ),
                Icon(
                  Icons.camera_alt,
                  color: MyTheme.text,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectedImage(context, imagePath, type) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 20),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyTheme.accent,
        borderRadius: BorderRadius.circular(height * 0.02),
      ),
      child: Column(
        children: [
          Image.file(
            File(imagePath),
            height: 200,
            width: 250,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          Text(
            'Selected Image',
            style: TextStyle(color: MyTheme.text, fontSize: height * 0.018),
          ),
          const SizedBox(height: 10),
          buildImagePickerButton(context, type),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: MyTheme.button3,
          //   ),
          //   onPressed: () {
          //     _pickImage(context, ImageSource.camera, isReference: false);
          //   },
          //   child: Text(
          //     'Reupload Image',
          //     style: TextStyle(color: MyTheme.text),
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source,
      {required bool isStage2}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (isStage2) {
      controller.stage2.value = pickedFile!;
    } else {
      controller.stage1.value = pickedFile!;
    }
  }
}
