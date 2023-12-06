import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renomateclient/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserProfilePageController extends GetxController {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  bool areAllFieldsFilled() {
    return fnameController.text.isNotEmpty &&
        lnameController.text.isNotEmpty &&
        mobileNumberController.text.isNotEmpty;
    // blockController.text.isNotEmpty &&
    // streetController.text.isNotEmpty &&
    // cityController.text.isNotEmpty &&
    // stateController.text.isNotEmpty &&
    // pinCodeController.text.isNotEmpty;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SharedPreferences.getInstance().then((prefs) {
      fnameController.text = prefs.getString("firstName")!;
      lnameController.text = prefs.getString("lastName")!;
      mobileNumberController.text = "+${prefs.getString("phoneNumber")!}";
      blockController.text = prefs.getString("blockNo") ?? "";
      streetController.text = prefs.getString("streetName") ?? "";
      cityController.text = prefs.getString("city") ?? "";
      stateController.text = prefs.getString("state") ?? "";
      pinCodeController.text = prefs.getString("pincode") ?? "";
    });
  }

  saveData(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("firstName", fnameController.text.toUpperCase());
      prefs.setString("lastName", lnameController.text.toUpperCase());
      prefs.setString("blockNo", blockController.text);
      prefs.setString("streetName", streetController.text);
      prefs.setString("city", cityController.text);
      prefs.setString("state", stateController.text);
      prefs.setString("pincode", pinCodeController.text);

      CollectionReference userWork =
          FirebaseFirestore.instance.collection('client');
      userWork.doc(prefs.getString("phoneNumber")!).update({
        'firstName': fnameController.text,
        'lastName': lnameController.text,
        'blockNo': blockController.text,
        'streetName': streetController.text,
        'city': cityController.text,
        'state': stateController.text,
        'pincode': pinCodeController.text,
      });
      showSnackBar(context, "Saved Sucessfully.");
      Get.back();
    });
  }
}
