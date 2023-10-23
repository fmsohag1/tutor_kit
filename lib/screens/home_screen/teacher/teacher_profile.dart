import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/home_screen/teacher/guardian_response.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_offer_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';

import '../../authentication/Auth_Screen/screen/login_screen.dart';


class TeacherProfile extends StatelessWidget {
  TeacherProfile({super.key});
  final box = GetStorage();
  var userEmail = FirebaseAuth.instance.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar :AppBar(
        actions: [
          Text("Logout"),
          IconButton(onPressed: (){
            Get.offAll(()=>ChooseScreen());
            box.remove("userPhone");
          }, icon: Icon(Icons.logout))
        ],
      ),*/
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get(),
              builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasError){
                  return const Text("Something went wrong");
                }
                if(snapshot.hasData && !snapshot.data!.exists){
                  return const Text("Document does not exist");
                }
                if(snapshot.connectionState == ConnectionState.done){
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        Container(
                            height: 40,
                            width: double.infinity,
                            color: Colors.teal.shade50,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8,left: 10),
                              child: Text("Account",style: TextStyle(fontSize: 17,),),
                            )),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Row(
                                  children: [
                                    Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                          //side: BorderSide(color: Colors.black)
                                        ),
                                        child: CircleAvatar(backgroundImage: AssetImage("assets/icons/display-pic.png"),radius: 30,)
                                    ),
                                    SizedBox(width: 5,),
                                    Flexible(
                                      child: Column(
                                        children: [
                                          Text(data["name"],style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: MiniCustomButton(onPress: (){
                                final box = GetStorage();
                                FirebaseAuth.instance.signOut().then((value) => Get.to(()=>LoginScreen()));
                                box.remove("user");
                              }, text: "Logout", color: Colors.redAccent,),
                            )
                          ],
                        ),

                        ListTile(
                          leading: Image.asset(icEmail,width: 25,),
                          title: Text(userEmail.toString(),style: TextStyle(fontSize: 17,),),
                        ),
                        Container(
                            height: 40,
                            width: double.infinity,
                            color: Colors.teal.shade50,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8,left: 10),
                              child: Text("Content & Activity",style: TextStyle(fontSize: 17,),),
                            )),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            leading: Image.asset(icNotification,width: 30,),
                            title: Text("Notification",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                            tileColor: bgColor,
                            trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                          ),
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>GuardianResponse());
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            leading: Image.asset(icHistory,width: 30,),
                            title: Text("Guardian Response",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                            tileColor: bgColor,
                            trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                            height: 40,
                            width: double.infinity,
                            color: Colors.teal.shade50,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8,left: 10),
                              child: Text("Profile Details",style: TextStyle(fontSize: 17,),),
                            )),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 80,
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                //border: Border.all(color: Colors.grey)
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                          color: Colors.brown.shade100
                                      ),
                                      child: Center(child: Text("Gender",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                                  Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                          border: Border.all(color: Colors.brown.shade100)
                                      ),
                                      child: Center(child: Text(data["gender"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),))),
                                ],
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                //border: Border.all(color: Colors.grey)
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                          color: Colors.brown.shade100
                                      ),
                                      child: Center(child: Text("Age",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                                  Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                          border: Border.all(color: Colors.brown.shade100)
                                      ),
                                      child: Center(child: Text("${DateTime.now().year-int.parse(data["dob"])}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            //border: Border.all(color: Colors.grey)
                          ),
                          child: Column(
                            children: [
                              Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                      color: Colors.brown.shade100
                                  ),
                                  child: Center(child: Text("Address",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                              Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                      border: Border.all(color: Colors.brown.shade100)
                                  ),
                                  child: Center(child: Text(data["address"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),maxLines: 2,))),
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            //border: Border.all(color: Colors.grey)
                          ),
                          child: Column(
                            children: [
                              Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                      color: Colors.brown.shade100
                                  ),
                                  child: Center(child: Text("Preferable Class",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                              Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                      border: Border.all(color: Colors.brown.shade100)
                                  ),
                                  child: Center(child: Text(data["prefClass"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),maxLines: 2,))),
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            //border: Border.all(color: Colors.grey)
                          ),
                          child: Column(
                            children: [
                              Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                      color: Colors.brown.shade100
                                  ),
                                  child: Center(child: Text("Preferable Subject",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                              Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                      border: Border.all(color: Colors.brown.shade100)
                                  ),
                                  child: Center(child: Text(data["prefSubjects"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),maxLines: 2,))),
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            //border: Border.all(color: Colors.grey)
                          ),
                          child: Column(
                            children: [
                              Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                      color: Colors.brown.shade100
                                  ),
                                  child: Center(child: Text("Qualification",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                              Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                      border: Border.all(color: Colors.brown.shade100)
                                  ),
                                  child: Center(child: Text(data["qualification"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),maxLines: 2,))),
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            //border: Border.all(color: Colors.grey)
                          ),
                          child: Column(
                            children: [
                              Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                      color: Colors.brown.shade100
                                  ),
                                  child: Center(child: Text("Institute",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                              Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                      border: Border.all(color: Colors.brown.shade100)
                                  ),
                                  child: Center(child: Text(data["institute"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),maxLines: 2,))),
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            //border: Border.all(color: Colors.grey)
                          ),
                          child: Column(
                            children: [
                              Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                      color: Colors.brown.shade100
                                  ),
                                  child: Center(child: Text("Department",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                              Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                      border: Border.all(color: Colors.brown.shade100)
                                  ),
                                  child: Center(child: Text(data["department"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),maxLines: 2,))),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                                height: 50,
                                width: 180,
                                child: TextButton(onPressed: (){}, child: Text("Update Profile",style: TextStyle(fontSize: 18,color: Colors.white),),style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),backgroundColor: Colors.grey.shade600),)),
                          ],
                        )
                        /*Text("name : "+ data["name"]),
                      Text("gender : "+ data["gender"]),
                      Text("institute : "+ data["institute"]),
                      Text("department : " + data["department"]),
                      Text("prefClass : " + data["prefClass"]),
                      Text("prefSubjects : " + data["prefSubjects"]),
                      Text("qualification : " + data["qualification"]),
                      Text("address : " + data["address"]),
                      Text("dob : " + data["dob"]),*/
                      ],
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              }
          )
      ),
    );
  }
}

//dhufhdufhd
