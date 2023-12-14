import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/bloc/crud_db.dart';
import 'package:tutor_kit/const/colors.dart';
import 'package:tutor_kit/widgets/custom_button.dart';

import '../../../const/images.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/dropdownbutton.dart';

class UpdateTeacherProfileScreen extends StatefulWidget {
   UpdateTeacherProfileScreen({super.key});

  @override
  State<UpdateTeacherProfileScreen> createState() => _UpdateTeacherProfileScreenState();
}

class _UpdateTeacherProfileScreenState extends State<UpdateTeacherProfileScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController prefClassController = TextEditingController();

  final TextEditingController prefSubjectController = TextEditingController();

  final TextEditingController qualificationController = TextEditingController();

  final TextEditingController instituteController = TextEditingController();

  final TextEditingController departmentController = TextEditingController();

   String? chooseGender;

   List genderList=["Male","Female","Both"];

   bool isDate = false;

   DateTime _dateTime = DateTime.now();

   void _showDatePicker() {
     showDatePicker(
       context: context,
       initialDate: _dateTime,
       firstDate: DateTime(1980),
       lastDate: DateTime(3000),
     ).then((value) {
       setState(() {
         _dateTime = value!;
         isDate = true;
       });
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor2,
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
                        child: AnimationLimiter(
                          child: Column(
                            children: AnimationConfiguration.toStaggeredList(
                              duration: Duration(milliseconds: 200),
                                childAnimationBuilder: (widget)=>SlideAnimation(
                                    verticalOffset: 50,
                                    child: FadeInAnimation(child: widget)
                                ),
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Update Profile",
                                        style: TextStyle(
                                            fontSize: 22,
                                            letterSpacing: 1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(label: "Name", preffixIcon: CircleAvatar(child: SvgPicture.asset(icName,),backgroundColor: Colors.transparent,),
                                      type: TextInputType.text, controller: nameController..text = "${data["name"]}", hint: "Name"),

                                  SizedBox(height: 5,),
                                  CustomTextField(label: "Age", preffixIcon: CircleAvatar(child: SvgPicture.asset(icAge,),backgroundColor: Colors.transparent,),
                                      type: TextInputType.text, controller: ageController..text = "${data["dob"]}", hint: "Age"),
                                  SizedBox(height: 5,),
                                  CustomTextField(label: "Address", preffixIcon: CircleAvatar(child: SvgPicture.asset(icLocation,),backgroundColor: Colors.transparent,),
                                      type: TextInputType.text, controller: addressController..text = "${data["address"]}", hint: "Address"),
                                  SizedBox(height: 5,),
                                  CustomTextField(label: "Preferable Class", preffixIcon: CircleAvatar(child: SvgPicture.asset(icClass,),backgroundColor: Colors.transparent,),
                                      type: TextInputType.text, controller: prefClassController..text = "${data["prefClass"]}", hint: "Preferable Class"),
                                  SizedBox(height: 5,),
                                  CustomTextField(label: "Preferable Subject", preffixIcon: CircleAvatar(child: SvgPicture.asset(icSubjects,),backgroundColor: Colors.transparent,),
                                      type: TextInputType.text, controller: prefSubjectController..text = "${data["prefSubjects"]}", hint: "Preferable Subject"),
                                  SizedBox(height: 5,),
                                  CustomTextField(label: "Qualification", preffixIcon: CircleAvatar(child: SvgPicture.asset(icQualification,),backgroundColor: Colors.transparent,),
                                      type: TextInputType.text, controller: qualificationController..text = "${data["qualification"]}", hint: "Qualification"),
                                  SizedBox(height: 5,),
                                  CustomTextField(label: "Institute", preffixIcon: CircleAvatar(child: SvgPicture.asset(icInstitute,),backgroundColor: Colors.transparent,),
                                      type: TextInputType.text, controller: instituteController..text = "${data["institute"]}", hint: "Institute"),
                                  SizedBox(height: 5,),
                                  CustomTextField(label: "Section/Department", preffixIcon: CircleAvatar(child: SvgPicture.asset(icDepartment,),backgroundColor: Colors.transparent,),
                                      type: TextInputType.text, controller: departmentController..text = "${data["department"]}", hint: "Section/Department"),
                                  SizedBox(height: 15,),
                                  CustomButton(onPress: (){
                                    showDialog(barrierDismissible: false,context: context, builder: (context){
                                      return Dialog(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                CircularProgressIndicator(color: Colors.black12,),
                                                SizedBox(width: 10,),
                                                Text("Loading...",style: TextStyle(fontSize: 18),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                    CrudDb().updateTeacherProfile(
                                        nameController.text.trim(),
                                        ageController.text.trim(),
                                        addressController.text.trim(),
                                        prefClassController.text.trim(),
                                        prefSubjectController.text.trim(),
                                        qualificationController.text.trim(),
                                        instituteController.text.trim(),
                                        departmentController.text.trim(),

                                    );
                                  }, text: "Update", color: Colors.grey.shade600)
                                  /*ElevatedButton(onPressed: (){
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
                              }, child: Text("Update"))*/
                                ],
                            )
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator(color: Colors.black12,strokeAlign: -1,));
                }
            ),
          )
      )
    );
  }
}