import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/colors.dart';

import '../../../const/images.dart';
import '../../authentication/Auth_Screen/screen/login_screen.dart';
import 'payment_approvalse.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      backgroundColor: bgColor2,
      appBar: AppBar(
        backgroundColor: bgColor2,
        automaticallyImplyLeading: false,
        title: Text("Admin Dashboard"),
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Get.offAll(()=>LoginScreen());
            box.remove("user");
          }, icon: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                //side: BorderSide(color: Colors.redAccent)
              ),
              color: Colors.redAccent,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.logout_outlined),
              )),)
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(style: ElevatedButton.styleFrom(),onPressed: (){
                    Get.to(()=>PaymentApprovals());
                  }, child: Text("Payment Approvals")),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width*0.4,
                        child: Text("data"),
                      ),
                    ),
                    Card(
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width*0.4,
                        child: Text("data"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
