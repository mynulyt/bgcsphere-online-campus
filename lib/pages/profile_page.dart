import 'package:flutter/material.dart';

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

          // Buttons
          _buildProfileButton("Setting", Icons.settings),
          _buildProfileButton("Contact", Icons.phone),
          _buildProfileButton("Share App", Icons.share),
          _buildProfileButton("Help", Icons.help_outline),

          const Spacer(),

          TextButton(
            onPressed: () {
              print("Button Click");
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

  Widget _buildProfileButton(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade100),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: ListTile(
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          leading: Icon(icon, color: Colors.blue),
          onTap: () {},
        ),
      ),
    );
  }
}
