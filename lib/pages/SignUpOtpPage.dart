import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpOtpPage extends StatelessWidget {
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
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Enter OTP',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 5, 249, 0),
                        ),
                      ),
                      OtpTextField(
                        numberOfFields: 6,
                        enabledBorderColor: Colors.transparent,
                        focusedBorderColor: Colors.transparent,
                        textStyle:
                            TextStyle(color: Colors.white.withOpacity(.9)),
                        filled: true,
                        fillColor: Color(0xff212428),
                        autoFocus: true,
                        showFieldAsBox: true,
                        borderWidth: 2.0,
                        borderRadius: BorderRadius.circular(8),
                        onCodeChanged: (String code) {},
                        onSubmit: (String verificationCode) {},
                      ),
                      InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Fluttertoast.showToast(
                            msg: 'SIGN-IN button pressed',
                          );
                          // Navigator.push(context,MaterialPageRoute(builder: (context) => NextPage()));
                        },
                        child: Container(
                          height: _width * .1,
                          width: _width * .4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 5, 249, 0),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            'Verify',
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
}
