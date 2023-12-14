import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_kit/const/colors.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_home.dart';

import '../../../bloc/crud_db.dart';
import '../../../const/images.dart';
import '../../../widgets/custom_alert_dialog.dart';
import '../teacher/PostScreen/widget/postdata.dart';

class TeacherDetailsScreen extends StatefulWidget {
   TeacherDetailsScreen({super.key});

  @override
  State<TeacherDetailsScreen> createState() => _TeacherDetailsScreenState();
}

class _TeacherDetailsScreenState extends State<TeacherDetailsScreen> {
  var teacherEmail = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var resNum;
    FirebaseFirestore.instance.collection("guardianResponse").where("gEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email).get().then((value) {
      resNum = value.docs.length;
    });
    var postId;
    FirebaseFirestore.instance.collection("posts").where("userEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email).get().then((pSnap) {
      if(pSnap.docs.isNotEmpty){
        postId = pSnap.docs.first.id;
      }
    });
    print(postId);
    return Scaffold(
      backgroundColor: bgColor2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bgColor2,
        title: Text("Teacher Information"),
      ),
      body: SafeArea(
        child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("userInfo").where("email", isEqualTo: teacherEmail).get(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: AnimationLimiter(
                    child: Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: Duration(milliseconds: 200),
                          childAnimationBuilder: (widget)=>SlideAnimation(
                            verticalOffset: 50,
                              child: FadeInAnimation(child: widget)),
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
                                      child: CircleAvatar(child: SvgPicture.asset(icName),backgroundColor: bgColor2,)),
                                  SizedBox(width: 5,),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data!.docs.first["name"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
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
                                //Text("${DateTime.now().year-int.parse(snapshot.data!.docs.first["dob"])}"),
                                PostData(
                                  icon: SvgPicture.asset(icGender),
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.410,
                                  title: "Gender",
                                  subtitle: "${snapshot.data!.docs.first["gender"]}",
                                ),
                                PostData(
                                  icon: SvgPicture.asset(icAge),
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.410,
                                  title: "Age",
                                  subtitle: "${DateTime.now().year-int.parse(snapshot.data!.docs.first["dob"])}",
                                ),

                              ],
                            ),
                            SizedBox(height: 5,),
                            PostData(
                              icon: SvgPicture.asset(icLocation),
                              width: double.infinity,
                              title: "Address",
                              subtitle: "${snapshot.data!.docs.first["address"]}",
                            ),
                            SizedBox(height: 5,),
                            PostData(
                              icon: SvgPicture.asset(icClass),
                              width: double.infinity,
                              title: "Preferable Class",
                              subtitle: "${snapshot.data!.docs.first["prefClass"]}",
                            ),
                            SizedBox(height: 5,),
                            PostData(
                              icon: SvgPicture.asset(icSubjects),
                              width: double.infinity,
                              title: "Tuition Subjects",
                              subtitle: "${snapshot.data!.docs.first["prefSubjects"]}",
                            ),
                            SizedBox(height: 5,),
                            PostData(
                              icon: SvgPicture.asset(icQualification),
                              width: double.infinity,
                              title: "Qualification",
                              subtitle: "${snapshot.data!.docs.first["qualification"]}",
                            ),
                            SizedBox(height: 5,),
                            PostData(
                              icon: SvgPicture.asset(icInstitute),
                              width: double.infinity,
                              title: "Institute",
                              subtitle: "${snapshot.data!.docs.first["institute"]}",
                            ),
                            SizedBox(height: 5,),
                            PostData(
                              icon: SvgPicture.asset(icDepartment,width: 25,),
                              width: double.infinity,
                              title: "Section/Department",
                              subtitle: "${snapshot.data!.docs.first["department"]}",
                            ),
                            SizedBox(height: 10,),
                            FutureBuilder(
                                future: FirebaseFirestore.instance.collection("guardianResponse").where("gEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email).where("postId",isEqualTo: postId).where("tEmail",isEqualTo: snapshot.data!.docs.first["email"]).get(),
                                builder: (BuildContext context, grSnap){
                                  if(grSnap.connectionState == ConnectionState.done){
                                    if(grSnap.data!.docs.isEmpty){
                                      if(resNum == 1){
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Colors.grey.shade400
                                                ),
                                                child: Center(child: Text("Get the Teacher",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Text("you have selected a teacher already!")
                                          ],
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: (){
                                            if(postId != null ){
                                              showDialog(barrierDismissible: false,context: context, builder: (BuildContext context){
                                                return CustomAlertDialog(text: "Request Sent Successfully", assets: "assets/icons/animation_lmej1fs8.json",onTap: (){
                                                  Get.back();
                                                  setState(() {
                                                  });
                                                },);
                                              });
                                              CrudDb().addGuardianResponse(snapshot.data!.docs.first["name"],postId, FieldValue.serverTimestamp(), teacherEmail, FirebaseAuth.instance.currentUser!.email.toString());
                                            } else {
                                              Get.to(()=>GuardianHome(currentNavIndex: 1.obs));
                                            }
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
                                        );
                                      }
                                    }
                                    if(grSnap.data!.docs.isNotEmpty){
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              Get.snackbar(
                                                "Attention",
                                                "Response sent already, be patient to get a call from the teacher",
                                                backgroundColor: Colors.orange.shade100,
                                                icon: Lottie.asset(
                                                  "assets/icons/warning.json",
                                                ),
                                                animationDuration: Duration(
                                                  seconds: 0,
                                                ),
                                                duration: Duration(seconds: 5),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: primary
                                              ),
                                              child: Center(child: Text("Response sent",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),
                                            ),
                                          ),
                                          IconButton(onPressed: (){
                                            FirebaseFirestore.instance.collection("guardianResponse").doc(grSnap.data!.docs.first.id).delete();
                                            setState(() {

                                            });
                                          }, icon: Icon(Icons.cancel),)
                                        ],
                                      );
                                    }
                                  }
                                  return Center(child: CircularProgressIndicator(color: Colors.black12,strokeAlign: -1,));
                                }
                            )
                          ],
                      )
                    ),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator(color: Colors.black12,strokeAlign: -1,));
            }
        ),
      ),
    );
  }
}
