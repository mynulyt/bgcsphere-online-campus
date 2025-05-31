import 'dart:io';
import 'package:bgcsphere/pages/blood_details.dart';
import 'package:bgcsphere/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  File? _profileImage;
  String? _profileImageUrl;
  String? _name;
  String? _email;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        setState(() {
          _name = userDoc['name'];
          _email = userDoc['email'];
          _profileImageUrl = userDoc['profileImageUrl'];
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      await _uploadProfileImage();
    }
  }

  Future<void> _uploadProfileImage() async {
    if (_profileImage == null || _auth.currentUser == null) return;

    setState(() => _isLoading = true);

    try {
      // Upload image to Firebase Storage
      final ref =
          _storage.ref().child('profile_images/${_auth.currentUser!.uid}.jpg');
      await ref.putFile(_profileImage!);

      // Get download URL
      final imageUrl = await ref.getDownloadURL();

      // Update Firestore with new image URL
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'profileImageUrl': imageUrl,
      });

      setState(() {
        _profileImageUrl = imageUrl;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateProfile() async {
    if (_auth.currentUser == null) return;

    setState(() => _isLoading = true);

    try {
      // Show dialog to get updated name
      final newName = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Update Profile'),
          content: TextField(
            controller: TextEditingController(text: _name),
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, _name);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );

      if (newName != null && newName.isNotEmpty) {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({
          'name': newName,
        });

        setState(() {
          _name = newName;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget buildProfileButton(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF768FCF)),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!) as ImageProvider
                          : (_profileImageUrl != null
                                  ? NetworkImage(_profileImageUrl!)
                                  : const AssetImage("images/profile.jpg"))
                              as ImageProvider,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text('Take Photo'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('Choose from Gallery'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImage(ImageSource.gallery);
                                },
                              ),
                            ],
                          ),
                        );
                      },
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
                  _name ?? 'No Name',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF768FCF)),
                ),
                const SizedBox(height: 4),
                Text(
                  _email ?? 'No Email',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                buildProfileButton(
                    "Update Profile", Icons.edit, _updateProfile),
                buildProfileButton("Blood Details", Icons.bloodtype, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BloodDetails()),
                  );
                }),
                buildProfileButton("Contact", Icons.phone, () {}),
                buildProfileButton("Share App", Icons.share, () {}),
                buildProfileButton("Help", Icons.help_outline, () {}),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    await _auth.signOut();
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
