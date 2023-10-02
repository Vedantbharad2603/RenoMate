import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:renomate/pages/home_page.dart';
import 'package:renomate/pages/profile_page.dart';
import 'package:renomate/theme/colors.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({super.key});

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  int currIndex = 1;
  List pages = [
    const HomePage(),
    const HomePage(),
    const ProfilePage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          // "RenoMate",
          "R E N O M A T E",
          style: TextStyle(
            // fontSize: 30,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: MyTheme.accent,
        centerTitle: true,
      ),
      body: pages[currIndex],
      bottomNavigationBar: Container(
        color: MyTheme.accent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: GNav(
            backgroundColor: MyTheme.accent,
            selectedIndex: 1,
            color: MyTheme.background,
            activeColor: const Color.fromARGB(255, 5, 249, 0),
            tabBackgroundColor: MyTheme.background,
            padding: const EdgeInsets.all(8),
            gap: 20,
            onTabChange: (index) {
              currIndex = index;
              setState(() {});
            },
            tabs: const [
              GButton(
                icon: Icons.watch_later,
                text: "My Work",
              ),
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
              ),
              GButton(
                icon: Icons.person,
                text: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
