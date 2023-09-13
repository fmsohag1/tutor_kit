import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/bloc/crud_db.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/home_screen/posts_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:tutor_kit/widgets/custom_textfield.dart';
import 'package:tutor_kit/widgets/dropdownbutton.dart';

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
  final TextEditingController studentController = TextEditingController();


  var auth = FirebaseAuth.instance;

  String? chooseGender;
  String? chooseDay;
  String? chooseCurriculum;
  String? chooseStudent;
  //String? chooseClass;
  List genderList=["Male","Female","Both"];
  List dayList=['1 Days','2 Days','3 Days','4 Days','5 Days','6 Days','7 Days'];
  List studentList=['1','2','3','4','5'];
  List curriculumList=["Bangla Version","English Version",'Madrasha Version'];
  //List classList=['Nursery','Kindergarten(KG)','One','Two','Three','Four','Five','Six','Seven','Eight','Nine','Ten','SSC Examinees','Intermediate 1st year','Intermediate 2nd year','HSC Examinees'];
  bool isTime=false;

  TimeOfDay _timeOfDay=TimeOfDay(hour: 8,minute: 30);

  void _showTimePicker(){
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),

    ).then((value){
      setState(() {
        _timeOfDay=value!;
        isTime=true;
      });
    });

  }
  // var timestamp = DateTime;
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("Create a Post",style: TextStyle(fontFamily: roboto_medium,fontSize: 22,letterSpacing: 1),),
                  ],
                ),
                SizedBox(height: 20,),
                CustomDropDownButton(hint: "Gender", prefixIcon: Image.asset(icGender25), value: chooseGender, list: genderList,onChange: (newValue){
                  chooseGender=newValue as String;
                },),
                SizedBox(height: 5,),
                CustomDropDownButton(hint: 'No of Students', prefixIcon: Image.asset(icStudent25), value: chooseStudent, list: studentList,onChange: (newValue){
                  chooseStudent=newValue as String;
                },),
                //CustomTextField(preffixIcon: Image.asset(icClass25), type: TextInputType.text, controller: studentController, hint: 'No of Students',label: 'No of Students',),
                //CustomTextField(preffixIcon: Image.asset(icGender25), type: TextInputType.text, controller: genderController, hint: "Gender"),
                SizedBox(height: 7,),
                /*CustomDropDownButton(hint: "Class", prefixIcon: Image.asset(icClass25), value: chooseClass, list: classList,onChange: (newValue){
                  chooseClass=newValue as String;
                },),*/
                CustomTextField(label: "Class",preffixIcon: Image.asset(icClass25), type: TextInputType.text, controller: classController, hint: "Seven,Ten..etc"),
                SizedBox(height: 7,),
                CustomTextField(label: "Salary",preffixIcon: Image.asset(icSalary25), type: TextInputType.text, controller: salaryController, hint: "5000,Negotiable"),
                SizedBox(height: 5,),
               CustomDropDownButton(hint: "Day/Week", prefixIcon: Image.asset(icDay25), value: chooseDay, list: dayList,onChange: (newValue){
                 chooseDay=newValue as String;
               },),
               // CustomTextField(preffixIcon: Image.asset(icDay25), type: TextInputType.text, controller: dayPerWeekController, hint: "Day/Week"),
                SizedBox(height: 7,),
                CustomTextField(label:"Location",preffixIcon: Image.asset(icLocation25), type: TextInputType.text, controller: locationController, hint: "West Larpara,Bus Terminal,Cox's bazar."),
                SizedBox(height: 5,),
                CustomDropDownButton(hint: "Curriculum", prefixIcon: Image.asset(icCurriculum25), value: chooseCurriculum, list: curriculumList,onChange: (newValue){
                  chooseCurriculum=newValue as String;
                },),
                //CustomTextField(preffixIcon: Image.asset(icCurriculum25), type: TextInputType.text, controller: curriculumController, hint: "Curriculum"),
                SizedBox(height: 7,),
                CustomTextField(label:"Subjects",preffixIcon: Image.asset(icSubjects25), type: TextInputType.text, controller: subjectController, hint: "Math,English,Physics..etc"),
                SizedBox(height: 5,),
                GestureDetector(
                  onTap: _showTimePicker,
                  child: Container(
                    height: 65,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Image.asset(icTime25),
                        SizedBox(width: 12,),
                        isTime?Text(_timeOfDay.format(context).toString(),style: TextStyle(fontSize: 17),):Text("Select Time",style: TextStyle(fontFamily: roboto_regular,fontSize: 17,color: Colors.grey),),

                      ],
                    )
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(onPress: (){
                  setState(() {

                  });
                  CrudDb().addPost(
                      //genderController.text,
                      chooseGender.toString(),
                      classController.text,
                      salaryController.text,
                      chooseDay.toString(),
                      //dayPerWeekController.text,
                      locationController.text,
                      chooseCurriculum.toString(),
                      //curriculumController.text,
                      subjectController.text,
                      auth.currentUser!.phoneNumber.toString(),
                      FieldValue.serverTimestamp(),
                    chooseStudent.toString(),
                    _timeOfDay.format(context).toString(),
                  );
                }, text: Text(txtPost,style: TextStyle(fontFamily: roboto_regular,color: buttonColor,fontSize: 18,letterSpacing: 1),), color: Colors.white)
              ],
            ),
          ),
        )),
      ),
      /*floatingActionButton: FloatingActionButton(onPressed: (){
        CrudDb().readPost();
      }),*/
      floatingActionButton: FloatingActionButton(onPressed: (){Get.to(()=>PostsScreen());}),
    );
  }
}
