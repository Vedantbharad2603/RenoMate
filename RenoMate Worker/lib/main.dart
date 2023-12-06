import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:renomateworker/firebase/firebase_options.dart';
import 'package:renomateworker/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:renomateworker/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MyTheme.init();
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
      title: 'RenoMate Worker',
      builder: EasyLoading.init(),
      theme: ThemeData(brightness: Brightness.dark),
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: SplashScreen(),
    //   title: 'RenoMate Worker',
    //   builder: EasyLoading.init(),
    // );
  }
}
