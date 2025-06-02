import 'dart:io';
import 'package:bgcsphere/pages/blood_details.dart';
import 'package:bgcsphere/pages/login.dart';
import 'package:bgcsphere/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Loading...';
  String email = 'Loading...';
  String profileImageUrl = '';
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;
        final doc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (doc.exists) {
          setState(() {
            name = doc['name'] ?? 'No Name';
            email = doc['email'] ?? 'No Email';
            profileImageUrl = doc['profile_picture'] ?? '';
          });
        } else {
          setState(() {
            name = 'User not found';
            email = '';
          });
        }
      }
    } catch (e) {
      setState(() {
        name = 'Error loading';
        email = '';
      });
      print("Error fetching user data: $e");
    }
  }

  Future<void> updateProfilePicture(ImageSource source) async {
    try {
      final pickedFile =
          await _picker.pickImage(source: source, imageQuality: 70);
      if (pickedFile == null) return;

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_pictures')
            .child('${user.uid}.jpg');
        await ref.putFile(File(pickedFile.path));
        final downloadURL = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'profile_picture': downloadURL,
        });

        setState(() {
          profileImageUrl = downloadURL;
        });
      }
    } catch (e) {
      print("Error updating profile picture: $e");
    }
  }

  void showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take Photo'),
            onTap: () {
              Navigator.pop(context);
              updateProfilePicture(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              updateProfilePicture(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount() async {
    try {
      // Show confirmation dialog
      bool confirmDelete = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Account'),
            content: const Text(
                'Are you sure you want to delete your account? This action cannot be undone.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child:
                    const Text('Delete', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );

      if (confirmDelete == true) {
        // Delete user data from Firestore
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Delete profile picture from storage if exists
          if (profileImageUrl.isNotEmpty) {
            try {
              await FirebaseStorage.instance
                  .refFromURL(profileImageUrl)
                  .delete();
            } catch (e) {
              print("Error deleting profile picture: $e");
            }
          }

          // Delete user document from Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .delete();

          // Delete user from Firebase Auth
          await user.delete();

          // Navigate to login screen
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false,
          );
        }
      }
    } catch (e) {
      print("Error deleting account: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting account: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl)
                      : const AssetImage("images/profile.jfif")
                          as ImageProvider,
                ),
                GestureDetector(
                  onTap: showImagePickerOptions,
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.edit, size: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Color(0xFF768FCF),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              email,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            buildProfileButton("Setting", Icons.settings, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            }),
            buildProfileButton("Contact", Icons.phone, () {}),
            buildProfileButton("Blood Details", Icons.bloodtype, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BloodDetails()),
              );
            }),
            buildProfileButton("Share App", Icons.share, () {}),
            buildProfileButton("Help", Icons.help_outline, () {}),

            SizedBox(
              height: 200.0,
            ),

            // Delete Account Button
            TextButton(
              onPressed: _deleteAccount,
              child: const Text(
                "Delete Account",
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
            // Sign Out Button
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
      ),
    );
  }

  Widget buildProfileButton(String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF768FCF)),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
