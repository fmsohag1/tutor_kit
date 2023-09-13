import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tutor_kit/widgets/custom_button.dart';

import '../../const/colors.dart';
import '../../const/images.dart';
import '../../const/styles.dart';

class PostDetailesScreen extends StatelessWidget {
   PostDetailesScreen({super.key});

  var docId = Get.arguments;


  @override
  Widget build(BuildContext context) {
    CollectionReference posts = FirebaseFirestore.instance.collection("posts");
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<DocumentSnapshot>(
              future: posts.doc(docId).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasError){
                  return const Text("Something went wrong");
                }
                if(snapshot.hasData && !snapshot.data!.exists){
                  return const Text("Document does not exist");
                }
                if(snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  Timestamp timestamp = data["timestamp"];
                  return Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.black)
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
                                  padding: EdgeInsets.all(5),
                                  width: 145,
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
                                            child: Image.asset(icGender,width: 25,),
                                          )),
                                      SizedBox(width: 5,),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Gender",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                            Text("${data["gender"]}",style: TextStyle(fontFamily: roboto_regular)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: 145,
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
                                            child: Image.asset(icClass,width: 25,),
                                          )),
                                      SizedBox(width: 5,),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Class",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                            Text("${data["class"]}",style: TextStyle(fontFamily: roboto_regular),),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(icSubjects,width: 25,),
                                      )),
                                  SizedBox(width: 5,),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Subjects",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                        Text("${data["subjects"]}",style: TextStyle(fontFamily: roboto_regular)),
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
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: 150,
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
                                            child: Image.asset(icDay,width: 25,),
                                          )),
                                      SizedBox(width: 5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Day/Week",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                          Text("${data["dayPerWeek"]}",style: TextStyle(fontFamily: roboto_regular)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: 145,
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
                                            child: Image.asset(icSalary,width: 25,),
                                          )),
                                      SizedBox(width: 5,),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Salary",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                            Text("${data["salary"]}",style: TextStyle(fontFamily: roboto_regular,color: Colors.green)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 5,),
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(icLocation,width: 25,),
                                      )),
                                  SizedBox(width: 5,),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Location",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                        Text("${data["location"]}",style: TextStyle(fontFamily: roboto_regular)),
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
                                Container(
                                  padding: EdgeInsets.all(5),
                                  // width: double.infinity,
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
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Curriculum",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                          Text("${data["curriculum"]}",style: TextStyle(fontFamily: roboto_regular)),
                                        ],
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
                            SizedBox(height: 30,),
                            CustomButton(onPress: (){
                              showDialog(context: context, builder: (BuildContext context){
                                return Dialog(
                                  child: Container(
                                    height: 350,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Lottie.asset(height: 200,"assets/icons/animation_lmej1fs8.json"),
                                        Text("Request Sent"),
                                        CustomButton(onPress: (){Get.back();}, text: Text("Okay"), color: Colors.green)

                                      ],
                                    ),
                                  ),
                                );
                              });
                            }, text: Text("Request Tution"), color: Colors.white)
                          ],
                        ),
                      ),),
                  );
                }
                return CircularProgressIndicator();
              }
          ),
        ),
      ),
    );
  }
}
