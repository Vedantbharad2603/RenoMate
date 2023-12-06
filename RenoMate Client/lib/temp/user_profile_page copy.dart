import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:renomateclient/controllers/user_profile_page_controller.dart';
import 'package:renomateclient/pages/edit_address_page.dart';
import 'package:renomateclient/pages/edit_user_profile_page.dart';
import 'package:renomateclient/pages/work_page.dart';
import 'package:renomateclient/theme.dart';

class UserProfilePage extends StatelessWidget {
  final void Function() mywork;
  UserProfilePage(this.mywork, {super.key});

  final UserProfilePageController controller =
      Get.put(UserProfilePageController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyTheme.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                //Page Name
                Padding(
                  // padding: const EdgeInsets.all(25.0),
                  padding: EdgeInsets.all(width * 0.06),
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      child: Text(
                        "My Profile",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          // fontSize: 35,
                          fontSize: width * 0.09,
                          fontWeight: FontWeight.w600,
                          color: MyTheme.text,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        // radius: 48,
                        radius: width * 0.1,
                        backgroundColor: Colors.transparent,
                        child: SvgPicture.asset(
                          "assets/images/logos/logo_main_white.svg",
                        ),
                      ),
                      const SizedBox(
                        // width: 10,
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.1),
                            child: Column(
                              children: [
                                Text(
                                  "User Name",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    // fontSize: 30,
                                    fontSize: width * 0.08,
                                    fontWeight: FontWeight.w600,
                                    color: MyTheme.primary,
                                  ),
                                ),
                                const SizedBox(
                                  // width: 10,
                                  height: 10,
                                ),
                                Text(
                                  "+91 1010101010",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    // fontSize: 15,
                                    fontSize: width * 0.03,
                                    fontWeight: FontWeight.w600,
                                    // color: Color.fromRGBO(118, 118, 118, 1),
                                    color: MyTheme.description,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.05),
                            child: Container(
                              width: 30,
                              // alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditUserProfilePage()),
                                  );
                                },
                                child: Icon(
                                  Icons.edit,
                                  size: width * 0.05,
                                  color: MyTheme.title,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  // height: 30,
                  height: width * 0.02,
                ),
                horizontalLine(),
                card("My Work", "Temp text for my work", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkPage(),
                      ));
                }),
                horizontalLine(),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: MyTheme.title,
                              ),
                            ),
                            Text(
                              "Block no. 69",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: MyTheme.description,
                              ),
                            ),
                            Text(
                              "Block no. 69",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: MyTheme.description,
                              ),
                            ),
                            Text(
                              "Rajkot",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: MyTheme.description,
                              ),
                            ),
                            Text(
                              "Gujarat",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: MyTheme.description,
                              ),
                            ),
                            Text(
                              "360007",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: MyTheme.description,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 30,
                        // alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditAddressPage()),
                            );
                          },
                          child: Icon(
                            Icons.edit,
                            size: width * 0.05,
                            color: MyTheme.title,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                horizontalLine(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget horizontalLine() {
    return SizedBox(
      height: 1,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: MyTheme.accent,
        ),
      ),
    );
  }

  Widget card(String title, String description, VoidCallback? onClick) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: MyTheme.title,
                    ),
                  ),
                  Text(
                    description,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: MyTheme.description,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30,
              // alignment: Alignment.centerRight,
              child: Icon(
                Icons.chevron_right,
                color: MyTheme.title,
                size: 36,
              ),
              // child: Text(
              //   ">",
              //   textAlign: TextAlign.left,
              //   style: TextStyle(
              //     fontSize: 35,
              //     fontWeight: FontWeight.w600,
              //     color: MyTheme.title,
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget card(String title, String description, VoidCallback? onClick) {
  //   return InkWell(
  //     onTap: onClick,
  //     child: Container(
  //       margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   title,
  //                   textAlign: TextAlign.left,
  //                   style: TextStyle(
  //                     fontSize: 25,
  //                     fontWeight: FontWeight.w600,
  //                     color: MyTheme.title,
  //                   ),
  //                 ),
  //                 Text(
  //                   description,
  //                   textAlign: TextAlign.left,
  //                   style: TextStyle(
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.w600,
  //                     color: MyTheme.description,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             width: 30,
  //             // alignment: Alignment.centerRight,
  //             child: Text(
  //               ">",
  //               textAlign: TextAlign.left,
  //               style: TextStyle(
  //                 fontSize: 35,
  //                 fontWeight: FontWeight.w600,
  //                 color: MyTheme.title,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
