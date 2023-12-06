import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:renomateclient/controllers/wall_painting_page_controller.dart';
import 'package:renomateclient/theme.dart';

class WallPaintingPage extends StatelessWidget {
  WallPaintingPage({super.key});

  final WallPaintingPageController controller =
      Get.put(WallPaintingPageController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyTheme.background,
      appBar: AppBar(
        title: const Text(
          "R E N O M A T E",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: MyTheme.accent,
        surfaceTintColor: MyTheme.accent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select last date",
                style: TextStyle(color: MyTheme.text, fontSize: height * 0.018),
              ),
              Container(
                decoration: BoxDecoration(
                  color: MyTheme.accent,
                  borderRadius: BorderRadius.circular(height * 0.02),
                ),
                margin: const EdgeInsets.only(top: 5, bottom: 20),
                height: 48,
                child: InkWell(
                  onTap: () {
                    controller.showDate(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          "Till Date:",
                          style: TextStyle(
                              color: MyTheme.text, fontSize: height * 0.018),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Obx(
                            () => Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(controller.tillDate.value)
                                  .toString(),
                              style: TextStyle(
                                  color: MyTheme.text,
                                  fontSize: height * 0.018),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                "Select Paint type",
                style: TextStyle(color: MyTheme.text, fontSize: height * 0.018),
              ),
              Obx(
                () => buildDropdown(controller.selectedType.value, (value) {
                  controller.selectedType.value = value!;
                }, context, controller.types),
              ),
              Text(
                "Upload Your Wall Image",
                style: TextStyle(color: MyTheme.text, fontSize: height * 0.018),
              ),
              buildImagePicker(context),
              RichText(
                text: TextSpan(
                  text: 'Upload Image for Reference ',
                  style: TextStyle(
                      color: MyTheme.text,
                      fontSize: height * 0.018), // Adjust font size
                  children: <TextSpan>[
                    TextSpan(
                      text: '(optional)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: height * 0.015, // Adjust font size
                      ),
                    ),
                  ],
                ),
              ),
              buildReferenceImagePicker(context),
              Container(
                decoration: BoxDecoration(
                  color: MyTheme.accent,
                  borderRadius: BorderRadius.circular(height * 0.02),
                ),
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: height * 0.02, top: height * 0.02),
                        child: Text(
                          "More Information",
                          style: TextStyle(
                            color: MyTheme.text,
                            fontSize: height * 0.018,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: controller.informationController,
                        style: TextStyle(
                          color: MyTheme.text,
                          fontSize: height * 0.023,
                          fontWeight: FontWeight.w400,
                        ),
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        maxLines: 5,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyTheme.button2,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(height * 0.02),
                          ),
                          contentPadding: EdgeInsets.all(height * 0.03),
                          counterStyle: TextStyle(
                            color: MyTheme.text,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: MyTheme.accent,
                  borderRadius: BorderRadius.circular(height * 0.02),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: height * 0.02, top: height * 0.02),
                        child: Text(
                          "Enter budget amount",
                          style: TextStyle(
                            color: MyTheme.text,
                            fontSize: height * 0.018,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: controller.budgetController,
                        style: TextStyle(
                          color: MyTheme.text,
                          fontSize: height * 0.023,
                          fontWeight: FontWeight.w400,
                        ),
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyTheme.button2,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(height * 0.02),
                          ),
                          contentPadding: EdgeInsets.all(height * 0.03),
                          counterStyle: TextStyle(
                            color: MyTheme.text,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.tillDate.value.isAfter(DateTime.now()) &&
                        controller.selectedType.value != 'Not Selected' &&
                        controller.budgetController.text.isNotEmpty &&
                        controller.informationController.text.isNotEmpty) {
                      // All conditions are met, proceed with your logic
                      // Add your code to navigate or perform an action here
                      controller.getusercuttentlocation();
                      controller.saveDataWork(context);
                    } else {
                      // Display a message or handle the case where conditions are not met
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Validation Error'),
                            content: const Text(
                                'Please fill in all required fields.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.button1,
                  ),
                  child: Text(
                    'Post Work',
                    style: TextStyle(
                      color: MyTheme.background,
                      fontWeight: FontWeight.w600,
                      fontSize: height * 0.023,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(String selectedValue, Function(String?) onChanged,
      context, List<String> ddlist) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 20),
      padding: EdgeInsets.only(left: height * 0.016, right: height * 0.016),
      decoration: BoxDecoration(
        color: MyTheme.accent,
        borderRadius: BorderRadius.circular(height * 0.02),
      ),
      child: DropdownButton<String>(
        dropdownColor: MyTheme.accent,
        value: selectedValue,
        icon: const Icon(Icons.arrow_drop_down_rounded),
        iconSize: height * 0.04,
        isExpanded: true,
        underline: const SizedBox(),
        style: TextStyle(color: MyTheme.text, fontSize: height * 0.018),
        items: ddlist.map((unit) {
          return DropdownMenuItem(
            value: unit,
            child: Text(unit),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  // Widget buildImagePicker(context) {
  //   return controller.pickedImage.path == ""
  //       ? buildImagePickerButton(context, "wall")
  //       : Obx(() => buildSelectedImage(context, controller.pickedImage));
  // }

  Widget buildImagePicker(context) {
    return Obx(() => controller.pickedImage.value.path == ""
        ? buildImagePickerButton(context, "wall")
        : buildSelectedImage(
            context, controller.pickedImage.value.path, "wall"));
  }

  // Widget buildReferenceImagePicker(context) {
  //   return controller.referenceImage.path == ""
  //       ? buildImagePickerButton(context, "ref")
  //       : Obx(() => buildSelectedImage(context, controller.referenceImage));
  // }

  Widget buildReferenceImagePicker(context) {
    return Obx(() => controller.referenceImage.value.path == ""
        ? buildImagePickerButton(context, "ref")
        : buildSelectedImage(
            context, controller.referenceImage.value.path, "ref"));
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyTheme.button2,
            ),
            onPressed: () {
              _pickImage(context, ImageSource.gallery,
                  isReference: type == "ref" ? true : false);
            },
            child: Row(
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
                  isReference: type == "ref" ? true : false);
            },
            child: Row(
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

  // Widget buildReferenceImagePickerButton(context) {
  //   double height = MediaQuery.of(context).size.height;
  //   return Container(
  //     margin: EdgeInsets.only(top: 5, bottom: 20),
  //     padding: EdgeInsets.only(left: 20, right: 20),
  //     decoration: BoxDecoration(
  //       // color: MyTheme.accent,
  //       borderRadius: BorderRadius.circular(height * 0.02),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: MyTheme.button2,
  //           ),
  //           onPressed: () {
  //             _pickImage(context, ImageSource.gallery, isReference: true);
  //           },
  //           child: Row(
  //             children: [
  //               Text(
  //                 'Gallery ',
  //                 style: TextStyle(color: MyTheme.text),
  //               ),
  //               Icon(
  //                 Icons.photo_library,
  //                 color: MyTheme.text,
  //               )
  //             ],
  //           ),
  //         ),
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: MyTheme.button2,
  //           ),
  //           onPressed: () {
  //             _pickImage(context, ImageSource.camera, isReference: true);
  //           },
  //           child: Row(
  //             children: [
  //               Text(
  //                 'Camera ',
  //                 style: TextStyle(color: MyTheme.text),
  //               ),
  //               Icon(
  //                 Icons.camera_alt,
  //                 color: MyTheme.text,
  //               )
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<void> _pickImage(BuildContext context, ImageSource source,
      {required bool isReference}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (isReference) {
      controller.referenceImage.value = pickedFile!;
    } else {
      controller.pickedImage.value = pickedFile!;
    }
  }
}
