import 'package:bgcsphere/pages/welcomescreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff6677CC),
              Color.fromARGB(255, 184, 199, 216),
            ],
          ),
        ),
        child: Center(
          child: Image.asset(
            "images/bgcsphere.png",
            width: 180,
            height: 180,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
