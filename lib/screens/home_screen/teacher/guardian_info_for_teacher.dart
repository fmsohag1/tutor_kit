import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuardianInfoForTeacher extends StatelessWidget {
  const GuardianInfoForTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    var postId = Get.arguments;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection("posts").doc(postId).get(),
              builder: (BuildContext context,AsyncSnapshot <DocumentSnapshot>snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return FutureBuilder(
                      future: FirebaseFirestore.instance.collection("userInfo").where("email",isEqualTo: data["userEmail"]).get(),
                      builder: (BuildContext context,AsyncSnapshot <QuerySnapshot>detSnap){
                        if(detSnap.connectionState == ConnectionState.done){
                          // Map<String, dynamic> data = detSnap.data! as Map<String, dynamic>;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Guardian Info"),
                              Divider(),
                              Text(detSnap.data!.docs.first["email"]),
                              Text(detSnap.data!.docs.first["mobile"]),
                              Text(detSnap.data!.docs.first["address"]),
                            ],
                          );
                        }
                        return CircularProgressIndicator();
                      }
                  );
                }
                return CircularProgressIndicator();
              }
          ),
        ),
      ),
    );
  }
}
