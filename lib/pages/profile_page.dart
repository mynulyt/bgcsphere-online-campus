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
  final TextEditingController _passwordController = TextEditingController();
  bool _isDeleting = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile picture: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
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

  Future<void> _showDeleteAccountDialog() async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'This will permanently delete your account and all data. To confirm, please enter your password:',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete Account'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      await _verifyAndDeleteAccount();
    }
  }

  Future<void> _verifyAndDeleteAccount() async {
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isDeleting = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.email != null) {
        // Re-authenticate user
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _passwordController.text,
        );

        await user.reauthenticateWithCredential(credential);
        await _deleteAccount();
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Authentication failed';
      if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password';
      } else if (e.code == 'user-mismatch' || e.code == 'user-not-found') {
        errorMessage = 'User not found';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'Invalid credentials';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Too many attempts. Try again later';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _passwordController.clear();
      setState(() {
        _isDeleting = false;
      });
    }
  }

  Future<void> _deleteAccount() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Delete profile picture from storage if exists
        if (profileImageUrl.isNotEmpty) {
          try {
            await FirebaseStorage.instance.refFromURL(profileImageUrl).delete();
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
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
          (route) => false,
        );
      }
    } catch (e) {
      print("Error deleting account: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete account: ${e.toString()}'),
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
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Icon(Icons.edit, size: 16, color: Colors.black),
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
              buildProfileButton("Settings", Icons.settings, () {
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
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.1),
                          foregroundColor: Colors.red,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed:
                            _isDeleting ? null : _showDeleteAccountDialog,
                        child: _isDeleting
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Delete Account',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xff768FCF),
                          side: const BorderSide(color: Color(0xff768FCF)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          if (!mounted) return;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Sign Out',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileButton(String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
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
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
