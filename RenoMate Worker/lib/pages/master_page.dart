import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:renomateworker/controllers/master_page_controller.dart';
import 'package:renomateworker/pages/settings_page.dart';
import 'package:renomateworker/pages/user_profile_page.dart';
import 'package:renomateworker/pages/work_find_page.dart';
import 'package:renomateworker/pages/work_page.dart';
import 'package:renomateworker/pages/home_page.dart';
import 'package:renomateworker/theme.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({super.key});

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  final MasterPageController controller = Get.put(MasterPageController());

  @override
  Widget build(BuildContext context) {
    List pages = [
      WorkFindPage(),
      HomePage(),
      SettingsPage(onThemeToggle: () => setState(() {})),
      UserProfilePage(() => controller.changeIndex(1)),
    ];

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
        surfaceTintColor: MyTheme.accent,
        centerTitle: true,
      ),
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          color: MyTheme.accent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: GNav(
              backgroundColor: MyTheme.accent,
              selectedIndex: controller.currentIndex.value,
              color: MyTheme.background,
              activeColor: MyTheme.primary,
              tabBackgroundColor: MyTheme.background,
              padding: const EdgeInsets.all(8),
              gap: 20,
              onTabChange: (index) {
                controller.changeIndex(index);
              },
              tabs: const [
                GButton(
                  icon: Icons.watch_later,
                  text: "Find Work",
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
      ),
    );
  }
}
