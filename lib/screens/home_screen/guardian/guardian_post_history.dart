import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
import 'guardian_home.dart';

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
      backgroundColor: bgColor2,
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
                return const Center(child: CircularProgressIndicator(color: Colors.black12,strokeAlign: -1,),);
              }
              if(snapshot.data!.docs.length==0){
                return const Center(child: Text("No history found"),);
              }
              // final data = snapshot.requireData;
              return AnimationLimiter(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      Timestamp timestamp = snapshot.data!.docs[index]["timestamp"];
                      var data=snapshot.data!.docs[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(color: Colors.black12)
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
                                                icon: SvgPicture.asset(icSalary,width: 17,),
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
                                            subtitle: "${data["union"]}, ${data["upazila"]}, ${data["district"]}",
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
                                                                    print(snapshot.data!.docs[index].id);
                                                                    // snapshot.data!.docs[index].
                                                                    // FirebaseFirestore.instance.collection("posts").doc().delete();
                                                                    CrudDb().deletePost(snapshot.data!.docs[index].id);
                                                                    Get.back();
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
                                                return SizedBox(child: Center(child: CircularProgressIndicator(color: Colors.black12,strokeAlign: -1,)));
                                              }
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Center(child: ElevatedButton(onPressed: (()=>Get.to(()=>GuardianHome(currentNavIndex: 2.obs))), child: Icon(Icons.arrow_back)))
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }),
      ),
    );
  }
}
