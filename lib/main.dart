import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/bloc/firebase_api.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/auth_screens/choose_screen.dart';
import 'package:tutor_kit/screens/auth_screens/login_screen.dart';
import 'package:tutor_kit/screens/auth_screens/otp_screen.dart';
import 'package:tutor_kit/screens/auth_screens/phone_screen.dart';
import 'package:tutor_kit/screens/auth_screens/sign_up_screen.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_home.dart';
import 'package:tutor_kit/screens/home_screen/teacher/post_details_screen.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_form_screens.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_home.dart';

Future<void> _firebaseMessagingBackgroundHandler (RemoteMessage message)async{
  print("Handling a bg message : ${message.messageId}");
}

void main() async{









  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance;
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await FirebaseAPI().initNotifications();
  await GetStorage.init();
  print("connected");

  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  runApp(const MyApp());
}
// class App extends StatelessWidget {
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp()
//   const App({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final isExist = box.read("userPhone");
    final _user = box.read("user");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tutor Kit',
      theme: ThemeData(
        fontFamily: "Kohinoor",
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: bgColor,
        )
      ),

      home:
      // FirebaseAuth.instance.currentUser != null ? TeacherHome() : LoginScreen(),
      FirebaseAuth.instance.currentUser != null  ? (_user == "gd"? GuardianHome() : TeacherHome()) : ChooseScreen(),

    );
  }
}

