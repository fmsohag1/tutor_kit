import 'package:flutter/material.dart';
import 'package:tutor_kit/bloc/crud_db.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:tutor_kit/widgets/custom_textfield.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  final TextEditingController genderController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController dayPerWeekController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController curriculumController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(preffixIcon: Icons.male_outlined, type: TextInputType.text, controller: genderController, hint: "Gender"),
              SizedBox(height: 5,),
              CustomTextField(preffixIcon: Icons.clear_all_outlined, type: TextInputType.text, controller: classController, hint: "Class"),
              SizedBox(height: 5,),
              CustomTextField(preffixIcon: Icons.currency_rupee_outlined, type: TextInputType.text, controller: salaryController, hint: "Salary"),
              SizedBox(height: 5,),
              CustomTextField(preffixIcon: Icons.timelapse_outlined, type: TextInputType.text, controller: dayPerWeekController, hint: "Day/Week"),
              SizedBox(height: 5,),
              CustomTextField(preffixIcon: Icons.location_on_rounded, type: TextInputType.text, controller: locationController, hint: "Location"),
              SizedBox(height: 5,),
              CustomTextField(preffixIcon: Icons.sell_outlined, type: TextInputType.text, controller: curriculumController, hint: "Curriculum"),
              SizedBox(height: 5,),
              CustomTextField(preffixIcon: Icons.book_outlined, type: TextInputType.text, controller: subjectController, hint: "Subjects"),
              SizedBox(
                height: 20,
              ),
              /*ElevatedButton(
                  onPressed: () {
                    CrudDb().addPost(
                        genderController.text,
                        classController.text,
                        salaryController.text,
                        dayPerWeekController.text,
                        locationController.text,
                        curriculumController.text,
                        subjectController.text);
                  },
                  child: Text("Post")),*/
              CustomButton(onPress: (){
                CrudDb().addPost(
                    genderController.text,
                    classController.text,
                    salaryController.text,
                    dayPerWeekController.text,
                    locationController.text,
                    curriculumController.text,
                    subjectController.text);
              }, text: Text(txtPost,style: TextStyle(fontFamily: kalpurush,color: bgColor,fontSize: 18,letterSpacing: 1),), color: buttonColor)
            ],
          ),
        ),
      )),
      /*floatingActionButton: FloatingActionButton(onPressed: (){
        CrudDb().readPost();
      }),*/
    );
  }
}
