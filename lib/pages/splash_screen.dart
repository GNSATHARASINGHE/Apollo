//import 'dart:html';

import 'package:apollodemo1/pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.of(context)
          .pushReplacement(CupertinoPageRoute(builder: (ctx) => AuthPage()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: [
            Center(
                child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.none,
            )

                //fit: BoxFit.contain,
                ),
            const Positioned.fill(
              top: 50,
              child: SpinKitWave(
                color: Color.fromARGB(255, 251, 215, 58),
                size: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
