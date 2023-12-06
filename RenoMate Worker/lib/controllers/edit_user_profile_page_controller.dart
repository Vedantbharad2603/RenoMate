import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renomateworker/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserProfilePageController extends GetxController {
  // TextEditingController userNameController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  List<String> jobProfileItems = [
    'Select your profession',
    'Painter',
    'Plumber'
  ];

  var selectedJobProfile = 'Select your profession'.obs;

  bool areAllFieldsFilled() {
    return fnameController.text.isNotEmpty &&
        lnameController.text.isNotEmpty &&
        mobileNumberController.text.isNotEmpty;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SharedPreferences.getInstance().then((prefs) {
      fnameController.text = prefs.getString("firstName")!;
      lnameController.text = prefs.getString("lastName")!;
      selectedJobProfile.value =
          prefs.getString("jobProfile") ?? 'Select your profession';
      mobileNumberController.text = "+${prefs.getString("phoneNumber")!}";
    });
  }

  saveData(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("firstName", fnameController.text.toUpperCase());
      prefs.setString("lastName", lnameController.text.toUpperCase());
      prefs.setString("jobProfile", selectedJobProfile.value);

      CollectionReference userWork =
          FirebaseFirestore.instance.collection('worker');
      userWork.doc(prefs.getString("phoneNumber")!).update({
        'firstName': fnameController.text,
        'lastName': lnameController.text,
        'jobProfile': selectedJobProfile.value,
      });
      showSnackBar(context, "Saved Sucessfully.");
      Get.back();
    });
  }
}
