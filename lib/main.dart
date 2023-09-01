import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/auth_screens/choose_screen.dart';
import 'package:tutor_kit/screens/auth_screens/otp_screen.dart';
import 'package:tutor_kit/screens/auth_screens/phone_screen.dart';
import 'package:tutor_kit/screens/home_screen/guardian_home.dart';
import 'package:tutor_kit/screens/home_screen/posts_screen.dart';
import 'package:tutor_kit/screens/home_screen/teacher_home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  print("connected");
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
        fontFamily: kalpurush,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: bgColor,
        )
      ),

      home: isExist != null ? (_user == "gd"? GuardianHome() : TeacherHome()) : ChooseScreen(),
    );
  }
}

