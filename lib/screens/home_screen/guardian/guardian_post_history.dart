import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                        color: bgColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width*0.410,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),
                                    child: Row(
                                      children: [
                                        Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(100),
                                                side: const BorderSide(color: Colors.black)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(icGender,width: 25,),
                                            )),
                                        const SizedBox(width: 5,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Gender",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                            Text("${snapshot.data!.docs[index]["gender"]}",style: const TextStyle(fontFamily: roboto_regular)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width*0.410,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),
                                    child: Row(
                                      children: [
                                        Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(100),
                                                side: const BorderSide(color: Colors.black)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(icClass,width: 25,),
                                            )),
                                        const SizedBox(width: 5,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Class",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                            Text("${snapshot.data!.docs[index]["class"]}",style: const TextStyle(fontFamily: roboto_regular)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              Container(
                                padding: const EdgeInsets.all(5),
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
                                            side: const BorderSide(color: Colors.black)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(icSubjects,width: 25,),
                                        )),
                                    const SizedBox(width: 5,),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Subjects",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                          Text("${snapshot.data!.docs[index]["subjects"]}",style: const TextStyle(fontFamily: roboto_regular)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width*0.410,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),
                                    child: Row(
                                      children: [
                                        Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(100),
                                                side: const BorderSide(color: Colors.black)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(icDay,width: 25,),
                                            )),
                                        const SizedBox(width: 5,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Day/Week",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                            Text("${snapshot.data!.docs[index]["dayPerWeek"]}",style: const TextStyle(fontFamily: roboto_regular)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width*0.410,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),
                                    child: Row(
                                      children: [
                                        Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(100),
                                                side: const BorderSide(color: Colors.black)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(icSalary,width: 25,color: Colors.grey[800],),
                                            )),
                                        const SizedBox(width: 5,),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Salary",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                              Text("${snapshot.data!.docs[index]["salary"]}",style: const TextStyle(fontFamily: roboto_regular,color: Colors.green)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              const SizedBox(height: 5,),
                              Container(
                                padding: const EdgeInsets.all(5),
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
                                            side: const BorderSide(color: Colors.black)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(icLocation,width: 25,),
                                        )),
                                    const SizedBox(width: 5,),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Location",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                          Text("${snapshot.data!.docs[index]["location"]}",style: const TextStyle(fontFamily: roboto_regular)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width*0.410,
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
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(icStudent,width: 25,),
                                            )),
                                        SizedBox(width: 5,),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Students",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                              Text("${snapshot.data!.docs[index]["student"]}",style: TextStyle(fontFamily: roboto_regular)),
                                            ],
                                          ),
                                        ),
                                        // Text("${snapshot.data!.docs[index]["salary"]}",style: TextStyle(fontFamily: roboto_regular,color: Colors.green)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width*0.410,
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
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(icTime,width: 25,),
                                            )),
                                        SizedBox(width: 5,),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Time",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                              Text("${snapshot.data!.docs[index]["time"]}",style: TextStyle(fontFamily: roboto_regular)),
                                            ],
                                          ),
                                        ),
                                        // Text("${snapshot.data!.docs[index]["salary"]}",style: TextStyle(fontFamily: roboto_regular,color: Colors.green)),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width: 148,
                                    // width: MediaQuery.of(context).size.width*0.410,
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
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(icCurriculum,width: 25,),
                                            )),
                                        SizedBox(width: 5,),
                                        Flexible(
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Curriculum",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                              Text("${snapshot.data!.docs[index]["curriculum"]}",style: TextStyle(fontFamily: roboto_regular)),],
                                          ),
                                        ),
                                        // Text("${snapshot.data!.docs[index]["salary"]}",style: TextStyle(fontFamily: roboto_regular,color: Colors.green)),
                                      ],
                                    ),
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
                                  }, text: "Delete", color: Colors.orange.shade400,),
                                  MiniCustomButton(onPress: (){
                                    Get.to(()=>UpdatePostScreen(),arguments: [snapshot.data!.docs[index].id]);
                                  }, text: "Edit", color: Colors.orange.shade400,),
                                ],
                              ),
                              SizedBox(height: 20,),
                              FutureBuilder<QuerySnapshot>(future: FirebaseFirestore.instance.collection("teacherRequest").where("postID", isEqualTo: snapshot.data!.docs.first.id.toString()).get(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> reqSnap){
                                    if(reqSnap.connectionState == ConnectionState.done){
                                      return GestureDetector(onTap: (){
                                        Get.to(()=>RequestedTeacherScreen(),arguments: snapshot.data!.docs.first.id.toString());
                                      },child: Container(
                                          height: 60,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.green.shade100,
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 10,),
                                              CircleAvatar(child: Text(reqSnap.data!.docs.length.toString()),backgroundColor: Colors.white,),
                                              SizedBox(width: 5,),
                                              Text("Tutor Requested!",style: TextStyle(fontSize: 18,),),
                                              SizedBox(width: 60,),
                                              Icon(Icons.keyboard_arrow_right_rounded)
                                            ],
                                          )));
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
