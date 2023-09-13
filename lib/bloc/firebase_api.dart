import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;
  var users= FirebaseFirestore.instance.collection("users");
  var auth = FirebaseAuth.instance;
  Future<void> initNotifications()async{
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print("token : $fcmToken");
    users.doc().set({
      "userPhone" : auth.currentUser!.phoneNumber,
      "fcmToken" : fcmToken
    });
  }
}