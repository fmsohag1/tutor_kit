import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/home_screen/guardian/available_teachers.dart';

import '../../authentication/Auth_Screen/screen/login_screen.dart';
import 'guardian_notification_screen.dart';
import 'guardian_post_history.dart';

class GuardianProfile extends StatelessWidget {
  GuardianProfile({super.key});
  bool isImage=false;
  var userEmail = FirebaseAuth.instance.currentUser?.email;
  var userphoto = FirebaseAuth.instance.currentUser?.photoURL;
  var username = FirebaseAuth.instance.currentUser?.displayName;
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
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              //side: BorderSide(color: Colors.black)
                            ),
                            child: CircleAvatar(backgroundImage: AssetImage(icAddUser),radius: 50,)
                        ),
                        Text(data["name"],style: TextStyle(fontSize: 20,fontFamily: roboto_bold),),
                        SizedBox(height: 20,),
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          leading: Image.asset(icEmail,width: 30,),
                          title: Text(userEmail.toString(),style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                          tileColor: bgColor,
                          //trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>GuardianNotificationScreen());
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
                            Get.to(()=>GuardianPostHistory());
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            leading: Image.asset(icHistory,width: 30,),
                            title: Text("History",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                            tileColor: bgColor,
                            trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                          ),
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            showDialog(context: context, builder: (BuildContext context){
                              return Center(child: CircularProgressIndicator());
                            });
                            final box = GetStorage();
                            FirebaseAuth.instance.signOut();
                            // create an alert dialog
                            Get.offAll(()=>LoginScreen());
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

//dhufhdufhd
