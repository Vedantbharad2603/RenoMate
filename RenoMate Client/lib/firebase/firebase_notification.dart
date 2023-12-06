import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotification {
  static late final FirebaseMessaging fmc;

  static Future<void> init() async {
    fmc = FirebaseMessaging.instance;

    await fmc.requestPermission(provisional: true);

    fmc.onTokenRefresh.listen((fcmToken) {
      log("log onTokenRefresh: $fcmToken");
      print("print onTokenRefresh: $fcmToken");
    }).onError((err) {
      log("log onTokenRefresh: $err");
      print("print onTokenRefresh: $err");
    });
  }

  static Future<void> getFMCToken() async {
    log("log Hii Meet");
    print("print Hii Meet");

    await fmc.getToken().then((value) {
      log("log getToken: ${value!}");
      print("print getToken: ${value!}");
    });
  }

  // static Future<void> sendNotification() {
  // }
}
