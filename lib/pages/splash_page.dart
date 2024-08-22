import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/onboarding');
    });

    return Scaffold(
      backgroundColor: Color(0xFF0D6EFD),
      body: Center(
        child: Image.asset(
          'assets/images/NikeLogo.png',
          height: 160,
          width: 160,
        ),
      ),
    );
  }
}
