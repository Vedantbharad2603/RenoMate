import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:renomate/packages/intl_phone_field/phone_number.dart';
import 'package:flutter/material.dart';
import 'package:renomate/packages/intl_phone_field/country_picker_dialog.dart';
import 'package:renomate/packages/intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:renomate/pages/master_page.dart';
import 'package:renomate/pages/sign_up_page.dart';
import 'package:renomate/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String verificationId = "";
  String otpCode = "";

  String? _uid;
  String get uid => _uid!;

  bool passHide = true;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  PhoneNumber phoneNumber =
      PhoneNumber.fromCompleteNumber(completeNumber: "+911234567890");
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Hide the keyboard when tapping outside of the OTP input field
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xff292C31),
        body: SingleChildScrollView(
          child: SizedBox(
            height: _height,
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: _height * .15,
                  ),
                  const Text(
                    'SIGN IN TO RENOMATE',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 5, 249, 0),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(_width * 0.1, 0, _width * 0.1, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xff212428),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 0, 15, 15),
                    child: phoneno(),
                    // child: Column(
                    //   children: [
                    //     phoneno(),
                    //     const SizedBox(
                    //       height: 20,
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         HapticFeedback.lightImpact();
                    //         // isPhoneNumberRegistered(
                    //         //     "${phoneNumber.countryCode}${phoneNumber.number}");
                    //         isPhoneNumberRegistered(
                    //             context, phoneNumber.completeNumber);
                    //         // sendPhoneNumber(context);
                    //       },
                    //       child: Container(
                    //         height: _width * .08,
                    //         width: _width * .3,
                    //         alignment: Alignment.center,
                    //         decoration: BoxDecoration(
                    //             color: const Color.fromARGB(255, 5, 249, 0),
                    //             borderRadius: BorderRadius.circular(20)),
                    //         child: const Text(
                    //           'Send OTP',
                    //           style: TextStyle(
                    //             color: Colors.black,
                    //             fontWeight: FontWeight.w600,
                    //             fontSize: 16,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    // ],
                    // ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  password(
                      "Password", _width * 0.1, _width * 0.1, passController),
                  // const SizedBox(
                  //   height: 60,
                  // ),
                  // OtpTextField(
                  //   numberOfFields: 6,
                  //   enabledBorderColor: Colors.transparent,
                  //   focusedBorderColor: Colors.transparent,
                  //   textStyle: TextStyle(color: Colors.white.withOpacity(.9)),
                  //   filled: true,
                  //   fillColor: const Color(0xff212428),
                  //   showFieldAsBox: true,
                  //   borderWidth: 2.0,
                  //   borderRadius: BorderRadius.circular(8),
                  //   onCodeChanged: (String code) {},
                  //   //runs when every textfield is filled
                  //   onSubmit: (String verificationCode) {
                  //     log(verificationCode);
                  //     otpCode = verificationCode;
                  //   },
                  // ),
                  const Expanded(child: SizedBox()),
                  InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      isPhoneNumberRegistered(
                          context, phoneNumber.completeNumber);
                      // if (otpCode != null) {
                      //   verifyOtp(context, otpCode);
                      // } else {
                      //   showSnackBar(context, "Enter 6-Digit code");
                      // }
                    },
                    child: Container(
                      height: _width * .1,
                      width: _width * .4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 5, 249, 0),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.white.withOpacity(.9),
                          fontSize: 16,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (builder) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 5, 249, 0)
                                .withOpacity(.9),
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _height * .1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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

    db.doc("/users/$phoneNum").get().then(
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
                builder: (context) => MasterPage(),
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

  // Function to show the error dialog with a dynamic message
  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget password(String hintText, double left, double right,
      TextEditingController textEditingController) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.maxFinite,
      height: 56,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(left, 0, right, 0),
      padding: EdgeInsets.only(right: width * 0.05),
      decoration: BoxDecoration(
        color: const Color(0xff212428),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: textEditingController,
        style: TextStyle(color: Colors.white.withOpacity(.9)),
        obscureText: passHide,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white.withOpacity(.7),
          ),
          suffixIcon: InkWell(
            onTap: () {
              passHide = !passHide;
              setState(() {});
            },
            child: Icon(
              passHide ? Icons.visibility : Icons.visibility_off,
              color: Colors.white.withOpacity(.7),
            ),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.5),
          ),
        ),
      ),
    );
  }

  Widget phoneno() {
    return IntlPhoneField(
      controller: phoneController,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
        counterStyle: TextStyle(color: Colors.white.withOpacity(.5)),
        border: InputBorder.none,
        hintMaxLines: 1,
        hintText: "Enter Phone Number",
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.white.withOpacity(.5),
        ),
      ),
      style: TextStyle(color: Colors.white.withOpacity(.9)),
      pickerDialogStyle: PickerDialogStyle(
        textFieldTextStyle:
            TextStyle(fontSize: 16, color: Colors.white.withOpacity(.9)),
        backgroundColor: Colors.black,
        searchFieldPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        searchFieldInputDecoration: InputDecoration(
          labelText: "Search country",
          suffixIcon: Icon(Icons.search, color: Colors.white.withOpacity(.9)),
          labelStyle: TextStyle(color: Colors.white.withOpacity(.5)),
        ),
        countryCodeStyle: TextStyle(color: Colors.white.withOpacity(.9)),
        countryNameStyle: TextStyle(color: Colors.white.withOpacity(.9)),
      ),
      dropdownTextStyle:
          TextStyle(fontSize: 16, color: Colors.white.withOpacity(.9)),
      dropdownIcon:
          Icon(Icons.arrow_drop_down, color: Colors.white.withOpacity(.9)),
      initialCountryCode: 'IN', // Set the initial country code
      onChanged: (phone) {
        phoneNumber = phone;
        // log(phone
        //     .completeNumber); // You can access the complete phone number here
      },
    );
  }
}
