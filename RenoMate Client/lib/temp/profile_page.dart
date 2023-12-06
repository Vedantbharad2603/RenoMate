import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:renomateclient/controllers/profile_page_controller.dart';
import 'package:renomateclient/theme.dart';

class ProfilePage extends StatelessWidget {
  final VoidCallback? onThemeToggle;
  ProfilePage({Key? key, this.onThemeToggle}) : super(key: key);

  final ProfilePageController controller = Get.put(ProfilePageController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    controller.context = context;

    return Scaffold(
      // backgroundColor: const Color(0xff292C31),
      backgroundColor: MyTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            //Page Name
            Padding(
              // padding: const EdgeInsets.all(25.0),
              padding: EdgeInsets.all(height * 0.02),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "My Profile",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    // fontSize: 35,
                    fontSize: height * 0.04,
                    fontWeight: FontWeight.w600,
                    color: MyTheme.text,
                  ),
                ),
              ),
            ),
            Padding(
              // padding: const EdgeInsets.only(left: 20),
              padding: EdgeInsets.only(left: width * 0.05),
              child: Row(
                children: [
                  CircleAvatar(
                    // radius: 48,
                    radius: height * 0.057,
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset(
                      "assets/images/logos/logo_main_white.svg",
                    ),
                  ),
                  SizedBox(
                    // width: 10,
                    width: width * 0.02,
                  ),
                  Column(
                    children: [
                      Text(
                        "User Name",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          // fontSize: 30,
                          fontSize: height * 0.035,
                          fontWeight: FontWeight.w600,
                          // color: Color.fromARGB(255, 5, 250, 0),
                          color: MyTheme.primary,
                        ),
                      ),
                      Text(
                        "+91 1010101010",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          // fontSize: 15,
                          fontSize: height * 0.017,
                          fontWeight: FontWeight.w600,
                          // color: Color.fromRGBO(118, 118, 118, 1),
                          color: MyTheme.description,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              // height: 30,
              height: height * 0.02,
            ),
            horizontalLine(),
            card("My Work", "Temp text for my work", () {}),
            horizontalLine(),
            card("My Review", "Temp text for review", () {}),
            horizontalLine(),
            card("Settings", "Theme,Notifications,vibration", () {}),
            horizontalLine(),
            card("Logout", "Logout from Renomate", () {
              controller.logout();
            }),
            horizontalLine(),
            card("Change Theme", "Change Theme between Light and Dark Mode",
                () {
              controller.changeTheme(onThemeToggle);
            }),
            horizontalLine(),
          ],
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
              child: Text(
                ">",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: MyTheme.title,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
