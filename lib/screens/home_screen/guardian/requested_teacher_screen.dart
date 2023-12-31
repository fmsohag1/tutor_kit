import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tutor_kit/screens/home_screen/guardian/requested_teacher_detailes_screen.dart';

import '../../../const/colors.dart';
import '../../../const/images.dart';

class RequestedTeacherScreen extends StatelessWidget {
  RequestedTeacherScreen({super.key});
  var docId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor2,
      body: SafeArea(
        child: Center(
            child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection("teacherRequest").where("postID", isEqualTo: docId.toString()).get(),
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.data!.docs.isEmpty){
                      return Center(child: Text("No requests found!"),);
                    }
                    return AnimationLimiter(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index){
                            List numList =[];
                            for (var element in snapshot.data!.docs) {
                              numList.add(element["email"]);
                            }
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              delay: Duration(milliseconds: 100),
                              child: SlideAnimation(
                                duration: Duration(milliseconds: 2500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  duration: Duration(milliseconds: 2500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: FutureBuilder<QuerySnapshot>(
                                      future: FirebaseFirestore.instance.collection("userInfo").where("email", whereIn: numList).get(),
                                      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> detSnapshot){
                                        if(detSnapshot.connectionState == ConnectionState.done){
                                          return Padding(
                                            padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
                                            child: GestureDetector(
                                              onTap: (){
                                                Get.to(()=>RequestedTeacherDetailsScreen(),arguments: [detSnapshot.data!.docs[index]["email"],docId]);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: Colors.black12),
                                                  color: bgColor2,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(10),
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: Colors.white
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(child: Text(detSnapshot.data!.docs[index]["name"][0],style: TextStyle(fontSize: 30),),backgroundColor: primary,radius: 25,),

                                                            SizedBox(width: 5,),
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  //Text("Name",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                                                  Text(detSnapshot.data!.docs[index]["name"],style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 5,),
                                                      Container(
                                                        padding: EdgeInsets.all(5),
                                                        width: double.infinity,

                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(icInstitute,width: 20,),
                                                            SizedBox(width: 10,),
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  //Text("Gender",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                                                  Text(detSnapshot.data!.docs[index]["institute"],),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.all(5),
                                                        width:double.infinity,

                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(icDepartment,width: 20,),
                                                            SizedBox(width: 10,),
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  //Text("Age",style: TextStyle(fontSize: 16,),),
                                                                  Text(detSnapshot.data!.docs[index]["department"]),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                                                color: Colors.white
                                                            ),
                                                            child: Center(child: Text("Details>>",style: TextStyle(color: Colors.green,),)),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        return Center(child: LinearProgressIndicator(color: Colors.black12,));
                                      }
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator(color: Colors.black12,strokeAlign: -1,));
                }
            )
        ),
      ),
    );
  }
}

