import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../authentication/Auth_Screen/screen/login_screen.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Approvals"),
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Get.offAll(()=>LoginScreen());
            box.remove("user");
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("teacherTransactionStatus").orderBy("timestamp",descending: true).snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, index){
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(snapshot.data!.docs[index]["tEmail"].toString()),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(snapshot.data!.docs[index]["amount"].toString()),
                            Text(snapshot.data!.docs[index]["transactionId"].toString()),
                          ],
                        ),
                        snapshot.data!.docs[index]["status"] == true ?
                            IconButton(onPressed: (){
                              FirebaseFirestore.instance.collection("teacherTransactionStatus").doc(snapshot.data!.docs[index].id).update({
                                "status" : false
                              });
                            }, icon: Icon(Icons.check_circle,color: Colors.green,)) :
                        IconButton(onPressed: (){
                          FirebaseFirestore.instance.collection("teacherTransactionStatus").doc(snapshot.data!.docs[index].id).update({
                            "status" : true
                          });
                        }, icon: Icon(Icons.circle_outlined,color: Colors.red,))
                      ],
                    ),
                  );
                  }
              );
            }
        ),
      )
    );
  }
}
