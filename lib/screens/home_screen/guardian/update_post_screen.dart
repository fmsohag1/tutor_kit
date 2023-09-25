import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/widgets/dropdownbutton.dart';

import '../../../bloc/crud_db.dart';
import '../../../const/colors.dart';
import '../../../const/images.dart';
import '../../../const/strings.dart';
import '../../../const/styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';

class UpdatePostScreen extends StatefulWidget {
  UpdatePostScreen({super.key});

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  var docId = Get.arguments[0];

  final TextEditingController genderController = TextEditingController();

  final TextEditingController classController = TextEditingController();

  final TextEditingController salaryController = TextEditingController();

  final TextEditingController dayPerWeekController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController curriculumController = TextEditingController();

  final TextEditingController subjectController = TextEditingController();

  String? chooseGender;

  String? chooseDay;
  String? chooseStudent;
  String? chooseCurriculum;

  List genderList=["Male","Female","Both"];

  List dayList=['1 Days','2 Days','3 Days','4 Days','5 Days','6 Days','7 Days'];
  List studentList=['1','2','3','4','5'];

  List curriculumList=["Bangla","English",'Madrasha'];

  bool isTime=false;

  TimeOfDay _timeOfDay=TimeOfDay(hour: 8,minute: 30);

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

  @override
  Widget build(BuildContext context) {
    CollectionReference posts = FirebaseFirestore.instance.collection("posts");
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: FutureBuilder<DocumentSnapshot>(future: posts.doc(docId).get(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                  if(snapshot.hasError){
                    return Text("Something went wrong");
                  }
                  if(snapshot.hasData && !snapshot.data!.exists){
                    return Text("Document does not exist");
                  }
                  if(snapshot.connectionState == ConnectionState.done){
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text("Update Post",style: TextStyle(fontFamily: roboto_medium,fontSize: 22,letterSpacing: 1),),
                              ],
                            ),
                            SizedBox(height: 20,),
                            CustomDropDownButton(hint: "Gender", prefixIcon: Image.asset(icGender25), value: chooseGender="${data["gender"]}", list: genderList,onChange: (newValue){
                                chooseGender=newValue as String;
                            },),
                            SizedBox(height: 5,),
                            CustomDropDownButton(hint: 'No of Students', prefixIcon: Image.asset(icStudent25), value: chooseStudent="${data["student"]}", list: studentList,onChange: (newValue){
                              chooseStudent=newValue as String;
                            },),
                            //CustomTextField(preffixIcon: Image.asset(icGender25), type: TextInputType.text, controller: genderController..text = "${data["gender"]}", hint: "Gender"),
                            SizedBox(height: 5,),
                            CustomTextField(label: "Class",preffixIcon: Image.asset(icClass25), type: TextInputType.text, controller: classController..text = "${data["class"]}", hint: "Class"),
                            SizedBox(height: 5,),
                            CustomTextField(label: "Salary",preffixIcon: Image.asset(icSalary25), type: TextInputType.text, controller: salaryController..text = "${data["salary"]}", hint: "Salary"),
                            SizedBox(height: 5,),
                            CustomDropDownButton(hint: "Day/Week", prefixIcon: Image.asset(icDay25), value: chooseDay="${data["dayPerWeek"]}", list: dayList,onChange: (newValue){
                              chooseDay=newValue as String;
                            },),
                            //CustomTextField(preffixIcon: Image.asset(icDay25), type: TextInputType.text, controller: dayPerWeekController..text = "${data["dayPerWeek"]}", hint: "Day/Week"),
                            SizedBox(height: 5,),
                            CustomTextField(label: "Location",preffixIcon: Image.asset(icLocation25), type: TextInputType.text, controller: locationController..text = "${data["location"]}", hint: "Location"),
                            SizedBox(height: 5,),
                            CustomDropDownButton(hint: "Curriculum", prefixIcon: Image.asset(icCurriculum25), value: chooseCurriculum="${data["curriculum"]}", list: curriculumList,onChange: (newValue){
                              chooseCurriculum=newValue as String;
                            },),

                            //CustomTextField(preffixIcon: Image.asset(icCurriculum25), type: TextInputType.text, controller: curriculumController..text = "${data["curriculum"]}", hint: "Curriculum"),
                            SizedBox(height: 5,),
                            CustomTextField(label: "Subjects",preffixIcon: Image.asset(icSubjects25), type: TextInputType.text, controller: subjectController..text = "${data["subjects"]}", hint: "Subjects"),
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
                                      isTime?Text(_timeOfDay.format(context).toString(),style: TextStyle(fontSize: 17),):Text("${data['time']}",style: TextStyle(fontFamily: roboto_regular,fontSize: 17),),

                                    ],
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(onPress: (){
                              CrudDb().updatePost(
                                  chooseGender.toString(),
                                  classController.text,
                                  salaryController.text,
                                  chooseDay.toString(),
                                  locationController.text,
                                  chooseCurriculum.toString(),
                                  subjectController.text,
                                  chooseStudent.toString(),
                                  _timeOfDay.format(context).toString(),
                                  docId);
                              // );
                            }, text: Text("Update",style: TextStyle(color: buttonColor,fontSize: 18,letterSpacing: 1),), color: Colors.white),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                })
        ),
      ),
    );
  }
}
