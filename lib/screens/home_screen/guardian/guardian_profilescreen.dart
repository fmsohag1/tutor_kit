import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/bloc/lite_api.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/home_screen/guardian/requested_teacher_screen.dart';
import 'package:tutor_kit/screens/home_screen/guardian/update_guardian_profile_screen.dart';

import '../../../widgets/custom_button.dart';
import '../../authentication/Auth_Screen/screen/login_screen.dart';
import 'guardian_notification_screen.dart';
import 'guardian_post_history.dart';

class GuardianProfile extends StatelessWidget {
  GuardianProfile({super.key});
  bool isImage=false;
  var userEmail = FirebaseAuth.instance.currentUser?.email;
  var userPhoto = FirebaseAuth.instance.currentUser?.photoURL;
  var username = FirebaseAuth.instance.currentUser?.displayName;
  var postId = "";
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection("posts").where("userEmail", isEqualTo: userEmail).get().then((snap){
      if(snap.docs.isNotEmpty){
        postId = snap.docs.first.id.toString();
        print(postId);
      }
    });
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
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
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
                            color: Colors.black12,
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
                                        child: CircleAvatar(backgroundImage: isImage?AssetImage(userPhoto!):AssetImage("assets/icons/display-pic.png"),radius: 30,)
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
                                FirebaseAuth.instance.signOut().then((value) => Get.offAll(()=>LoginScreen()));
                                box.remove("user");
                              }, text: "Logout", color: Colors.redAccent,),
                            )
                          ],
                        ),

                        ListTile(
                          leading: SvgPicture.asset(icEmail),
                          title: Text(userEmail.toString(),style: TextStyle(fontSize: 17,),),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.off(()=>GuardianNotificationScreen());
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            leading: SvgPicture.asset(icPhone),
                            title: Text(data["mobile"],style: TextStyle(fontSize: 17,),),
                          ),
                        ),
                        Container(
                            height: 40,
                            width: double.infinity,
                            color: Colors.black12,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8,left: 10),
                              child: Text("Content & Activity",style: TextStyle(fontSize: 17,),),
                            )),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>GuardianNotificationScreen());
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            leading: SvgPicture.asset(icNotification),
                            title: Text("Notification",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                            tileColor: primary,
                            trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                          ),
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>RequestedTeacherScreen(),arguments: postId);
                            LiteApi.readRequest();
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            leading: SvgPicture.asset(icStudent),
                            title: Text("Tutor Requests",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                            tileColor: primary,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection("posts").where("userEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots(),
                                    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> pSnap){
                                      if(!pSnap.hasData){
                                        return SizedBox();
                                      }
                                      if(pSnap.data!.docs.isEmpty){
                                        return SizedBox();
                                      }
                                      return StreamBuilder(
                                          stream: FirebaseFirestore.instance.collection("teacherRequest").where("postID",isEqualTo: pSnap.data!.docs.first.id).where("isRead", isEqualTo: false).snapshots(),
                                          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> trSnap){
                                            if(!trSnap.hasData){
                                              return SizedBox();
                                            }
                                            if(trSnap.data!.docs.isEmpty){
                                              return SizedBox();
                                            }
                                            if(trSnap.data!.docs.length > 0){
                                              return CircleAvatar(radius: 12,backgroundColor: Colors.red,child: Text(trSnap.data!.docs.length.toString(),style: TextStyle(color: Colors.white),));
                                            }
                                            return SizedBox();
                                          }
                                      );
                                    }
                                ),
                                // Badge(
                                //   label: Text(LiteApi.trTotal.toString()),
                                //   textStyle: TextStyle(fontSize: 15),
                                //   isLabelVisible: LiteApi.trTotal > 0 ? true : false,
                                // ),
                                SizedBox(width: 10,),
                                Icon(Icons.arrow_forward_ios_rounded,size: 15,),
                              ],
                            ),
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
                            leading: SvgPicture.asset(icHistory),
                            title: Text("History",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                            tileColor: primary,
                            trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                            height: 40,
                            width: double.infinity,
                            color: Colors.black12,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8,left: 10),
                              child: Text("Profile Details",style: TextStyle(fontSize: 17,),),
                            )),
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
                                      color: Colors.grey.shade600
                                  ),
                                  child: Center(child: Text("Address",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                              Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                      border: Border.all(color: Colors.grey.shade600)
                                  ),
                                  child: Center(child: Text(data["address"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),maxLines: 2,))),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                                height: 50,
                                width: 180,
                                child: TextButton(onPressed: (){
                                  Get.to(()=>UpdateGuardianProfileScreen());
                                }, child: Text("Update Profile",style: TextStyle(fontSize: 18,color: Colors.white),),style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),backgroundColor: Colors.grey.shade600),)),
                          ],
                        )

                      ],
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              }
          ),
        )
    );
  }
}

//dhufhdufhd
/*
Center(
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
);*/
