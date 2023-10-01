import 'dart:async';
import 'package:renomate/pages/master_page.dart';
import 'package:renomate/pages/sign_in_page.dart';
import 'package:renomate/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  double _opacity = 0;
  late BuildContext _context;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addStatusListener(
        (status) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool? isLogin = prefs.getBool('isLogin');
          if (status == AnimationStatus.completed) {
            Navigator.pushReplacement(
              _context,
              ThisIsFadeRoute(
                route: isLogin ?? false ? const MasterPage() : SignInPage(),
                page: isLogin ?? false ? const MasterPage() : SignInPage(),
              ),
            );
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(const Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    Timer(const Duration(milliseconds: 3000), () {
      setState(() {
        scaleController.forward();
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the animation controller and cancel the timer
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff292C31),
      body: Center(
        child: AnimatedOpacity(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(seconds: 6),
          opacity: _opacity,
          child: AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(seconds: 2),
            height: _width * .7,
            width: _width * .7,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff212428).withOpacity(.2),
                  blurRadius: 100,
                  spreadRadius: 10,
                ),
              ],
              color: const Color(0xff212428),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  child: SvgPicture.asset(
                    "assets/images/logos/logo_main_white.svg",
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedBuilder(
                  animation: scaleAnimation,
                  builder: (c, child) => Transform.scale(
                    scale: scaleAnimation.value,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 5, 250, 0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget page;
  final Widget route;

  ThisIsFadeRoute({required this.page, required this.route})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: route,
          ),
        );
}
