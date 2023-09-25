import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../const/colors.dart';

class RequestedTeacherScreen extends StatelessWidget {
   RequestedTeacherScreen({super.key});
  var docId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<QuerySnapshot>(future: FirebaseFirestore.instance.collection("teacherRequest").where("postID", isEqualTo: docId.toString()).get(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> reqSnap){
              if(reqSnap.connectionState == ConnectionState.done){
                return ListView.builder(itemCount: reqSnap.data!.docs.length,itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance.collection("userInfo").where("mobile", isEqualTo: reqSnap.data!.docs[index]["mobile"].toString()).get(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> detSnap){
                          if(detSnap.connectionState == ConnectionState.done){
                            return Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black12),
                                  color: bgColor
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(radius: 30,),
                                  SizedBox(width: 7,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(child: Text(detSnap.data!.docs[index]["name"].toString()),),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text(detSnap.data!.docs[index]["gender"].toString()),
                                          SizedBox(width: 20,),
                                          Text(detSnap.data!.docs[index]["institute"].toString()),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                          return Center(child: LinearProgressIndicator());
                        }
                    )
                  );
                });
              }
              return CircularProgressIndicator();
            }
        ),
      ),
    );
  }
}
