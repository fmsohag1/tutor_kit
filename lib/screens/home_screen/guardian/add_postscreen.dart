import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/bloc/crud_db.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/home_screen/teacher/PostScreen/screen/posts_screen.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_form_screens.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_home.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var auth = FirebaseAuth.instance;

  String? chooseGender;
  String? chooseDay;
  String? chooseCurriculum;
  String? chooseStudent;
  //String? chooseClass;
  List<String> genderList = ["Male", "Female", "Both"];
  List<String> dayList = [
    '1 Days',
    '2 Days',
    '3 Days',
    '4 Days',
    '5 Days',
    '6 Days',
    '7 Days'
  ];
  List<String> studentList = ['1', '2', '3', '4', '5'];
  List<String> curriculumList = ["Bangla", "English", 'Madrasha'];
  //List classList=['Nursery','Kindergarten(KG)','One','Two','Three','Four','Five','Six','Seven','Eight','Nine','Ten','SSC Examinees','Intermediate 1st year','Intermediate 2nd year','HSC Examinees'];
  bool isTime = false;

  TimeOfDay _timeOfDay = TimeOfDay(hour: 8, minute: 30);

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
        isTime = true;
      });
    });
  }
  // String? deviceToken;
  //
  // void getToken()async{
  //   await FirebaseMessaging.instance.getToken().then((token) {
  //     setState(() {
  //       deviceToken = token;
  //       if (kDebugMode) {
  //         print('DeviceToken : $deviceToken');
  //       }
  //     });
  //   });
  // }


  @override
  // var timestamp = DateTime;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Create a Post",
                            style: TextStyle(
                                fontSize: 22,
                                letterSpacing: 1),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomDropDownButton(
                        hint: "Gender",
                        prefixIcon: CircleAvatar(child: SvgPicture.asset(icGender,color: Colors.black87,),backgroundColor: Colors.transparent,),
                        value: chooseGender,
                        list: genderList,
                        onChange: (newValue) {
                          chooseGender = newValue as String;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please choose your gender!';
                          }
                          return null;
                        },
                        autoValidate: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomDropDownButton(
                        hint: 'No of Students',
                        prefixIcon: CircleAvatar(child: SvgPicture.asset(icStudent),backgroundColor: Colors.transparent,),
                        value: chooseStudent,
                        list: studentList,
                        onChange: (newValue) {
                          chooseStudent = newValue as String;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please choose your students!';
                          }
                          return null;
                        },
                        autoValidate: AutovalidateMode.onUserInteraction,
                      ),
                      //CustomTextField(preffixIcon: Image.asset(icClass25), type: TextInputType.text, controller: studentController, hint: 'No of Students',label: 'No of Students',),
                      //CustomTextField(preffixIcon: Image.asset(icGender25), type: TextInputType.text, controller: genderController, hint: "Gender"),
                      SizedBox(
                        height: 7,
                      ),
                      /*CustomDropDownButton(hint: "Class", prefixIcon: Image.asset(icClass25), value: chooseClass, list: classList,onChange: (newValue){
                    chooseClass=newValue as String;
                  },),*/
                      CustomTextField(
                        label: "Class",
                        preffixIcon: CircleAvatar(child: SvgPicture.asset(icClass),backgroundColor: Colors.transparent,),
                        type: TextInputType.text,
                        controller: classController,
                        hint: "Seven,Ten..etc",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your class';
                          }
                          return null;
                        },
                        autoValidate: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        label: "Salary",
                        preffixIcon: CircleAvatar(child: SvgPicture.asset(icSalary,width: 16,color: Colors.black87,),backgroundColor: Colors.transparent,),
                        type: TextInputType.number,
                        controller: salaryController,
                        hint: "5000,Negotiable",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your salary';
                          }
                          return null;
                        },
                        autoValidate: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomDropDownButton(
                        hint: "Day/Week",
                        prefixIcon: CircleAvatar(child: SvgPicture.asset(icDay,),backgroundColor: Colors.transparent,),
                        value: chooseDay,
                        list: dayList,
                        onChange: (newValue) {
                          chooseDay = newValue as String;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your days!';
                          }
                          return null;
                        },
                        autoValidate: AutovalidateMode.onUserInteraction,
                      ),
                      // CustomTextField(preffixIcon: Image.asset(icDay25), type: TextInputType.text, controller: dayPerWeekController, hint: "Day/Week"),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        label: "Location",
                        preffixIcon: CircleAvatar(child: SvgPicture.asset(icLocation,),backgroundColor: Colors.transparent,),
                        type: TextInputType.text,
                        controller: locationController,
                        hint: "West Larpara,Bus Terminal,Cox's bazar.",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your location!';
                          }
                          return null;
                        },
                        autoValidate: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomDropDownButton(
                        hint: "Curriculum",
                        prefixIcon: CircleAvatar(child: SvgPicture.asset(icCurriculum,),backgroundColor: Colors.transparent,),
                        value: chooseCurriculum,
                        list: curriculumList,
                        onChange: (newValue) {
                          chooseCurriculum = newValue as String;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please choose your curriculum!';
                          }
                          return null;
                        },
                        autoValidate: AutovalidateMode.onUserInteraction,
                      ),
                      //CustomTextField(preffixIcon: Image.asset(icCurriculum25), type: TextInputType.text, controller: curriculumController, hint: "Curriculum"),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        label: "Subjects",
                        preffixIcon: CircleAvatar(child: SvgPicture.asset(icSubjects,),backgroundColor: Colors.transparent,),
                        type: TextInputType.text,
                        controller: subjectController,
                        hint: "Math,English,Physics..etc",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your subjects!';
                          }
                          return null;
                        },
                        autoValidate: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: _showTimePicker,
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.085,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.black12),
                                color: Colors.white),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(icTime,),
                                SizedBox(
                                  width: 12,
                                ),
                                isTime
                                    ? Text(
                                  _timeOfDay.format(context).toString(),
                                  style: TextStyle(fontSize: 17),
                                )
                                    : Text(
                                  "Select Time",
                                  style: TextStyle(
                                      fontFamily: roboto_regular,
                                      fontSize: 17,
                                      color: Colors.grey),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              CrudDb().addPost(
                                chooseGender.toString(),
                                classController.text,
                                salaryController.text,
                                chooseDay.toString(),
                                locationController.text,
                                chooseCurriculum.toString(),
                                subjectController.text,
                                auth.currentUser!.email.toString(),
                                FieldValue.serverTimestamp(),
                                chooseStudent.toString(),
                                _timeOfDay.format(context).toString(),
                              );
                            }
                          },
                          text: txtPost,
                          color: Colors.grey.shade600)
                    ],
                  ),
                ),
              ),
            )),
      ),
      /*floatingActionButton: FloatingActionButton(onPressed: (){
        CrudDb().readPost();
      }),*/
      /*floatingActionButton: FloatingActionButton(onPressed: () {
        FirebaseFirestore.instance.collection("draft").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snap){
          if(!snap.exists){

            // if(snap.data()!["name"]==null){
            //   print("name = null");
            // }
            // if(snap.data()!["name"]!=null){
            //   print("name = not null");
            // }
          }
        });
        // Get.to(() => TeacherHome());
      }),*/
    );
  }
}
