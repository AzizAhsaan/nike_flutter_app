import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nike_app/auth/auth_gate.dart';
import 'package:nike_app/pages/first_onboard_page.dart';
import 'package:nike_app/pages/login_page.dart';
import 'package:nike_app/pages/main_page.dart';
import 'package:nike_app/pages/onboard_page.dart';
import 'package:nike_app/pages/second_onboard_page.dart';
import 'package:nike_app/pages/splash_page.dart';
import 'package:nike_app/pages/third_onboard_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/onboarding': (context) => const OnboardingPage(),
        '/home': (context) => const AuthGate(),
      },
    );
  }
}
