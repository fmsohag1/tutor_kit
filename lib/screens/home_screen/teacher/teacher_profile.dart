import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/auth_screens/choose_screen.dart';
import 'package:tutor_kit/screens/home_screen/teacher/guardian_response.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_offer_screen.dart';

import '../../auth_screens/phone_screen.dart';

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
      body: Center(
        child: Padding(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: BorderSide(color: Colors.black)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(icAddUser,width: 80,color: Colors.grey[600],),
                            )),
                        Text(data["name"],style: TextStyle(fontSize: 20,fontFamily: roboto_bold),),
                        SizedBox(height: 20,),
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          leading: Image.asset(icPhone,width: 30,),
                          title: Text(userEmail.toString(),style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                          tileColor: bgColor,
                          trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                        ),
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
                            Get.to(()=>TeacherOfferScreen());
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            leading: Image.asset(icHistory,width: 30,),
                            title: Text("Offers",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
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
                        GestureDetector(
                          onTap: (){
                            final box = GetStorage();
                            FirebaseAuth.instance.signOut().then((value) => Get.to(()=>ChooseScreen()));
                            box.remove("user");
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            leading: Image.asset(icLogout,width: 30,),
                            title: Text("Logout",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                            tileColor: bgColor,
                            trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                          ),
                        ),
                        Text("name : "+ data["name"]),
                        Text("gender : "+ data["gender"]),
                        Text("institute : "+ data["institute"]),
                        Text("department : " + data["department"]),
                        Text("prefClass : " + data["prefClass"]),
                        Text("prefSubjects : " + data["prefSubjects"]),
                        Text("qualification : " + data["qualification"]),
                        Text("address : " + data["address"]),
                        Text("dob : " + data["dob"]),
                      ],
                    ),
                  );
                }
                return CircularProgressIndicator();
              }
          )
        ),
      ),
    );
  }
}

//dhufhdufhd
