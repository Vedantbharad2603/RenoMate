import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renomateclient/temp/sign_in_page%20copy.dart';
import 'package:renomateclient/theme.dart';
import 'package:renomateclient/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageController extends GetxController {
  late BuildContext context;

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await SharedPreferences.getInstance().then((prefs) {
        prefs.clear();

        // Clear the entire Navigator stack and navigate to SignInPage
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => SignInPage(),
          ),
          (route) => false, // This will remove all routes from the stack
        );
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, "Logout failed");
      log("Error logging out: $e");
    }
  }

  void changeTheme(VoidCallback? onThemeToggle) {
    MyTheme.toggleTheme;
    onThemeToggle?.call();
  }
}
