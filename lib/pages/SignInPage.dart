import 'package:flutter/material.dart';
import 'package:RenoMate/pages/SignUpOtpPage.dart';
// import 'package:intl_phone_field/country_picker_dialog.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:RenoMate/Packages/intl_phone_field/country_picker_dialog.dart';
import 'package:RenoMate/Packages/intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
              child: Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        username(Icons.account_circle_outlined, 'First Name',
                            false, false, _width * 0.1, 0),
                        SizedBox(
                          width: _width * 0.05,
                        ),
                        username(Icons.account_circle_outlined, 'Last Name',
                            false, false, 0, _width * 0.1),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        // height: _width * 0.21,
                        // width: _width / 1.2, // Set the width to match the username widget
                        // alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(
                            _width * 0.1, 0, _width * 0.1, 0),
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
                                // Fluttertoast.showToast(
                                //   msg: 'SIGN-IN button pressed',
                                // );
                                // Navigator.push(context,MaterialPageRoute(builder: (context) => NextPage()));
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
                        )),
                    // SizedBox(
                    //   height: _height * 0.2,
                    // ),
                    // const Text(
                    //   'Enter OTP',
                    //   style: TextStyle(
                    //     fontSize: 25,
                    //     fontWeight: FontWeight.w600,
                    //     color: Color.fromARGB(255, 5, 249, 0),
                    //   ),
                    // ),
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
                      // autoFocus: true,
                      showFieldAsBox: true,
                      borderWidth: 2.0,
                      borderRadius: BorderRadius.circular(8),
                      onCodeChanged: (String code) {},
                      onSubmit: (String verificationCode) {},
                    ),
                    Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        // Fluttertoast.showToast(
                        //   msg: 'SIGN-IN button pressed',
                        // );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpOtpPage()));
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.9),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Sign up",
                          style: TextStyle(
                            color:
                                Color.fromARGB(255, 5, 249, 0).withOpacity(.9),
                            fontSize: 16,
                            decoration: TextDecoration.underline,
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
      ),
    );
  }

  //Vedant

  Widget username(IconData icon, String hintText, bool isPassword, bool isEmail,
      double left, double right) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        height: width * 0.14,
        // width: _width * 0.4,
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(left, 0, right, 0),
        padding: EdgeInsets.only(right: width * 0.05),
        decoration: BoxDecoration(
          color: const Color(0xff212428),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
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
        // print(phone
        //     .completeNumber); // You can access the complete phone number here
      },
    );
  }
}
