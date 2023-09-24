import 'dart:async';
import 'package:RenoMate/pages/SignInPage.dart';
import 'package:RenoMate/pages/SignUpPage.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpalshScreen extends StatefulWidget {
  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  double _opacity = 0;
  // bool _value = true;

  // Timer? _timer; // Declare a timer variable

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Navigator.of(context).pushReplacement(
              ThisIsFadeRoute(
                route: SignInPage(),
                page: SignInPage(),
              ),
            );
            // Timer(
            //   const Duration(milliseconds: 300),
            //   () {
            //     scaleController.reset();
            //   },
            // );
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(const Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
        // _value = false;
      });
    });

    // Create and start the timer
    // _timer = Timer(const Duration(milliseconds: 3000), () {
    //   setState(() {
    //     if (scaleController.status == AnimationStatus.completed) {
    //       scaleController.reset();
    //     }
    //   });
    // });

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
    // _timer?.cancel(); // Cancel the timer if it's still active
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xff292C31),
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
                  color: Color(0xff212428).withOpacity(.2),
                  blurRadius: 100,
                  spreadRadius: 10,
                ),
              ],
              color: Color(0xff212428),
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
