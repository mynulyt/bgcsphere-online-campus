import 'dart:developer';
import 'dart:io';

import 'package:bgcsphere/Messenger/model/message.dart';
import 'package:bgcsphere/Messenger/model/user_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';

class Apis {
  // Firebase authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // Firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Firestore database storaeg
  static FirebaseStorage storage = FirebaseStorage.instance;

  // Current user
  static User get user => auth.currentUser!;

  // Late variable for storing user information
  static late ChatUser me;

  //For push notification
  static FirebaseMessaging Fmessaging = FirebaseMessaging.instance;

  //for sending push notification
  static Future<void> sendNotification() async {
    var url = Uri.https('example.com', 'whatsit/create');
    var response = await post(url, body: {'name': 'doodle', 'color': 'blue'});
    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
  }

  //For getting firebase messaging token
  static Future<void> getFirebaseMessafingToken() async {
    await Fmessaging.requestPermission();
    await Fmessaging.getToken().then((t) {
      if (t != null) {
        me.pushToken = t;
        log('Push Token: $t');
      }
    });
  }

  // Check if the user exists in Firestore
  static Future<bool> userExits() async {
    return (await firestore.collection('userss').doc(user.uid).get()).exists;
  }

  // Get self information
  static Future<void> getSelfInfo() async {
    final doc = await firestore.collection('userss').doc(user.uid).get();
    if (doc.exists) {
      me = ChatUser.fromJson(doc.data()!);
      await getFirebaseMessafingToken();
      Apis.updateActiveStatus(true);
      log('User data loaded: ${doc.data()}');
    } else {
      await createUser();
      await getSelfInfo();
    }
  }

  // Create a new user in Firestore
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
      image: user.photoURL.toString(),
      about: "Hey, I'm using Chat of Duty!",
      name: user.displayName.toString(),
      createdAt: time,
      isOnline: false,
      id: user.uid,
      lastActive: time,
      email: user.email.toString(),
      pushToken: '',
    );
    await firestore.collection('userss').doc(user.uid).set(chatUser.toJson());
  }

  // Stream for getting all users except the current user
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('userss')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

//for updata userinfo
  static Future<void> updateUserInfo({String? name, String? about}) async {
    final data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (about != null) data['about'] = about;

    await firestore.collection('userss').doc(user.uid).update(data);
  }

// Corrected function name from upadateProfilePic to updateProfilePic
  static Future<void> updateProfilePic(File file) async {
    try {
      final ext = file.path.split('.').last; // Extract file extension
      log('Extension: $ext');

      // Reference to the Firebase Storage location
      final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');

      // Upload the file
      final uploadTask =
          await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));
      final downloadUrl = await ref.getDownloadURL();

      log('File uploaded successfully, URL: $downloadUrl');

      // Update user profile image URL in Firestore
      await firestore
          .collection('userss')
          .doc(user.uid)
          .update({'image': downloadUrl});

      // Update the local user object
      me.image = downloadUrl;

      log('Profile picture updated successfully.');
    } catch (e) {
      log('Error updating profile picture: $e');
      rethrow;
    }
  }

//for getting specific user infi
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUser chatUser) {
    return firestore
        .collection('userss')
        .where('id', isNotEqualTo: chatUser.id)
        .snapshots();
  }

//for update online or last active status of user
  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('userss').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  // For conversation id
  static String getConversationId(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

//chat screen related database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getALMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationId(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  //for sending message
  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    //for sending time
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    //for message to send
    final Message message = Message(
        msg: msg,
        read: '',
        toId: chatUser.id,
        type: type,
        sent: time,
        fromId: user.uid);
    final ref = firestore
        .collection('chats/${getConversationId(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  //for update user read message
  static Future<void> UpdateMessageReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationId(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //For last message
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationId(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //for send chat image
  static Future<void> sendChatImages(ChatUser chatUser, File file) async {
    final ext = file.path.split('.').last; // Extract file extension

    // Reference to the Firebase Storage location
    final ref = storage.ref().child(
        'images/${getConversationId(chatUser.id)}/${DateTime.now().microsecondsSinceEpoch}.$ext');

    // Upload the file
    final uploadTask =
        await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));
    final downloadUrl = await ref.getDownloadURL();

    final imageUrl = downloadUrl;

    await sendMessage(chatUser, imageUrl, Type.image);
  }
}
