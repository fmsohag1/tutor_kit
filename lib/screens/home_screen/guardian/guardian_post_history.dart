import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/bloc/crud_db.dart';
import 'package:tutor_kit/drafts/darft1.dart';
import 'package:tutor_kit/screens/home_screen/guardian/requested_teacher_screen.dart';
import 'package:tutor_kit/screens/home_screen/guardian/update_post_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';

import '../../../const/colors.dart';
import '../../../const/images.dart';
import '../../../const/styles.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../teacher/PostScreen/widget/postdata.dart';

class GuardianPostHistory extends StatefulWidget {
  GuardianPostHistory({super.key});

  @override
  State<GuardianPostHistory> createState() => _GuardianPostHistoryState();
}

class _GuardianPostHistoryState extends State<GuardianPostHistory> {
  final box = GetStorage();

  var userEmail = FirebaseAuth.instance.currentUser!.email;
  final TextEditingController genderController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController dayPerWeekController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController curriculumController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final postsRef = FirebaseFirestore.instance.collection("posts").orderBy("timestamp",descending: true).where("userEmail", isEqualTo: userEmail);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder(
            stream: postsRef.snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasError){
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.data!.docs.length==0){
                return const Center(child: Text("No history found"),);
              }
              // final data = snapshot.requireData;
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
                    Timestamp timestamp = snapshot.data!.docs[index]["timestamp"];
                    return Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.grey)
                        ),
                        color: bgColor2,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  PostData(
                                    icon: SvgPicture.asset(icGender),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.410,
                                    title: "Gender",
                                    subtitle: "${snapshot.data!.docs[index]["gender"]}",
                                  ),
                                  PostData(
                                    icon: SvgPicture.asset(icClass),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.410,
                                    title: "Class",
                                    subtitle: "${snapshot.data!.docs[index]["class"]}",
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              PostData(
                                icon: SvgPicture.asset(icSubjects),
                                width: double.infinity,
                                title: "Subjects",
                                subtitle: "${snapshot.data!.docs[index]["subjects"]}",
                              ),
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  PostData(
                                    icon: SvgPicture.asset(icDay),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.410,
                                    title: "Day/Week",
                                    subtitle: "${snapshot.data!.docs[index]["dayPerWeek"]}",
                                  ),
                                  PostData(
                                    icon: SvgPicture.asset(icSalary,width: 20,),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.410,
                                    title: "Salary",
                                    subtitle: "${snapshot.data!.docs[index]["salary"]} BDT",
                                  ),

                                ],
                              ),
                              const SizedBox(height: 5,),
                              PostData(
                                icon: SvgPicture.asset(icLocation),
                                width: double.infinity,
                                title: "Location",
                                subtitle: "${snapshot.data!.docs[index]["location"]}",
                              ),
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  PostData(
                                    icon: SvgPicture.asset(icStudent),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.410,
                                    title: "Students",
                                    subtitle: "${snapshot.data!.docs[index]["student"]}",
                                  ),
                                  PostData(
                                    icon: SvgPicture.asset(icTime),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.410,
                                    title: "Time",
                                    subtitle: "${snapshot.data!.docs[index]["time"]}",
                                  ),

                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  PostData(
                                    icon: SvgPicture.asset(icCurriculum),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.410,
                                    title: "Curriculum",
                                    subtitle: "${snapshot.data!.docs[index]["curriculum"]}",
                                  ),
                                  Container(
                                    child: Center(child: Text(timeago.format(DateTime.parse(timestamp.toDate().toString())),style: TextStyle(fontFamily: roboto_regular,color: Colors.blueGrey),)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MiniCustomButton(onPress: (){
                                    print(snapshot.data!.docs[index].id);
                                    // snapshot.data!.docs[index].
                                    // FirebaseFirestore.instance.collection("posts").doc().delete();
                                    CrudDb().deletePost(snapshot.data!.docs[index].id);
                                  }, text: "Delete", color: inversePrimary,),
                                  MiniCustomButton(onPress: (){
                                    Get.to(()=>UpdatePostScreen(),arguments: [snapshot.data!.docs[index].id]);
                                  }, text: "Edit", color: inversePrimary,),
                                ],
                              ),
                              SizedBox(height: 20,),
                              FutureBuilder<QuerySnapshot>(future: FirebaseFirestore.instance.collection("teacherRequest").where("postID", isEqualTo: snapshot.data!.docs.first.id.toString()).get(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> reqSnap){
                                    if(reqSnap.connectionState == ConnectionState.done){
                                      return GestureDetector(onTap: (){
                                        Get.to(()=>RequestedTeacherScreen(),arguments: snapshot.data!.docs.first.id.toString());
                                      },
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            tileColor: Colors.green.shade100,
                                            leading: CircleAvatar(child: Text(reqSnap.data!.docs.length.toString()),backgroundColor: Colors.white,),
                                            title: Text("Tutor Requested!",style: TextStyle(fontSize: 18,),),
                                            trailing: Icon(Icons.keyboard_arrow_right_rounded),
                                          ),
                                      );
                                    }
                                    return SizedBox(height: 20,width: 20,child: CircularProgressIndicator());
                                  }
                              ),
                            ],
                          ),
                        ),),
                    );
                  });
            }),
      ),
    );
  }
}
