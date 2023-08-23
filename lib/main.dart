import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/auth_screens/phone_screen.dart';
import 'package:tutor_kit/screens/controller/authentication_repository.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("connected");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Tutor Kit',
      theme: ThemeData(
        fontFamily: roboto_regular,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: bgColor,
        )
      ),

      home: PhoneScreen()
    );
  }
}

