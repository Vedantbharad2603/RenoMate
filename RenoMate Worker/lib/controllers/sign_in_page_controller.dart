import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:renomateworker/packages/intl_phone_field/phone_number.dart';
import 'package:renomateworker/pages/master_page.dart';
import 'package:renomateworker/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPageController extends GetxController {
  String verificationId = "";
  String otpCode = "";

  String? _uid;
  String get uid => _uid!;

  var passHide = true.obs;

  late BuildContext context;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  PhoneNumber phoneNumber =
      PhoneNumber.fromCompleteNumber(completeNumber: "+911234567890");
  final FirebaseFirestore db = FirebaseFirestore.instance;

  void isPhoneNumberRegistered(BuildContext context, String phoneNum) async {
    // log(phoneNumber.completeNumber + " " + phoneNumber.number);
    if (phoneNumber.number.isEmpty ||
        phoneNumber.completeNumber == "911234567890") {
      showSnackBar(context, "Phone Number Required");
      return;
    }

    if (!phoneNumber.isValidNumber() ||
        phoneNumber.completeNumber == "911234567890") {
      showSnackBar(context, "Phone number not valid");
      return;
    }

    if (passController.text.isEmpty) {
      showSnackBar(context, "Password Required");
      return;
    }

    if (!isPasswordValid(passController.text)) {
      showSnackBar(context, "Invalid password format");
      return;
    }

    phoneNum = phoneNum.replaceFirst("+", "");
    // log(phoneNum);
    EasyLoading.show(status: 'Please Wait ...');

    db.doc("/worker/$phoneNum").get().then(
      (DocumentSnapshot doc) {
        EasyLoading.dismiss();

        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          // Retrieve the hashed password from Firestore
          String storedPassword = data['password'];

          // Hash the entered password using MD5
          String enteredPassword =
              md5.convert(utf8.encode(passController.text)).toString();

          // Compare the hashed passwords
          if (storedPassword == enteredPassword) {
            SharedPreferences.getInstance().then((prefs) {
              prefs.setBool('isLogin', true);
              prefs.setString("phoneNumber", data['phoneNumber']);
              prefs.setString("firstName", data['firstName']);
              prefs.setString("lastName", data['lastName']);
              prefs.setString("uid", data['uid']);
              prefs.setString("creationTime", data['creationTime']);
            });

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MasterPage(),
              ),
              (route) => false, // This will remove all routes from the stack
            );
          } else {
            showSnackBar(context, "Incorrect Password");
          }
        } else {
          showSnackBar(context, "Phone Number not registered");
        }
      },
      onError: (e) {
        EasyLoading.dismiss();
        log("Error getting document: $e");
        showSnackBar(context, "Phone Number not registered");
      },
    );
  }

  bool isPasswordValid(String password) {
    // Password should contain at least 1 uppercase letter, 1 lowercase letter, 1 number,
    // 1 special character, and have a minimum length of 6 characters.
    final RegExp passwordRegExp =
        RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{6,}$');
    return passwordRegExp.hasMatch(password);
  }
}
