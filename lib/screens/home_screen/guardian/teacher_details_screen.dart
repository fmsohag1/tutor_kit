import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
                                                color: Colors.grey.shade100
                                            ),
                                            child: Center(child: Text("Get the Teacher",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),
                                          ),
                                        ),
                                        Text("you have selected a teacher already")
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
                                          Get.snackbar("Attention", "Response sent already, be patient to get a call from the teacher");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.grey.shade100
                                          ),
                                          child: Center(child: Text("Response sent",style: TextStyle(fontWeight: FontWeight.bold),)),
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
                              return Center(child: CircularProgressIndicator());
                            }
                        )
                      ],
                    ),
                  ),
                ),

              );
            }
            return Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
}
