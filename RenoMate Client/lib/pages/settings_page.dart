import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renomateclient/controllers/settings_page_controller.dart';
import 'package:renomateclient/pages/sign_in_page.dart';
import 'package:renomateclient/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  final VoidCallback? onThemeToggle;
  SettingsPage({Key? key, this.onThemeToggle}) : super(key: key);

  final SettingsPageController controller = Get.put(SettingsPageController());

  bool isDarkMode = MyTheme.background == Colors.black;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            //Page Name
            Padding(
              padding: EdgeInsets.all(_width * 0.02),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  child: Text(
                    "Settings",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: _width * 0.08,
                      fontWeight: FontWeight.w600,
                      color: MyTheme.text,
                    ),
                  ),
                ),
              ),
            ),
            settingsCard(
              title: "Change Theme",
              onClick: () {
                MyTheme.toggleTheme;
                // setState(() {});
                onThemeToggle?.call();
              },
            ),
            horizontalLine(),
            settingsCard(
              title: "Notifications",
              onClick: () {},
            ),
            horizontalLine(),
            settingsCard(
              title: "Vibration",
              onClick: () {},
            ),
            horizontalLine(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyTheme.accent,
                  minimumSize: const Size(double.maxFinite, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                ),
                onPressed: () {
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.clear();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ),
                      (route) => false,
                    );
                  });
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: MyTheme.title,
                  ),
                ),
              ),
            ),
            // settingsCard(
            //   title: "Logout",
            //   onClick: () {},
            // ),
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

  Widget settingsCard({required String title, VoidCallback? onClick}) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Card(
        color: MyTheme.accent,
        surfaceTintColor: MyTheme.accent,
        child: Theme(
          data: ThemeData(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: MyTheme.text,
              ),
            ),
            iconColor: MyTheme.title,
            collapsedIconColor: MyTheme.title,
            backgroundColor: MyTheme.accent,
            collapsedBackgroundColor: MyTheme.accent,
            maintainState: true,
            onExpansionChanged: (bool expanded) {
              // if (expanded) {
              //   onClick?.call();
              // }
            },
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title == "Change Theme") themeSwitch(onClick),
                    if (title == "Notifications") notificationSwitch(onClick),
                    if (title == "Vibration") vibrationSwitch(onClick),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget themeSwitch(VoidCallback? onThemeToggle) {
    return Row(
      children: [
        Text(
          "Dark Mode",
          style: TextStyle(color: MyTheme.text, fontWeight: FontWeight.bold),
        ),
        Switch(
          value: isDarkMode,
          onChanged: (value) {
            onThemeToggle?.call();
          },
        ),
      ],
    );
  }

  Widget notificationSwitch(VoidCallback? onToggle) {
    return Row(
      children: [
        Text(
          "Notifications",
          style: TextStyle(color: MyTheme.text, fontWeight: FontWeight.bold),
        ),
        Obx(
          () => Switch(
            value: controller.isNotificationsMute.value,
            onChanged: (value) {
              controller.isNotificationsMute.value = value;
              onToggle?.call();
            },
          ),
        ),
      ],
    );
  }

  Widget vibrationSwitch(VoidCallback? onToggle) {
    return Row(
      children: [
        Text(
          "Vibration",
          style: TextStyle(color: MyTheme.text, fontWeight: FontWeight.bold),
        ),
        Obx(
          () => Switch(
            value: controller.isVibrationHard.value,
            onChanged: (value) {
              controller.isVibrationHard.value = value;
              onToggle?.call();
            },
          ),
        ),
      ],
    );
  }
}

// class SettingsCard extends StatelessWidget {
//   final String title;
//   final VoidCallback? onClick;

//   const SettingsCard({
//     Key? key,
//     required this.title,
//     this.onClick,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       margin: const EdgeInsets.fromLTRB(5, 10, 0, 5),
//       child: Card(
//         child: Theme(
//           data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//           child: ExpansionTile(
//             title: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.w600,
//                 color: MyTheme.title,
//               ),
//             ),
//             iconColor: MyTheme.title,
//             collapsedIconColor: MyTheme.title,
//             onExpansionChanged: (bool expanded) {
//               // if (expanded) {
//               //   onClick?.call();
//               // }
//             },
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (title == "Change Theme")
//                       ThemeSwitch(onThemeToggle: onClick),
//                     if (title == "Notifications")
//                       NotificationSwitch(onToggle: onClick),
//                     if (title == "Vibration")
//                       VibrationSwitch(onToggle: onClick),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ThemeSwitch extends StatelessWidget {
//   final VoidCallback? onThemeToggle;

//   const ThemeSwitch({Key? key, this.onThemeToggle}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = MyTheme.background == Colors.black;

//     return Row(
//       children: [
//         Text("Dark Mode"),
//         Switch(
//           value: isDarkMode,
//           onChanged: (value) {
//             onThemeToggle?.call();
//           },
//         ),
//       ],
//     );
//   }
// }

// class NotificationSwitch extends StatelessWidget {
//   final VoidCallback? onToggle;

//   const NotificationSwitch({Key? key, this.onToggle}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Implement your notification switch
//     bool isNotificationsMute = false;

//     return Row(
//       children: [
//         const Text("Notifications"),
//         Switch(
//           value: isNotificationsMute,
//           // Add your switch logic
//           onChanged: (value) {
//             isNotificationsMute = !isNotificationsMute;
//             onToggle?.call();
//           },
//         ),
//       ],
//     );
//   }
// }

// class VibrationSwitch extends StatelessWidget {
//   final VoidCallback? onToggle;

//   const VibrationSwitch({Key? key, this.onToggle}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool isVibrationHard = false;
//     // Implement your vibration switch
//     return Row(
//       children: [
//         const Text("Vibration"),
//         Switch(
//           value: isVibrationHard,
//           // Add your switch logic
//           onChanged: (value) {
//             onToggle?.call();
//           },
//         ),
//       ],
//     );
//   }
// }
