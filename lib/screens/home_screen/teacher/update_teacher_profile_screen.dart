import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/bloc/crud_db.dart';

class UpdateTeacherProfileScreen extends StatelessWidget {
   UpdateTeacherProfileScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController prefClassController = TextEditingController();
  final TextEditingController prefSubjectController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController instituteController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: FutureBuilder(
                future: FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get(),
                builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
                  if(snapshot.hasError){
                    return Text("Something went wrong");
                  }
                  if(snapshot.hasData && !snapshot.data!.exists){
                    return Text("Document does not exist");
                  }
                  if(snapshot.connectionState == ConnectionState.done){
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              controller: nameController..text = "${data["name"]}",
                              decoration: InputDecoration(
                                label: Text("name")
                              ),
                            ),
                            TextField(
                              controller: genderController..text = "${data["gender"]}",
                              decoration: InputDecoration(
                                  label: Text("gender")
                              ),
                            ),
                            TextField(
                              controller: ageController..text = "${data["dob"]}",
                              decoration: InputDecoration(
                                  label: Text("age")
                              ),
                            ),
                            TextField(
                              controller: addressController..text = "${data["address"]}",
                              decoration: InputDecoration(
                                  label: Text("address")
                              ),
                            ),
                            TextField(
                              controller: prefClassController..text = "${data["prefClass"]}",
                              decoration: InputDecoration(
                                  label: Text("prefClass")
                              ),
                            ),
                            TextField(
                              controller: prefSubjectController..text = "${data["prefSubjects"]}",
                              decoration: InputDecoration(
                                  label: Text("prefSubject")
                              ),
                            ),
                            TextField(
                              controller: qualificationController..text = "${data["qualification"]}",
                              decoration: InputDecoration(
                                  label: Text("qualification")
                              ),
                            ),
                            TextField(
                              controller: instituteController..text = "${data["institute"]}",
                              decoration: InputDecoration(
                                  label: Text("institute")
                              ),
                            ),
                            TextField(
                              controller: departmentController..text = "${data["department"]}",
                              decoration: InputDecoration(
                                  label: Text("department")
                              ),
                            ),
                            SizedBox(height: 15,),
                            ElevatedButton(onPressed: (){
                              showDialog(barrierDismissible: false,context: context, builder: (context){
                                return Dialog(
                                  child: Container(
                                    height: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                );
                              });
                              CrudDb().updateTeacherProfile(
                                  nameController.text.trim(),
                                  genderController.text.trim(),
                                  ageController.text.trim(),
                                  addressController.text.trim(),
                                  prefClassController.text.trim(),
                                  prefSubjectController.text.trim(),
                                  qualificationController.text.trim(),
                                  instituteController.text.trim(),
                                  departmentController.text.trim()
                              );
                            }, child: Text("Update"))
                          ],
                        ),
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                }
            ),
          )
      )
    );
  }
}