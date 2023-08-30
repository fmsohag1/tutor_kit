import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/screens/auth_screens/choose_screen.dart';

import '../auth_screens/phone_screen.dart';

class TeacherProfile extends StatelessWidget {
   TeacherProfile({super.key});
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar :AppBar(
        actions: [
          Text("Logout"),
          IconButton(onPressed: (){
            Get.offAll(()=>ChooseScreen());
            box.remove("userPhone");
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text("Techer Profile"),
      ),
    );
  }
}
