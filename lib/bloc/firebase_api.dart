import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler (RemoteMessage message)async{
  print("Title : ${message.notification?.title}");
  print("Body : ${message.notification?.body}");
  print("Payload : ${message.data}");
}
class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;
  var users= FirebaseFirestore.instance.collection("users");
  var auth = FirebaseAuth.instance;
  Future<void> initNotifications()async{
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print("tokennnnnn : $fcmToken");
    FirebaseMessaging.onBackgroundMessage(await _firebaseMessagingBackgroundHandler);
    users.doc().set({
      "userPhone" : auth.currentUser!.phoneNumber,
      "fcmToken" : fcmToken
    });
  }
}