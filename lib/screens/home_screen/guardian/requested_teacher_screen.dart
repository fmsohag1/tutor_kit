import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tutor_kit/screens/home_screen/guardian/requested_teacher_detailes_screen.dart';

import '../../../const/colors.dart';
import '../../../const/images.dart';

class RequestedTeacherScreen extends StatelessWidget {
   RequestedTeacherScreen({super.key});
  var docId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("teacherRequest").where("postID", isEqualTo: docId.toString()).get(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      List numList =[];
                      for (var element in snapshot.data!.docs) {
                        numList.add(element["email"]);
                      }
                    return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance.collection("userInfo").where("email", whereIn: numList).get(),
                        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> detSnapshot){
                          if(detSnapshot.connectionState == ConnectionState.done){
                            return Padding(
                              padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
                              child: GestureDetector(
                                onTap: (){
                                  Get.to(()=>RequestedTeacherDetailsScreen(),arguments: [detSnapshot.data!.docs[index]["email"],docId]);
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black12),
                                    color: Colors.brown.shade50,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          child: Row(
                                            children: [
                                              Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(100),
                                                      side: BorderSide(color: Colors.black)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Image.asset(icHome,width: 25,),
                                                  )),
                                              SizedBox(width: 5,),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Name",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                                    Text(detSnapshot.data!.docs[index]["name"],),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              width: MediaQuery.of(context).size.width*0.410,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white
                                              ),
                                              child: Row(
                                                children: [
                                                  Card(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(100),
                                                          side: BorderSide(color: Colors.black)
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Image.asset(icGender,width: 25,),
                                                      )),
                                                  SizedBox(width: 5,),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Gender",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                                        Text(detSnapshot.data!.docs[index]["gender"],),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              width: MediaQuery.of(context).size.width*0.410,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white
                                              ),
                                              child: Row(
                                                children: [
                                                  Card(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(100),
                                                          side: BorderSide(color: Colors.black)
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Image.asset(icHome,width: 25,color: Colors.grey[800],),
                                                      )),
                                                  SizedBox(width: 5,),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Age",style: TextStyle(fontSize: 16,),),
                                                        Text("${DateTime.now().year-int.parse(detSnapshot.data!.docs[index]["dob"])} yr"),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                                  color: Colors.white
                                              ),
                                              child: Center(child: Text("Details>>",style: TextStyle(color: Colors.green,),)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Center(child: LinearProgressIndicator());
                        }
                    );
                    }
                );
              }
              return CircularProgressIndicator();
            }
        )
      ),
    );
  }
}

