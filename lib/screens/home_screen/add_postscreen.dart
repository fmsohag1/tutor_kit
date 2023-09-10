import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/bloc/crud_db.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/home_screen/posts_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:tutor_kit/widgets/custom_textfield.dart';

class AddPostScreen extends StatefulWidget {
  AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController genderController = TextEditingController();

  final TextEditingController classController = TextEditingController();

  final TextEditingController salaryController = TextEditingController();

  final TextEditingController dayPerWeekController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController curriculumController = TextEditingController();

  final TextEditingController subjectController = TextEditingController();

  var auth = FirebaseAuth.instance;

  // var timestamp = DateTime;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(preffixIcon: Image.asset(icGender25), type: TextInputType.text, controller: genderController, hint: "Gender"),
              SizedBox(height: 5,),
              CustomTextField(preffixIcon: Image.asset(icClass25), type: TextInputType.text, controller: classController, hint: "Class"),
              SizedBox(height: 5,),
              CustomTextField(preffixIcon: Image.asset(icSalary25), type: TextInputType.text, controller: salaryController, hint: "Salary"),
              SizedBox(height: 5,),
              CustomTextField(preffixIcon: Image.asset(icDay25), type: TextInputType.text, controller: dayPerWeekController, hint: "Day/Week"),
              SizedBox(height: 5,),
              CustomTextField(preffixIcon: Image.asset(icLocation25), type: TextInputType.text, controller: locationController, hint: "Location"),
              SizedBox(height: 5,),
              CustomTextField(preffixIcon: Image.asset(icCurriculum25), type: TextInputType.text, controller: curriculumController, hint: "Curriculum"),
              SizedBox(height: 5,),
              CustomTextField(preffixIcon: Image.asset(icSubjects25), type: TextInputType.text, controller: subjectController, hint: "Subjects"),
              SizedBox(
                height: 20,
              ),
              CustomButton(onPress: (){
                setState(() {

                });
                CrudDb().addPost(
                    genderController.text,
                    classController.text,
                    salaryController.text,
                    dayPerWeekController.text,
                    locationController.text,
                    curriculumController.text,
                    subjectController.text,
                    auth.currentUser!.phoneNumber.toString(),
                    FieldValue.serverTimestamp(),
                );
              }, text: Text(txtPost,style: TextStyle(fontFamily: kalpurush,color: buttonColor,fontSize: 18,letterSpacing: 1),), color: Colors.white)
            ],
          ),
        ),
      )),
      /*floatingActionButton: FloatingActionButton(onPressed: (){
        CrudDb().readPost();
      }),*/
      floatingActionButton: FloatingActionButton(onPressed: (){Get.to(()=>PostsScreen());}),
    );
  }
}
