import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:renomate/packages/intl_phone_field/phone_number.dart';
import 'package:renomate/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:renomate/packages/intl_phone_field/country_picker_dialog.dart';
import 'package:renomate/packages/intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String verificationId = "";
  String otpCode = "";

  String? _uid;
  String get uid => _uid!;

  TextEditingController phoneController = TextEditingController();
  late PhoneNumber phoneNumber;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
                            // sendPhoneNumber(context);
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
                      otpCode = verificationCode;
                    },
                  ),
                  Expanded(child: SizedBox()),
                  InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
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
                        'SIGN-UP',
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

  void isPhoneNumberRegistered(String phoneNumber) async {
    // try {
    //   await _firebaseAuth.signInWithPhoneNumber(phoneNumber);
    // } catch (e) {
    //   // Handle the error - if it's an auth error, the phone number is not registered
    //   if (e is FirebaseAuthException) {
    //     // The phone number is not registered
    //   }
    // }
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
