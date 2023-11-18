import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/widgets/custom_alert_dialog.dart';
import 'package:tutor_kit/widgets/custom_button.dart';

import 'GuardianInfoForTeacher/screen/guardian_info_for_teacher.dart';

class TeacherStatusScreen extends StatefulWidget {
   TeacherStatusScreen({super.key});

  @override
  State<TeacherStatusScreen> createState() => _TeacherStatusScreenState();
}

class _TeacherStatusScreenState extends State<TeacherStatusScreen> {
  final TextEditingController trController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var postId = Get.arguments;
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("teacherTransactionStatus").where("postId", isEqualTo: postId).where("tEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots(),
                builder: (BuildContext context,AsyncSnapshot <QuerySnapshot>snapshot){
                  if(snapshot.hasError){
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if(!snapshot.hasData){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(snapshot.data!.docs.isEmpty){
                    return Center(child: Text("No Data available"),);
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text("Your transaction Id \n${snapshot.data!.docs.first["transactionId"]}",textAlign: TextAlign.center,),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.brown.shade100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            snapshot.data!.docs.first["status"] == false ?
                            IconButton(tooltip: "Update trx ID",onPressed: (){
                              showDialog(context: context, builder: (context){
                                return Dialog(
                                  child: Container(
                                    height: 350,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextField(
                                            controller: trController..text = "${snapshot.data!.docs.first["transactionId"]}" ,
                                            decoration: InputDecoration(

                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          ElevatedButton(onPressed: (){
                                            FirebaseFirestore.instance.collection("teacherTransactionStatus").doc(snapshot.data!.docs.first.id).update({
                                              "transactionId" : trController.text.trim()
                                            });
                                            Get.back();
                                          }, child: Text("Update"))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                            }, icon: Icon(Icons.edit,size: 18,)) :
                                SizedBox(),
                            Text(
                              "YOUR TRANSACTION ID : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Flexible(
                              child: Text(
                                "${snapshot.data!.docs.first["transactionId"]}",
                                style: TextStyle(color: Colors.green, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 18,),
                      Text("PAYMENT STATUS",style: TextStyle(fontWeight: FontWeight.bold),),
                      Divider(thickness: 2,),
                      SizedBox(height: 10,),
                      snapshot.data!.docs.first["status"] == true ?
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.green
                            ),
                            child: Center(child: Text("Success",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)),
                          ),
                          SizedBox(height: 20,),
                          Divider(thickness: 2,),
                          CustomButton(onPress: (){
                            Get.to(()=>GuardianInfoForTeacher(),arguments: postId);
                          }, text: "Guardian Info", color: Colors.grey.shade600)
                          /*ElevatedButton(onPressed: (){
                          Get.to(()=>GuardianInfoForTeacher(),arguments: postId);
                        }, child: Text("See Guardian Information",),),*/
                        ],
                      ) :
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.orange.shade100
                        ),
                        child: Center(child: Text("Pending",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),)),
                      )
                    ],
                  );
                }
            )
        ),
      ),
    );
  }
}
