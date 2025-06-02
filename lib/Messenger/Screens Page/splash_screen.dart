import 'package:bgcsphere/Messenger/Screens%20Page/Auth/login_screen.dart';
import 'package:bgcsphere/Messenger/Screens%20Page/home_screen.dart';
import 'package:bgcsphere/Messenger/api/apis.dart';
import 'package:bgcsphere/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            statusBarColor: Colors.white),
      );

      if (Apis.auth.currentUser != null) {
        debugPrint('User: ${Apis.auth.currentUser}');
        debugPrint('UserAdditionalInfo: ${Apis.auth.currentUser}');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Welcome Chat of Duty"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset("images/icon.png"),
          ),
          Positioned(
              bottom: mq.height * .10,
              width: mq.width,
              child: const Center(
                  child: Text(
                "Developed By Mynul Alam",
                style: TextStyle(color: Colors.black),
              ))),
        ],
      ),
    );
  }
}
