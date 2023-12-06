import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:renomateclient/firebase/firebase_notification.dart';
import 'package:renomateclient/firebase/firebase_options.dart';
import 'package:renomateclient/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:renomateclient/theme.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MyTheme.init();
  // await FirebaseNotification.init();
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.custom
    ..progressColor = MyTheme.primary
    ..backgroundColor = MyTheme.backgroundSecondry
    ..indicatorColor = MyTheme.primary
    ..textColor = MyTheme.primary
    ..maskColor = MyTheme.background.withOpacity(0.7)
    ..maskType = EasyLoadingMaskType.custom
    ..userInteractions = false
    ..dismissOnTap = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      title: 'RenoMate Client',
      builder: EasyLoading.init(),
      theme: ThemeData(brightness: Brightness.dark),
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: SplashScreen(),
    //   title: 'RenoMate Client',
    //   builder: EasyLoading.init(),
    // );
  }
}
