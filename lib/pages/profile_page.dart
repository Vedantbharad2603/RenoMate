import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:renomate/pages/sign_in_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff292C31),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              //Page Name
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: const Text(
                      "My Profile",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.asset(
                        "assets/images/logos/logo_main_white.svg",
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      children: [
                        Text(
                          "User Name",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 5, 250, 0),
                          ),
                        ),
                        Text(
                          "+91 1010101010",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(118, 118, 118, 1),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget horizontalLine() {
    return const SizedBox(
      height: 1,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromRGBO(118, 118, 118, 1),
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
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    description,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(118, 118, 118, 1),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 30,
              // alignment: Alignment.centerRight,
              child: const Text(
                ">",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
