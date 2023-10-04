

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/bloc/crud_db.dart';

import '../../../const/images.dart';

class RequestedTeacherDetailsScreen extends StatelessWidget {
   RequestedTeacherDetailsScreen({super.key});

  var teacherEmail = Get.arguments[0];
  var postId = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text("Teacher Information"),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection("userInfo").where("email", isEqualTo: teacherEmail).get(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10,),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12),
                      color: Colors.brown.shade50
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(35),bottomLeft: Radius.circular(35)),
                              color: Colors.white
                          ),
                          child: Center(child: Text(snapshot.data!.docs.first["name"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,))),
                        ),
                        SizedBox(height: 10,),
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
                                        Text(snapshot.data!.docs.first["gender"],),
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
                                        Text("Age",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                        Text("${DateTime.now().year-int.parse(snapshot.data!.docs.first["dob"])} yr"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 5,),
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
                                    Text("Address",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    Text(snapshot.data!.docs.first["address"]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
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
                                    child: Image.asset(icClass,width: 25,),
                                  )),
                              SizedBox(width: 5,),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Preferable Class",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    Text(snapshot.data!.docs.first["prefClass"]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
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
                                    child: Image.asset(icSubjects,width: 25,),
                                  )),
                              SizedBox(width: 5,),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Tuition Subject",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    Text(snapshot.data!.docs.first["prefSubjects"]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
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
                                    Text("Qualification",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    Text(snapshot.data!.docs.first["qualification"]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
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
                                    Text("Institute",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    Text(snapshot.data!.docs.first["institute"]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
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
                                    Text("Section/Department",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    Text(snapshot.data!.docs.first["department"]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            CrudDb().addGuardianResponse(snapshot.data!.docs.first["name"],postId, FieldValue.serverTimestamp(), teacherEmail, FirebaseAuth.instance.currentUser!.email.toString());
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green.shade100
                            ),
                            child: Center(child: Text("Get the Teacher",style: TextStyle(fontWeight: FontWeight.bold),)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              );
            }
            return Center(child: CircularProgressIndicator());
          }
      )

    );
  }
}
