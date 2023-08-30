import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/screens/auth_screens/phone_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text("Logout"),
          IconButton(onPressed: (){
            Get.offAll(()=>PhoneScreen());
            box.remove("userPhone");
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text("Profile Screen"),
      ),
    );
  }
}
