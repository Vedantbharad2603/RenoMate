//TODO by 12/10/23
//we need to make complete ui
//and APIs

import 'package:RenoMate/pages/SignUpPage.dart';
import 'package:RenoMate/pages/starterpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RenoMate',
      debugShowCheckedModeBanner: false,
      // home: SignUpPage(),
      home: SecondClass(),
    );
  }
}
