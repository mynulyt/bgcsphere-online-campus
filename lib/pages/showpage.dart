import 'package:flutter/material.dart';

class Showpage extends StatelessWidget {
  const Showpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff6677CC),
              Color.fromARGB(255, 184, 199, 216),
            ]),
      ),
      child: Center(child: Image.asset("images/bgcsphere.png")),
    );
  }
}
