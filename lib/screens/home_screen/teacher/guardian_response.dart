import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/screens/home_screen/teacher/pay_bill.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_status_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';


import '../../../const/colors.dart';
import '../../../const/images.dart';
import '../../../const/styles.dart';
import 'PostScreen/widget/postdata.dart';


class GuardianResponse extends StatefulWidget {
  GuardianResponse({super.key});

  @override
  State<GuardianResponse> createState() => _GuardianResponseState();
}

class _GuardianResponseState extends State<GuardianResponse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection("guardianResponse").where("tEmail", isEqualTo: FirebaseAuth.instance.currentUser!.email.toString()).get(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.data!.docs.length == 0){
                    return Center(child: Text("No data found"),);
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                        return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance.collection("posts").doc(snapshot.data!.docs[index]["postId"].toString()).get(),
                            builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> detSnapshot){
                              if(detSnapshot.connectionState == ConnectionState.done){
                                print(detSnapshot.data!["class"]);
                                return Padding(
                                    padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                                    child: GestureDetector(
                                      onTap: (){
                                      },
                                      child: Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: BorderSide(color: Colors.black)
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
                                                    subtitle: detSnapshot.data!["gender"],
                                                  ),
                                                  PostData(
                                                    icon: SvgPicture.asset(icClass),
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.410,
                                                    title: "Class",
                                                    subtitle: detSnapshot.data!["class"],
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
                                                subtitle: detSnapshot.data!["subjects"],
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
                                                    subtitle: detSnapshot.data!["dayPerWeek"],
                                                  ),
                                                  PostData(
                                                    icon: SvgPicture.asset(icSalary,width: 20,),
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.410,
                                                    title: "Salary",
                                                    subtitle: detSnapshot.data!["salary"],
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
                                                subtitle: detSnapshot.data!["location"],
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
                                                    subtitle: detSnapshot.data!["student"],
                                                  ),
                                                  PostData(
                                                    icon: SvgPicture.asset(icTime),
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.410,
                                                    title: "Time",
                                                    subtitle: detSnapshot.data!["time"],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  PostData(
                                                    icon: SvgPicture.asset(icCurriculum),
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.410,
                                                    title: "Curriculum",
                                                    subtitle: detSnapshot.data!["curriculum"],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              StreamBuilder(
                                                  stream: FirebaseFirestore.instance.collection("teacherTransactionStatus").where("tEmail", isEqualTo: FirebaseAuth.instance.currentUser!.email).where("postId", isEqualTo: detSnapshot.data!.id).snapshots(),
                                                  builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> tranSnap){
                                                    if (tranSnap.hasError) {
                                                      return Text('Something went wrong');
                                                    }
                                                    if (tranSnap.connectionState == ConnectionState.waiting) {
                                                      return CircularProgressIndicator();
                                                    }
                                                    if(tranSnap.data!.docs.isNotEmpty){
                                                      return CustomButton(onPress: (){
                                                        Get.to(()=>TeacherStatusScreen(),arguments: detSnapshot.data!.id);
                                                      }, text: "See status", color: Colors.grey.shade600);
                                                    }
                                                    if(tranSnap.data!.docs.isEmpty){
                                                      return CustomButton(onPress: (){
                                                        Get.to(()=>PayBill(),arguments: [detSnapshot.data!["salary"], detSnapshot.data!.id]);
                                                      }, text: "Get this tution", color: Colors.grey.shade600);
                                                    }
                                                    return SizedBox();
                                                  }
                                              ),

                                            ],
                                          ),
                                        ),),
                                    ));
                              }
                              return Center(child: CircularProgressIndicator());
                            }
                        );
                      }
                  );
                }
                return Center(child: CircularProgressIndicator());
              }
          )
      ),
    );
  }
}

/*Padding(
padding: const EdgeInsets.all(8.0),
child: Card(
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
Column(
children: [
Text(detSnapshot.data!["class"]),
Text(detSnapshot.data!["salary"]),
Text(detSnapshot.data!["curriculum"]),
Text(detSnapshot.data!["location"]),
],
),
SizedBox(width: 50,),
Expanded(
child: Padding(
padding: const EdgeInsets.only(left: 10,right: 10),
child: FutureBuilder(
future: FirebaseFirestore.instance.collection("teacherTransactionStatus").where("tEmail", isEqualTo: FirebaseAuth.instance.currentUser!.email).where("postId", isEqualTo: detSnapshot.data!.id).get(),
builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> tranSnap){
if(tranSnap.connectionState == ConnectionState.done){
if(tranSnap.data!.docs.isNotEmpty){
return ElevatedButton(onPressed: (){
Get.to(()=>TeacherStatusScreen(),arguments: detSnapshot.data!.id);
}, child: Row(children: [Text("See status"),Icon(Icons.arrow_forward)],));
}
if(tranSnap.data!.docs.isEmpty){
return ElevatedButton(onPressed: (){
Get.to(()=>PayBill(),arguments: [detSnapshot.data!["salary"], detSnapshot.data!.id]);
}, child: Row(children: [Text("Get this tution"),Icon(Icons.arrow_forward)],));
}
print(tranSnap.data!.docs.isNotEmpty);
}
return LinearProgressIndicator();
}
),
),
),
],
),
),
)*/
// FutureBuilder(
// future: FirebaseFirestore.instance.collection("teacherTransactionStatus").where("tEmail", isEqualTo: FirebaseAuth.instance.currentUser!.email).where("postId", isEqualTo: detSnapshot.data!.id).get(),
// builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> tranSnap){
// if(tranSnap.connectionState == ConnectionState.done){
// if(tranSnap.data!.docs.isNotEmpty){
// return CustomButton(onPress: (){
// Get.to(()=>TeacherStatusScreen(),arguments: detSnapshot.data!.id);
// }, text: "See status", color: Colors.grey.shade600);
// }
// if(tranSnap.data!.docs.isEmpty){
// return CustomButton(onPress: (){
// Get.to(()=>PayBill(),arguments: [detSnapshot.data!["salary"], detSnapshot.data!.id]);
// }, text: "Get this tution", color: Colors.grey.shade600);
// }
// print(tranSnap.data!.docs.isNotEmpty);
// }
// return Center(child: CircularProgressIndicator());
// }
// ),