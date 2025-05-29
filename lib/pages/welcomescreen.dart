import 'package:bgcsphere/pages/joinasscreen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.7,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(height: 90),
                const Text(
                  "BGC Trust university\nBangladesh",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: -0.002,
                    color: Color(0xff24293E),
                  ),
                ),
                const Text(
                  "Department of CSE",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff141466),
                    letterSpacing: -0.002,
                  ),
                ),
                Stack(
                  children: [
                    Center(
                        child: Image.asset(
                      'images/background.png',
                      height: 280,
                      width: 316,
                    )),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Image.asset(
                          'images/clubs.png',
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            width: 200,
            child: Center(
              child: Image.asset("images/bgcsphere.png"),
            ),
          ),
          const Text(
            "CSE Bonds Beyond\nCampus",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Color(0xff24293E)),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
                backgroundColor: const Color(0xff6677CC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const JoinAsScreen()));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Join now",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "By joining I agree to receive emails from BGCSphere.\nDeveloped by team Dev. with Titans",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Color(0xffA1A1A1)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
