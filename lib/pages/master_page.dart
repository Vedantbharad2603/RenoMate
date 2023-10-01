import 'package:flutter/material.dart';
import 'package:renomate/pages/home_page.dart';
import 'package:renomate/pages/profile_page.dart';

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
    const UserProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "RenoMate",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(118, 118, 118, 1),
        centerTitle: true,
      ),
      body: pages[currIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          unselectedFontSize: 12,
          backgroundColor: const Color.fromRGBO(118, 118, 118, 1),
          fixedColor: const Color.fromARGB(255, 5, 249, 0),
          // backgroundColor: Colors.black,
          currentIndex: currIndex,
          onTap: (index) {
            currIndex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.watch_later_outlined), label: "My Work"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined), label: "Profile"),
          ]),
    );
  }
}
