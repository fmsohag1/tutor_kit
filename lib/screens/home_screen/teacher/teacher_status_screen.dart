import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/screens/home_screen/teacher/guardian_info_for_teacher.dart';

class TeacherStatusScreen extends StatelessWidget {
  const TeacherStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var postId = Get.arguments;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("teacherTransactionStatus").where("postId", isEqualTo: postId).snapshots(),
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
                    Text("Your transaction Id \n${snapshot.data!.docs.first["transactionId"]}",textAlign: TextAlign.center,),
                    SizedBox(height: 18,),
                    Text("Payment Status"),
                    snapshot.data!.docs.first["status"] == true ?
                    Column(
                      children: [
                        ElevatedButton(onPressed: (){}, child: Text("Success",style: TextStyle(color: Colors.white)),style: ElevatedButton.styleFrom(backgroundColor: Colors.green)),
                        SizedBox(height: 5,),
                        ElevatedButton(onPressed: (){
                          Get.to(()=>GuardianInfoForTeacher(),arguments: postId);
                        }, child: Text("See Guardian Information",),),
                      ],
                    ) :
                    ElevatedButton(onPressed: (){}, child: Text("Pending"),style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow))
                  ],
                );
              }
          )
        ),
      ),
    );
  }
}
