import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_home.dart';

class GuardianFormScreen extends StatelessWidget {
  const GuardianFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    TextEditingController mobileController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: "Name"
                ),
              ),
              TextField(
                controller: mobileController,
                decoration: InputDecoration(
                  hintText: "Mobile No"
                ),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                    hintText: "Full Adsress"
                ),
              ),
              ElevatedButton(onPressed: (){
                var _auth = FirebaseAuth.instance;
                FirebaseFirestore.instance.collection("userInfo").doc(_auth.currentUser!.uid).update({
                  "mobile": mobileController.text,
                  "timestamp" : FieldValue.serverTimestamp(),
                  "address" : addressController.text,
                  "name" : nameController.text,
                });
                Get.to(()=>GuardianHome());
                box.write("user", "gd");
              }, child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
