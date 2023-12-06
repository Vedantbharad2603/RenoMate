import 'package:get/get.dart';
import 'package:renomateclient/controllers/sign_in_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:renomateclient/packages/intl_phone_field/country_picker_dialog.dart';
import 'package:renomateclient/packages/intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';
import 'package:renomateclient/pages/sign_up_page.dart';

class SignInPage extends StatelessWidget {
  final SignInPageController controller = Get.put(SignInPageController());

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    controller.context = context;

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
            height: height,
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: height * .15,
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
                    margin: EdgeInsets.fromLTRB(width * 0.1, 0, width * 0.1, 0),
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
                  password("Password", width * 0.1, width * 0.1,
                      controller.passController),
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
                      // HapticFeedback.lightImpact();
                      controller.isPhoneNumberRegistered(
                          context, controller.phoneNumber.completeNumber);
                      // if (otpCode != null) {
                      //   verifyOtp(context, otpCode);
                      // } else {
                      //   showSnackBar(context, "Enter 6-Digit code");
                      // }
                    },
                    child: Container(
                      height: width * .1,
                      width: width * .4,
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
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (builder) => SignUpPage(),
                          //   ),
                          // );
                          Get.to(SignUpPage());
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
                    height: height * .1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget password(String hintText, double left, double right,
      TextEditingController textEditingController) {
    double width = MediaQuery.of(controller.context).size.width;
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
      child: Obx(
        () => TextField(
          controller: textEditingController,
          style: TextStyle(color: Colors.white.withOpacity(.9)),
          obscureText: controller.passHide.value,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white.withOpacity(.7),
            ),
            suffixIcon: InkWell(
              onTap: () {
                controller.passHide.value = !controller.passHide.value;
              },
              child: Icon(
                controller.passHide.value
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
      ),
    );
  }

  Widget phoneno() {
    return IntlPhoneField(
      controller: controller.phoneController,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
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
        controller.phoneNumber = phone;
        // log(phone
        //     .completeNumber); // You can access the complete phone number here
      },
    );
  }
}
