import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tutor_kit/screens/home_screen/post_details_screen.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({super.key});

  final postsRef = FirebaseFirestore.instance.collection("posts").orderBy("timestamp",descending: true);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userPhoneNumber = box.read("userPhone");
    return  Scaffold(
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
            return const Center(child: Text("No posts available"),);
          }
          // final data = snapshot.requireData;
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
              Timestamp timestamp = snapshot.data!.docs[index]["timestamp"];
            return Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
              child: GestureDetector(
                onTap: (){
                  Get.to(()=>PostDetailesScreen(),arguments: snapshot.data!.docs[index].id);
                },
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
                                      child: Image.asset(icGender,width: 25,),
                                    )),
                                SizedBox(width: 5,),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Gender",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                      Text("${snapshot.data!.docs[index]["gender"]}",style: TextStyle(fontFamily: roboto_regular)),
                                    ],
                                  ),
                                )
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
                                      child: Image.asset(icClass,width: 25,),
                                    )),
                                SizedBox(width: 5,),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Class",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                      Text("${snapshot.data!.docs[index]["class"]}",style: TextStyle(fontFamily: roboto_regular),),
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
                                  Text("${snapshot.data!.docs[index]["subjects"]}",style: TextStyle(fontFamily: roboto_regular)),
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
                                      child: Image.asset(icDay,width: 25,),
                                    )),
                                SizedBox(width: 5,),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Day/Week",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                      Text("${snapshot.data!.docs[index]["dayPerWeek"]}",style: TextStyle(fontFamily: roboto_regular)),
                                    ],
                                  ),
                                )
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
                                      child: Image.asset(icSalary,width: 25,color: Colors.grey[800],),
                                    )),
                                SizedBox(width: 5,),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Salary",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                      Text("${snapshot.data!.docs[index]["salary"]}",style: TextStyle(fontFamily: roboto_regular,color: Colors.green)),
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
                                  Text("${snapshot.data!.docs[index]["location"]}",style: TextStyle(fontFamily: roboto_regular)),
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
          });

        }),
      )
    );
  }
}
