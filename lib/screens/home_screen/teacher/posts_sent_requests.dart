import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tutor_kit/screens/home_screen/teacher/post_details_screen.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_form_screens.dart';

import 'PostScreen/widget/postdata.dart';

class PostsSentRequests extends StatelessWidget {
  PostsSentRequests({super.key});

  final postsRef = FirebaseFirestore.instance.collection("posts").orderBy("timestamp",descending: true);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userPhoneNumber = box.read("userPhone");
    return  Scaffold(
      backgroundColor: bgColor2,
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("teacherRequest").where("email",isEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasError){
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(color: Colors.black12,strokeAlign: -1,),);
              }
              if(snapshot.data!.docs.isEmpty){
                return const Center(child: Text("No posts available"),);
              }
              // final data = snapshot.requireData;
              return AnimationLimiter(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance.collection("posts").doc(snapshot.data!.docs[index]["postID"]).snapshots(),
                                builder: (context,AsyncSnapshot<DocumentSnapshot> pSnapshot){
                                  // Timestamp timestamp = pSnapshot.data!["timestamp"];
                                  if(pSnapshot.hasError){
                                    return Center(
                                      child: Text(pSnapshot.error.toString()),
                                    );
                                  }
                                  if(!pSnapshot.hasData){
                                    return const Center(child: CircularProgressIndicator(color: Colors.black12,strokeAlign: -1,),);
                                  }
                                  if(!pSnapshot.data!.exists){
                                    return const Center(child: Text("No posts available"),);
                                  }
                                  return Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                                      child: GestureDetector(
                                        onTap: (){
                                          Get.to(()=>PostDetailesScreen(),arguments: pSnapshot.data!.id);
                                        },
                                        child: Card(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              side: BorderSide(color: Colors.black12)
                                          ),
                                          color: bgColor2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    PostData(
                                                      icon: SvgPicture.asset(icGender),
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.410,
                                                      title: "Gender",
                                                      subtitle: "${pSnapshot.data!["gender"]}",
                                                    ),
                                                    PostData(
                                                      icon: SvgPicture.asset(icClass),
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.410,
                                                      title: "Class",
                                                      subtitle: "${pSnapshot.data!["class"]}",
                                                    ),

                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                PostData(
                                                  icon: SvgPicture.asset(icSubjects),
                                                  width: double.infinity,
                                                  title: "Subjects",
                                                  subtitle: "${pSnapshot.data!["subjects"]}",
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    PostData(
                                                      icon: SvgPicture.asset(icDay),
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.410,
                                                      title: "Day/Week",
                                                      subtitle: "${pSnapshot.data!["dayPerWeek"]}",
                                                    ),
                                                    PostData(
                                                      icon: SvgPicture.asset(icSalary,width: 20,),
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.410,
                                                      title: "Salary",
                                                      subtitle: "${pSnapshot.data!["salary"]} BDT",
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                PostData(
                                                  icon: SvgPicture.asset(icLocation),
                                                  width: double.infinity,
                                                  title: "Location",
                                                  subtitle: "${pSnapshot.data!["location"]}",
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    PostData(
                                                      icon: SvgPicture.asset(icStudent),
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.410,
                                                      title: "Students",
                                                      subtitle: "${pSnapshot.data!["student"]}",
                                                    ),
                                                    PostData(
                                                      icon: SvgPicture.asset(icTime),
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.410,
                                                      title: "Time",
                                                      subtitle: "${pSnapshot.data!["time"]}",
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
                                                      subtitle: "${pSnapshot.data!["curriculum"]}",
                                                    ),

                                                    Column(
                                                      children: [
                                                        Center(child: Text(timeago.format(DateTime.parse(pSnapshot.data!["timestamp"].toDate().toString())),style: TextStyle(fontFamily: roboto_regular,color: Colors.blueGrey),)),
                                                        SizedBox(height: 5,),
                                                        pSnapshot.data!["isBooked"] == false ? Container(decoration: BoxDecoration(color: Colors.green.shade100,borderRadius: BorderRadius.circular(5)),child: Padding(
                                                          padding: const EdgeInsets.only(left: 8,right: 8),
                                                          child: Text("Available",style: TextStyle(color: Colors.green),),
                                                        )) : Container(decoration: BoxDecoration(color: Colors.red.shade100,borderRadius: BorderRadius.circular(5)),child: Padding(
                                                          padding: const EdgeInsets.only(left: 8,right: 8),
                                                          child: Text("Booked",style: TextStyle(color: Colors.red),),
                                                        ))

                                                      ],
                                                    ),
                                                  ],
                                                )

                                                /* Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text("Gender : ${snapshot.data!.docs[index]["gender"]}",),
                                    )),
                                SizedBox(width: 30,),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text("Class : ${snapshot.data!.docs[index]["class"]}"),
                                    )),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Subjects : ${snapshot.data!.docs[index]["subjects"]}"),
                                )),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text("Day/Week : ${snapshot.data!.docs[index]["dayPerWeek"]}"),
                                    )),
                                SizedBox(width: 20,),

                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text("Curriculum : ${snapshot.data!.docs[index]["curriculum"]}"),
                                    )),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Location : ${snapshot.data!.docs[index]["location"]}"),
                                )),
                            SizedBox(height: 10,),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text("Salary : ${snapshot.data!.docs[index]["salary"]}"),
                                )),*/
                                              ],
                                            ),
                                          ),),
                                      ));
                                }
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
