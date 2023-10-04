import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/screens/home_screen/teacher/pay_bill.dart';

class GuardianResponse extends StatelessWidget {
  const GuardianResponse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("guardianResponse").where("tEmail", isEqualTo: FirebaseAuth.instance.currentUser!.email.toString()).get(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance.collection("posts").doc(snapshot.data!.docs[index]["postId"].toString()).get(),
                          builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> detSnapshot){
                            if(detSnapshot.connectionState == ConnectionState.done){
                              print(detSnapshot.data!["class"]);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(detSnapshot.data!["class"]),
                                          Text(detSnapshot.data!["salary"]),
                                          Text(detSnapshot.data!["curriculum"]),
                                          Text(detSnapshot.data!["location"]),
                                        ],
                                      ),
                                      ElevatedButton(onPressed: (){
                                        Get.to(()=>PayBill());
                                      }, child: Row(children: [Text("Get this tution"),Icon(Icons.arrow_forward)],))
                                    ],
                                  ),
                                ),
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          }
                      );
                    }
                );
              }
              return Center(child: CircularProgressIndicator());
            }
        )
      ),
    );
  }
}
