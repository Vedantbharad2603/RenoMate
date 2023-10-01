import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renomate/packages/intl_phone_field/country_picker_dialog.dart';
import 'package:renomate/packages/intl_phone_field/intl_phone_field.dart';
import 'package:renomate/packages/intl_phone_field/phone_number.dart';
import 'package:renomate/pages/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:renomate/utils/utils.dart';
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

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late PhoneNumber phoneNumber;

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
                      username(Icons.account_circle_outlined, 'First Name',
                          false, false, _width * 0.1, 0, fnameController),
                      SizedBox(
                        width: _width * 0.05,
                      ),
                      username(Icons.account_circle_outlined, 'Last Name',
                          false, false, 0, _width * 0.1, lnameController),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(_width * 0.1, 0, _width * 0.1, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xff212428),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.fromLTRB(10, 0, 15, 15),
                    child: Column(
                      children: [
                        phoneno(),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            sendPhoneNumber(context);
                          },
                          child: Container(
                            height: _width * .08,
                            width: _width * .3,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 5, 249, 0),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              'Send OTP',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    enabledBorderColor: Colors.transparent,
                    focusedBorderColor: Colors.transparent,
                    textStyle: TextStyle(color: Colors.white.withOpacity(.9)),
                    filled: true,
                    fillColor: Color(0xff212428),
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
                  Expanded(child: SizedBox()),
                  InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      if (userOtp.isNotEmpty && userOtp.length == 6) {
                        verifyUser(PhoneAuthProvider.credential(
                            verificationId: verificationId, smsCode: userOtp));
                      } else {
                        showSnackBar(context, "Enter 6-Digit code");
                      }
                    },
                    child: Container(
                      height: _width * .1,
                      width: _width * .4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 5, 249, 0),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
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
                            color:
                                Color.fromARGB(255, 5, 249, 0).withOpacity(.9),
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

  void sendPhoneNumber(BuildContext context) async {
    log("${phoneNumber.countryCode} ${phoneNumber.number}");
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: "${phoneNumber.countryCode}${phoneNumber.number}",
          // phoneNumber: "+44 7444 555666",
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            // verifyUser(phoneAuthCredential);
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            // showErrorDialog(context, error.toString());
            log(error.toString());
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            this.verificationId = verificationId;
            // showErrorDialog(context, verificationId);
          },
          codeAutoRetrievalTimeout: (verificationId) {
            // showErrorDialog(context, verificationId);
          });
    } on FirebaseAuthException catch (e) {
      // showErrorDialog(context, e.toString());
      // showSnackBar(context, e.message.toString());
      log(e.toString());
    }
    // log(verificationId);
  }

  // Function to show the error dialog with a dynamic message
  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
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

        final userData = <String, String>{
          "phoneNumber": phoneNum,
          "firstName": fnameController.text.toUpperCase(),
          "lastName": lnameController.text.toUpperCase(),
          "uid": user.uid,
          "creationTime": user.metadata.creationTime.toString(),
        };

        db
            .doc("/users/$phoneNum")
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
          });
        }).catchError((e) {
          log("Error writing document: $e");
        });
      }
    } on FirebaseAuthException catch (e) {
      // showErrorDialog(context, e.toString());
      showSnackBar(context, e.message.toString());
      log(e.toString());
    }
  }

  Widget username(IconData icon, String hintText, bool isPassword, bool isEmail,
      double left, double right, TextEditingController textEditingController) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        height: width * 0.14,
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
          obscureText: isPassword,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
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

  Widget phoneno() {
    return IntlPhoneField(
      controller: phoneController,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(0, 14, 0, 0),
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
        searchFieldPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
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
