import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:renomateclient/packages/intl_phone_field/country_picker_dialog.dart';
import 'package:renomateclient/packages/intl_phone_field/intl_phone_field.dart';
import 'package:renomateclient/packages/intl_phone_field/phone_number.dart';
import 'package:renomateclient/pages/master_page.dart';
import 'package:renomateclient/pages/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:renomateclient/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String verificationId = "";
  String userOtp = "";

  String? _uid;

  String get uid => _uid!;

  bool passHide = true;
  bool conPassHide = true;

  bool numberChanged = true;

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController conPassController = TextEditingController();

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
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: _height),
            // size: Size.fromHeight(_height),
            // height: _height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: _height * .1,
                    ),
                    const Text(
                      'SIGN UP TO RENOMATE',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 5, 249, 0),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        username(
                            'First Name', _width * 0.1, 0, fnameController),
                        SizedBox(
                          width: _width * 0.05,
                        ),
                        username('Last Name', 0, _width * 0.1, lnameController),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            _width * 0.1, 0, _width * 0.1, 0),
                        decoration: BoxDecoration(
                          color: const Color(0xff212428),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 0, 15, 15),
                        child: phoneno()),
                    const SizedBox(
                      height: 20,
                    ),
                    password("Password", _width * 0.1, _width * 0.1,
                        passController, false),
                    const SizedBox(
                      height: 20,
                    ),
                    password("Confirm Password", _width * 0.1, _width * 0.1,
                        conPassController, true),
                    const SizedBox(
                      height: 60,
                    ),
                    OtpTextField(
                      numberOfFields: 6,
                      enabledBorderColor: Colors.transparent,
                      focusedBorderColor: Colors.transparent,
                      textStyle: TextStyle(color: Colors.white.withOpacity(.9)),
                      filled: true,
                      fillColor: const Color(0xff212428),
                      showFieldAsBox: true,
                      borderWidth: 2.0,
                      borderRadius: BorderRadius.circular(8),
                      onCodeChanged: (String code) {},
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode) {
                        log(verificationCode);
                        userOtp = verificationCode;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // HapticFeedback.lightImpact();
                        // EasyLoading.show(status: 'Please Wait ...');

                        if (fnameController.text.isEmpty) {
                          showSnackBar(context, "First Name Required");
                          return;
                        }

                        if (lnameController.text.isEmpty) {
                          showSnackBar(context, "Last Name Required");
                          return;
                        }

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

                        if (conPassController.text.isEmpty) {
                          showSnackBar(context, "Confirm Password Required");
                          return;
                        }

                        if (conPassController.text != passController.text) {
                          showSnackBar(context, "Confirm Password Not Match");
                          return;
                        }

                        if (numberChanged) {
                          EasyLoading.show(status: 'Please Wait ...');

                          sendPhoneNumber(context);
                          numberChanged = false;
                        } else {
                          if (userOtp.isNotEmpty && userOtp.length == 6) {
                            EasyLoading.show(status: 'Please Wait ...');
                            verifyUser(PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: userOtp));
                          } else {
                            showSnackBar(context, "Enter 6-Digit code");
                          }
                        }
                        setState(() {});
                      },
                      child: Container(
                        height: _width * .1,
                        width: _width * .4,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 5, 249, 0),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          numberChanged ? 'SEND OTP' : 'SIGN UP',
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
                          "Already have an account? ",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.9),
                            fontSize: 16,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (builder) => SignInPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign in",
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
                      height: _height * 0.065,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber(BuildContext context) async {
    // log("${phoneNumber.countryCode} ${phoneNumber.number}");

    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: "${phoneNumber.countryCode}${phoneNumber.number}",
          // phoneNumber: "+44 7444 555666",
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            // verifyUser(phoneAuthCredential);
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
            EasyLoading.dismiss();
          },
          verificationFailed: (error) {
            EasyLoading.dismiss();
            // showErrorDialog(context, error.toString());
            log(error.toString());
            numberChanged = true;
            showSnackBar(context, "Please check your internet connection");
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            EasyLoading.dismiss();
            this.verificationId = verificationId;
            // showErrorDialog(context, verificationId);
          },
          codeAutoRetrievalTimeout: (verificationId) {
            // showErrorDialog(context, verificationId);
          });
    } on FirebaseAuthException catch (e) {
      // showErrorDialog(context, e.toString());
      // showSnackBar(context, e.message.toString());
      numberChanged = true;
      EasyLoading.dismiss();
      showSnackBar(context, "Please check your internet connection");
      log(e.toString());
    }
    // log(verificationId);
    setState(() {});
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

  void verifyUser(PhoneAuthCredential creds) async {
    try {
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // log(user.uid);
        // log(PhoneNumber.fromCompleteNumber(
        //         completeNumber: user.phoneNumber ?? "")
        //     .number);
        // log("${fnameController.text} ${lnameController.text}");
        // log(user.metadata.toString());

        String phoneNum =
            (user.phoneNumber ?? "").replaceAll(RegExp(r'[+\s]'), "");

        // Hash the password using MD5
        String hashedPassword =
            md5.convert(utf8.encode(passController.text)).toString();

        final userData = <String, String>{
          "phoneNumber": phoneNum,
          "firstName": fnameController.text.toUpperCase(),
          "lastName": lnameController.text.toUpperCase(),
          "uid": user.uid,
          "creationTime": user.metadata.creationTime.toString(),
          "password": hashedPassword, // Store the hashed password
        };

        db
            .doc("/client/$phoneNum")
            .set(userData, SetOptions(merge: true))
            .then((_) {
          SharedPreferences.getInstance().then((prefs) {
            prefs.setBool('isLogin', true);
            prefs.setString("phoneNumber", phoneNum);
            prefs.setString("firstName", fnameController.text.toUpperCase());
            prefs.setString("lastName", lnameController.text.toUpperCase());
            prefs.setString("uid", user.uid);
            prefs.setString(
                "creationTime", user.metadata.creationTime.toString());

            EasyLoading.dismiss();

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MasterPage(),
              ),
              (route) => false, // This will remove all routes from the stack
            );
          });
        }).catchError((e) {
          EasyLoading.dismiss();
          log("Error writing document: $e");
        });
      }
    } on FirebaseAuthException catch (e) {
      // showErrorDialog(context, e.toString());
      EasyLoading.dismiss();
      showSnackBar(context, e.message.toString());
      log(e.toString());
    }
  }

  bool isPasswordValid(String password) {
    // Password should contain at least 1 uppercase letter, 1 lowercase letter, 1 number,
    // 1 special character, and have a minimum length of 6 characters.
    final RegExp passwordRegExp =
        RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{6,}$');
    return passwordRegExp.hasMatch(password);
  }

  Widget username(String hintText, double left, double right,
      TextEditingController textEditingController) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
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
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_circle_outlined,
              color: Colors.white.withOpacity(.7),
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
      ),
    );
  }

  Widget password(String hintText, double left, double right,
      TextEditingController textEditingController, bool conPass) {
    double width = MediaQuery.of(context).size.width;
    return Container(
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
        obscureText: conPass ? conPassHide : passHide,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white.withOpacity(.7),
          ),
          suffixIcon: InkWell(
            onTap: () {
              conPass ? conPassHide = !conPassHide : passHide = !passHide;
              setState(() {});
            },
            child: Icon(
              (conPass && conPassHide) || (!conPass && passHide)
                  ? Icons.visibility
                  : Icons.visibility_off,
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
        numberChanged = true;
        setState(() {});
        // log(phone
        //     .completeNumber); // You can access the complete phone number here
      },
    );
  }
}
