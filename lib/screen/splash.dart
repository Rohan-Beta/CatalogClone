import 'package:animated_splash_screen/animated_splash_screen.dart';
// ignore: unused_import
import 'package:catalog_clone/screen/routes.dart';
import 'package:catalog_clone/screen/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Icon(
          CupertinoIcons.shopping_cart,
          color: context.theme.hintColor,
          size: 50,
        ),
        nextScreen: const SignIn(),
        backgroundColor: context.theme.canvasColor,
      ),
      //Center(
      // child: Text(
      //   "Catalog_Clone",
      //   style: TextStyle(fontSize: 20),
      // ),
      //),
    );
  }
}
