import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:renomate/pages/sign_in_page.dart';
import 'package:renomate/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: const Color(0xff292C31),
      backgroundColor: MyTheme.background,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              //Page Name
              Padding(
                // padding: const EdgeInsets.all(25.0),
                padding: EdgeInsets.all(_height * 0.02),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: Text(
                      "My Profile",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        // fontSize: 35,
                        fontSize: _height * 0.04,
                        fontWeight: FontWeight.w600,
                        color: MyTheme.text,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                // padding: const EdgeInsets.only(left: 20),
                padding: EdgeInsets.only(left: _width * 0.05),
                child: Row(
                  children: [
                    CircleAvatar(
                      // radius: 48,
                      radius: _height * 0.057,
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.asset(
                        "assets/images/logos/logo_main_white.svg",
                      ),
                    ),
                    SizedBox(
                      // width: 10,
                      width: _width * 0.02,
                    ),
                    Column(
                      children: [
                        Text(
                          "User Name",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            // fontSize: 30,
                            fontSize: _height * 0.035,
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
                            fontSize: _height * 0.017,
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
                height: _height * 0.02,
              ),
              horizontalLine(),
              card("My Work", "Temp text for my work", () {}),
              horizontalLine(),
              card("My Review", "Temp text for review", () {}),
              horizontalLine(),
              card("Settings", "Theme,Notifications,vibration", () {}),
              horizontalLine(),
              card("Logout", "Logout from Renomate", () {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.clear();
                  // Clear the entire Navigator stack and navigate to SignInPage
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInPage(),
                    ),
                    (route) =>
                        false, // This will remove all routes from the stack
                  );
                });
              }),
              horizontalLine(),
              card("Change Theme", "Change Theme between Light and Dark Mode",
                  () {
                MyTheme.toggleTheme;
                setState(() {});
              }),
              horizontalLine(),
            ],
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
            Container(
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
