import 'package:bgcsphere/pages/blood_details.dart';
import 'package:bgcsphere/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bgcsphere/pages/assetpage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("images/profile.jpg"),
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: Icon(Icons.edit, size: 16, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            "Tasnova Hassan",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Color(0xFF768FCF)),
          ),
          const SizedBox(height: 4),
          const Text(
            "tasnovahassan@bgctub.ac.bd",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 30),
          buildProfileButton("Setting", Icons.settings, () {}),
          buildProfileButton("Contact", Icons.phone, () {}),
          buildProfileButton("Blood Details", Icons.bloodtype, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BloodDetails()),
            );
          }),
          buildProfileButton("Share App", Icons.share, () {}),
          buildProfileButton("Help", Icons.help_outline, () {}),
          const Spacer(),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false,
              );
            },
            child: const Text(
              "Sign Out",
              style: TextStyle(color: Color(0xff768FCF), fontSize: 24),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
