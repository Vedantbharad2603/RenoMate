import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:renomateclient/controllers/user_profile_page_controller.dart';
import 'package:renomateclient/pages/edit_user_profile_page.dart';
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   // radius: 48,
                    //   radius: width * 0.1,
                    //   backgroundColor: Colors.transparent,
                    //   child: SvgPicture.asset(
                    //     "assets/images/logos/logo_main_white.svg",
                    //   ),
                    // ),
                    CircleAvatar(
                      minRadius: 36,
                      backgroundColor: MyTheme.button1,
                      child: Text(
                        controller.firstName[0] + controller.lastName[0],
                        style: TextStyle(
                          color: MyTheme.background,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      // width: 10,
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${controller.firstName} ${controller.lastName}",
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
                                controller.phoneNumber,
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
                          IconButton(
                            onPressed: () {
                              Get.to(EditUserProfilePage());
                            },
                            icon: Icon(
                              Icons.edit,
                              size: width * 0.05,
                              color: MyTheme.title,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  // height: 30,
                  height: width * 0.02,
                ),
                horizontalLine(),
                card("My Work", "Work created by you", () {
                  mywork();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => WorkPage(),
                  //     ));
                }),
                horizontalLine(),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 15, 15, 15),
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
                              controller.blockNo,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: MyTheme.description,
                              ),
                            ),
                            Text(
                              controller.streetName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: MyTheme.description,
                              ),
                            ),
                            Text(
                              controller.city,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: MyTheme.description,
                              ),
                            ),
                            Text(
                              controller.state,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: MyTheme.description,
                              ),
                            ),
                            Text(
                              controller.pincode,
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
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(
                      //     Icons.edit,
                      //     size: width * 0.05,
                      //     color: MyTheme.title,
                      //   ),
                      // ),
                      // Container(
                      //   width: 30,
                      //   // alignment: Alignment.centerRight,
                      //   child: InkWell(
                      //     onTap: () {},
                      //     child:
                      //   ),
                      // ),
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
            Icon(
              Icons.chevron_right,
              color: MyTheme.title,
              size: 36,
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
