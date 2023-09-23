// // sign up page
// import 'package:flutter/material.dart';
// import 'package:RenoMate/pages/SignUpOtpPage.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:flutter/services.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';

// class SignUpPage extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );

//     _animation = Tween<double>(begin: .7, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.ease,
//       ),
//     )
//       ..addListener(
//         () {
//           setState(() {});
//         },
//       )
//       ..addStatusListener(
//         (status) {
//           if (status == AnimationStatus.completed) {
//             _controller.reverse();
//           } else if (status == AnimationStatus.dismissed) {
//             _controller.forward();
//           }
//         },
//       );

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double _width = MediaQuery.of(context).size.width;
//     double _height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: const Color(0xff292C31),
//       body: ScrollConfiguration(
//         behavior: MyBehavior(),
//         child: SingleChildScrollView(
//           child: SizedBox(
//             height: _height,
//             child: Column(
//               children: [
//                 const Expanded(child: SizedBox()),
//                 Expanded(
//                   flex: 4,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const SizedBox(),
//                       const Text(
//                         'SIGN UP TO RENOMATE',
//                         style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.w600,
//                           color: Color.fromARGB(255, 5, 249, 0),
//                         ),
//                       ),
//                       const SizedBox(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           username(Icons.account_circle_outlined, 'First Name',
//                               false, false, _width * 0.1, 0),
//                           SizedBox(
//                             width: _width * 0.05,
//                           ),
//                           username(Icons.account_circle_outlined, 'Last Name',
//                               false, false, 0, _width * 0.1),
//                         ],
//                       ),
//                       phoneno(_width * 0.1),
//                       SizedBox(
//                         height: _height * 0.2,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           HapticFeedback.lightImpact();
//                           // Fluttertoast.showToast(
//                           //   msg: 'SIGN-IN button pressed',
//                           // );
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const SignUpOtpPage()));
//                         },
//                         child: Container(
//                           height: _width * .1,
//                           width: _width * .4,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 5, 249, 0),
//                               borderRadius: BorderRadius.circular(20)),
//                           child: const Text(
//                             'SIGN-UP',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   //Vedant

//   Widget username(IconData icon, String hintText, bool isPassword, bool isEmail,
//       double left, double right) {
//     double _width = MediaQuery.of(context).size.width;
//     return Expanded(
//       child: Container(
//         height: _width * 0.14,
//         // width: _width * 0.4,
//         alignment: Alignment.center,
//         margin: EdgeInsets.fromLTRB(left, 0, right, 0),
//         padding: EdgeInsets.only(right: _width * 0.05),
//         decoration: BoxDecoration(
//           color: const Color(0xff212428),
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: TextField(
//           style: TextStyle(color: Colors.white.withOpacity(.9)),
//           obscureText: isPassword,
//           keyboardType:
//               isEmail ? TextInputType.emailAddress : TextInputType.text,
//           decoration: InputDecoration(
//             prefixIcon: Icon(
//               icon,
//               color: Colors.white.withOpacity(.7),
//             ),
//             border: InputBorder.none,
//             hintMaxLines: 1,
//             hintText: hintText,
//             hintStyle: TextStyle(
//               fontSize: 14,
//               color: Colors.white.withOpacity(.5),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget phoneno(double horizontal) {
//     double _width = MediaQuery.of(context).size.width;
//     return Container(
//       height: _width * 0.14,
//       // width: _width / 1.2, // Set the width to match the username widget
//       alignment: Alignment.center,
//       margin: EdgeInsets.fromLTRB(horizontal, 0, horizontal, 0),
//       // padding: EdgeInsets.only(right: _width * 0.1),
//       decoration: BoxDecoration(
//         color: const Color(0xff212428),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Expanded(
//         child: IntlPhoneField(
//           decoration: InputDecoration(
//             prefixIcon: Icon(
//               Icons.phone_android_rounded,
//               color: Colors.white,
//             ),
//             border: InputBorder.none,
//             hintMaxLines: 1,
//             hintText: "Enter Phone Number",
//             hintStyle: TextStyle(
//               fontSize: 14,
//               color: Colors.white.withOpacity(.5),
//             ),
//           ),
//           initialCountryCode: 'IN', // Set the initial country code
//           onChanged: (phone) {
//             print(phone
//                 .completeNumber); // You can access the complete phone number here
//           },
//         ),
//       ),
//     );
//   }
// }

// class MyBehavior extends ScrollBehavior {
//   Widget buildViewportChrome(
//       BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }
// }
