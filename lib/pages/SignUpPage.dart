import 'package:flutter/material.dart';
import 'package:RenoMate/pages/SignUpOtpPage.dart';
// import 'package:intl_phone_field/country_picker_dialog.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:RenoMate/Packages/intl_phone_field/country_picker_dialog.dart';
import 'package:RenoMate/Packages/intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff292C31),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Column(
              children: [
                // const Expanded(child: SizedBox()),
                Expanded(
                  // flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(),
                      const Text(
                        'SIGN UP TO RENOMATE',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 5, 249, 0),
                        ),
                      ),
                      const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          username(Icons.account_circle_outlined, 'First Name',
                              false, false, width * 0.1, 0),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          username(Icons.account_circle_outlined, 'Last Name',
                              false, false, 0, width * 0.1),
                        ],
                      ),
                      phoneno(width * 0.1),
                      SizedBox(
                        height: height * 0.2,
                      ),
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
                          height: width * .1,
                          width: width * .4,
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
                    ],
                  ),
                ),
              ],
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

  Widget phoneno(double horizontal) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: width * 0.21,
      // width: _width / 1.2, // Set the width to match the username widget
      // alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(horizontal, 0, horizontal, 0),
      // padding: EdgeInsets.only(right: _width * 0.1),
      decoration: BoxDecoration(
        color: const Color(0xff212428),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
      child: IntlPhoneField(
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
      ),
    );
  }
}
