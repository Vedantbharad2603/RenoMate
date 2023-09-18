import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyCustomLoginUI extends StatefulWidget {
  @override
  _MyCustomLoginUIState createState() => _MyCustomLoginUIState();
}

class _MyCustomLoginUIState extends State<MyCustomLoginUI>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: .7, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        },
      );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff292C31),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: _height,
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(),
                      const Text(
                        'SIGN IN TO',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 5, 249, 0),
                        ),
                      ),
                      const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          username(Icons.account_circle_outlined,
                              'Enter first name...', false, false),
                          const SizedBox(
                            width: 10,
                          ),
                          username(Icons.account_circle_outlined,
                              'Enter last name...', false, false),
                          const SizedBox(
                            width: 35,
                          ),
                        ],
                      ),
                      component1(Icons.email_outlined, 'Enter last name...',
                          false, true),
                      component1(
                          Icons.lock_outline, 'Password...', true, false),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Forgotten password!',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 5, 249, 0),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  HapticFeedback.lightImpact();
                                  Fluttertoast.showToast(
                                      msg:
                                          'Forgotten password! button pressed');
                                },
                            ),
                          ),
                          SizedBox(width: _width / 10),
                          RichText(
                            text: TextSpan(
                              text: 'Create a new Account',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 5, 249, 0)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  HapticFeedback.lightImpact();
                                  Fluttertoast.showToast(
                                    msg: 'Create a new Account button pressed',
                                  );
                                },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Center(
                        child: InkWell(
                          // splashColor: Colors.transparent,
                          // highlightColor: Colors.transparent,
                          onTap: () {
                            // HapticFeedback.lightImpact();
                            // Fluttertoast.showToast(
                            //   msg: 'SIGN-IN button pressed',
                            // );
                          },
                          child: Container(
                            height: _width * .1,
                            width: _width * .4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 5, 249, 0),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              'SIGN-IN',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _width / 8,
      width: _width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: _width / 30),
      decoration: BoxDecoration(
        color: const Color(0xff212428),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white.withOpacity(.9)),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.5),
          ),
        ),
      ),
    );
  }

  Widget username(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _width / 8,
      width: _width * 0.4,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: _width / 30),
      decoration: BoxDecoration(
        color: const Color(0xff212428),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white.withOpacity(.9)),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
