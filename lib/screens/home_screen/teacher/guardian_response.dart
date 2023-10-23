import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/screens/home_screen/teacher/pay_bill.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_status_screen.dart';

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
                                      SizedBox(width: 50,),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                          child: FutureBuilder(
                                              future: FirebaseFirestore.instance.collection("teacherTransactionStatus").where("tEmail", isEqualTo: FirebaseAuth.instance.currentUser!.email).where("postId", isEqualTo: detSnapshot.data!.id).get(),
                                              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> tranSnap){
                                                if(tranSnap.connectionState == ConnectionState.done){
                                                  if(tranSnap.data!.docs.isNotEmpty){
                                                    return ElevatedButton(onPressed: (){
                                                      Get.to(()=>TeacherStatusScreen(),arguments: detSnapshot.data!.id);
                                                    }, child: Row(children: [Text("See status"),Icon(Icons.arrow_forward)],));
                                                  }
                                                  if(tranSnap.data!.docs.isEmpty){
                                                    return ElevatedButton(onPressed: (){
                                                      Get.to(()=>PayBill(),arguments: [detSnapshot.data!["salary"], detSnapshot.data!.id]);
                                                    }, child: Row(children: [Text("Get this tution"),Icon(Icons.arrow_forward)],));
                                                  }
                                                  print(tranSnap.data!.docs.isNotEmpty);
                                                }
                                                return LinearProgressIndicator();
                                              }
                                          ),
                                        ),
                                      ),
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
