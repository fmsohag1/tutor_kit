import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/bloc/lite_api.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_form_screen.dart';
import 'package:tutor_kit/screens/home_screen/teacher/guardian_response.dart';
import 'package:tutor_kit/screens/home_screen/teacher/posts_sent_requests.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_form_screens.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_offer_screen.dart';
import 'package:tutor_kit/screens/home_screen/teacher/update_teacher_profile_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';

import '../../../../authentication/Auth_Screen/screen/login_screen.dart';


class TeacherProfileScreen extends StatelessWidget {
  TeacherProfileScreen({super.key});
  final box = GetStorage();
  var userEmail = FirebaseAuth.instance.currentUser?.email;
  var userPhoto = FirebaseAuth.instance.currentUser?.photoURL;
  bool isImage=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor2,
      /*appBar :AppBar(
        actions: [
          Text("Logout"),
          IconButton(onPressed: (){
            Get.offAll(()=>ChooseScreen());
            box.remove("userPhone");
          }, icon: Icon(Icons.logout))
        ],
      ),*/
      body: SafeArea(
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
                    if(data["name"] == null){
                      return TutorCreateAccount();
                    }
                    if(data["name"] != null){
                      return SingleChildScrollView(
                        child: AnimationLimiter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: AnimationConfiguration.toStaggeredList(
                              duration: Duration(milliseconds: 200),
                                childAnimationBuilder: (widget)=>SlideAnimation(
                                  horizontalOffset: 50,
                                    child: FadeInAnimation(
                                        child: widget
                                    )
                                ),
                                children: [
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
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(100),
                                                    //side: BorderSide(color: Colors.black)
                                                  ),
                                                  child: CircleAvatar(child: isImage?CircleAvatar(backgroundImage: NetworkImage(userPhoto!),radius: 35,):Text(data["name"][0],style: TextStyle(fontSize: 30),),radius: 30,backgroundColor: primary,)
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
                                          showDialog(context: context, builder: (context){
                                            return Dialog(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(0)
                                              ),
                                              child: Container(
                                                height: 230,
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                                                      ),
                                                      child: Image.asset("assets/images/confirm.gif",fit: BoxFit.cover,),
                                                    ),
                                                    SizedBox(height: 20,),
                                                    Text("Are you sure?",textAlign: TextAlign.center,),
                                                    SizedBox(height: 20,),
                                                    Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: (){
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: Container(
                                                              height: 30,
                                                              width: 100,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  color: Colors.teal.shade300
                                                              ),
                                                              child: Center(child: Text("NO",)),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: (){
                                                              final box = GetStorage();
                                                              FirebaseAuth.instance.signOut().then((value) => Get.offAll(()=>LoginScreen()));
                                                              box.remove("user");
                                                            },
                                                            child: Container(
                                                              height: 30,
                                                              width: 100,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  color: Colors.teal.shade300
                                                              ),
                                                              child: Center(child: Text("YES",)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );;
                                          });

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

                                    },
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      leading: SvgPicture.asset(icPhone),
                                      title: Text(data["number"],style: TextStyle(fontSize: 17,),),
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
                                    },
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      leading: SvgPicture.asset(icNotification),
                                      title: Text("Notification",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                                      tileColor: primary,
                                      trailing: Icon(Icons.arrow_forward_ios_rounded,size: 15,),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(()=>PostsSentRequests());
                                    },
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      leading: SvgPicture.asset(icStudent,),
                                      title: Text("My Requests",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                                      tileColor: primary,
                                      trailing: Icon(Icons.arrow_forward_ios_rounded,size: 15,),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(()=>GuardianResponse());
                                      LiteApi.readResponse();
                                    },
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      leading: SvgPicture.asset(icHistory,),
                                      title: Text("Guardian Response",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                                      tileColor: primary,
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance.collection("guardianResponse").where("tEmail", isEqualTo: FirebaseAuth.instance.currentUser!.email.toString()).where("isRead",isEqualTo: false).snapshots(),
                                              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> pSnap){
                                                if(!pSnap.hasData){
                                                  return SizedBox();
                                                }
                                                if(pSnap.data!.docs.isEmpty){
                                                  return SizedBox();
                                                }
                                                if(pSnap.data!.docs.length > 0){
                                                  return CircleAvatar(backgroundColor: Colors.red,radius: 9,child: Text(pSnap.data!.docs.length.toString(),style: TextStyle(fontSize: 13,color: Colors.white),),);
                                                }
                                                return SizedBox();
                                              }
                                          ),
                                          SizedBox(width: 10,),
                                          Icon(Icons.arrow_forward_ios_rounded,size: 15,),
                                        ],
                                      ),
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
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 150,
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
                                                child: Center(child: Text("Gender",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                                            Container(
                                                height: 40,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                                    border: Border.all(color: Colors.grey.shade600)
                                                ),
                                                child: Center(child: Text(data["gender"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),))),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 80,
                                        width: 150,
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
                                                child: Center(child: Text("Age",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                                            Container(
                                                height: 40,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                                    border: Border.all(color: Colors.grey.shade600)
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
                                            child: Center(child: Text("${data["union"]}, ${data["upazila"]}, ${data["district"]}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),maxLines: 2,))),
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
                                                color: Colors.grey.shade600
                                            ),
                                            child: Center(child: Text("Preferable Class",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                                        Container(
                                            height: 50,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                                border: Border.all(color: Colors.grey.shade600)
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
                                                color: Colors.grey.shade600
                                            ),
                                            child: Center(child: Text("Preferable Subject",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                                        Container(
                                            height: 50,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                                border: Border.all(color: Colors.grey.shade600)
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
                                                color: Colors.grey.shade600
                                            ),
                                            child: Center(child: Text("Qualification",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                                        Container(
                                            height: 50,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                                border: Border.all(color: Colors.grey.shade600)
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
                                                color: Colors.grey.shade600
                                            ),
                                            child: Center(child: Text("Institute",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                                        Container(
                                            height: 50,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                                border: Border.all(color: Colors.grey.shade600)
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
                                                color: Colors.grey.shade600
                                            ),
                                            child: Center(child: Text("Department",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: bgColor),))),
                                        Container(
                                            height: 50,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                                border: Border.all(color: Colors.grey.shade600)
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
                                          child: TextButton(onPressed: (){
                                            Get.to(()=>UpdateTeacherProfileScreen());
                                          }, child: Text("Update Profile",style: TextStyle(fontSize: 18,color: Colors.white),),style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),backgroundColor: Colors.grey.shade600),)),
                                    ],
                                  )
                                ],
                            )
                          ),
                        ),
                      );
                    }
                  }
                  return Center(child: CircularProgressIndicator(color: Colors.black12,strokeAlign: -1,));
                }
            )
        ),
      ),
    );
  }
}


class TutorCreateAccount extends StatelessWidget {
  const TutorCreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor2,
      body: Center(
        child: CustomButton(onPress: (){
          Get.off(TeacherFormScreen());
        }, text: "Create Profile First", color: Colors.grey.shade600)
      ),
    );
  }
}


//dhufhdufhd
