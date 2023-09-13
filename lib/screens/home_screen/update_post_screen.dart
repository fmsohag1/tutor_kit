import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bloc/crud_db.dart';
import '../../const/colors.dart';
import '../../const/images.dart';
import '../../const/strings.dart';
import '../../const/styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/dropdownbutton.dart';

class UpdatePostScreen extends StatefulWidget {
  UpdatePostScreen({super.key});
  @override
  State<UpdatePostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<UpdatePostScreen> {
  var docId = Get.arguments[0];

  final TextEditingController genderController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController dayPerWeekController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController curriculumController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  String? chooseStudent;
  List studentList=['1','2','3','4','5'];
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
      body: Center(
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
                          CustomTextField(preffixIcon: Image.asset(icGender25), type: TextInputType.text, controller: genderController..text = "${data["gender"]}", hint: "Gender"),
                          SizedBox(height: 5,),
                          CustomDropDownButton(hint: 'No of Students', prefixIcon: Image.asset(icStudent25), value: chooseStudent, list: studentList,onChange: (newValue){
                            chooseStudent=newValue as String;
                          },),
                          SizedBox(height: 5,),
                          CustomTextField(preffixIcon: Image.asset(icClass25), type: TextInputType.text, controller: classController..text = "${data["class"]}", hint: "Class"),
                          SizedBox(height: 5,),
                          CustomTextField(preffixIcon: Image.asset(icSalary25), type: TextInputType.text, controller: salaryController..text = "${data["salary"]}", hint: "Salary"),
                          SizedBox(height: 5,),
                          CustomTextField(preffixIcon: Image.asset(icDay25), type: TextInputType.text, controller: dayPerWeekController..text = "${data["dayPerWeek"]}", hint: "Day/Week"),
                          SizedBox(height: 5,),
                          CustomTextField(preffixIcon: Image.asset(icLocation25), type: TextInputType.text, controller: locationController..text = "${data["location"]}", hint: "Location"),
                          SizedBox(height: 5,),
                          CustomTextField(preffixIcon: Image.asset(icCurriculum25), type: TextInputType.text, controller: curriculumController..text = "${data["curriculum"]}", hint: "Curriculum"),
                          SizedBox(height: 5,),
                          CustomTextField(preffixIcon: Image.asset(icSubjects25), type: TextInputType.text, controller: subjectController..text = "${data["subjects"]}", hint: "Subjects"),
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
                            CrudDb().updatePost(genderController.text,chooseStudent.toString(), classController.text, salaryController.text, dayPerWeekController.text, locationController.text, curriculumController.text, subjectController.text,_timeOfDay.toString(), docId);
                            // );
                          }, text: Text("Update",style: TextStyle(fontFamily: kalpurush,color: buttonColor,fontSize: 18,letterSpacing: 1),), color: Colors.white)
                        ],
                      ),
                    ),
                  );
                }
                return CircularProgressIndicator();
              })
      ),
    );
  }
}
