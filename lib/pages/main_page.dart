import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:bgcsphere/pages/category_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:bgcsphere/pages/clubs_page.dart';
import 'package:bgcsphere/pages/create_post_page.dart';
import 'package:bgcsphere/pages/newsfeed_page.dart';
import 'package:bgcsphere/pages/notifications_page.dart';
import 'package:bgcsphere/pages/profile_page.dart';
import 'package:bgcsphere/pages/set_images.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  String? _profileImageUrl;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;
        final docSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (docSnapshot.exists &&
            docSnapshot.data()!.containsKey('profile_picture')) {
          setState(() {
            _profileImageUrl = docSnapshot.data()!['profile_picture'];
          });
        }
      }
    } catch (e) {
      print("Error fetching profile image: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewsfeedPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationsPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffA2ACE0).withOpacity(0.13),
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0, left: 5, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Welcome",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 5),
              Text(
                "BGCSPHERE",
                style: TextStyle(fontSize: 18, color: Color(0xff6677CC)),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                backgroundImage: _profileImageUrl != null
                    ? NetworkImage(_profileImageUrl!)
                    : const AssetImage("images/profile.jfif") as ImageProvider,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 5, right: 10, left: 20, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreatePostPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Text(
                        "What is in your mind?",
                        style: TextStyle(
                          color: Color(0xff24293E),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xff768FCF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoryPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SetImages(),
              const SizedBox(height: 16),
              HomeItems(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _selectedIndex,
        height: 60.0,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.article, size: 30, color: Colors.white),
          Icon(Icons.notifications, size: 30, color: Colors.white),
        ],
        color: const Color(0xff6677CC),
        buttonBackgroundColor: const Color(0xff6677CC),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: _onItemTapped,
        letIndexChange: (index) => true,
      ),
    );
  }
}
