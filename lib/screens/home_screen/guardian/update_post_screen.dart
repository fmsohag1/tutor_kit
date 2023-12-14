import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
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
      backgroundColor: bgColor2,
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
                        child: AnimationLimiter(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: AnimationConfiguration.toStaggeredList(
                              duration: Duration(milliseconds: 200),
                                childAnimationBuilder: (widget)=>SlideAnimation(
                                  verticalOffset: 50,
                                    child: FadeInAnimation(child: widget)),
                                children: [
                                  Row(
                                    children: [
                                      Text("Update Post",style: TextStyle(fontFamily: roboto_medium,fontSize: 22,letterSpacing: 1),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  CustomDropDownButton(hint: "Gender", prefixIcon: CircleAvatar(child: SvgPicture.asset(icGender,),backgroundColor: Colors.transparent,),
                                    value: chooseGender="${data["gender"]}", list: genderList,onChange: (newValue){
                                      chooseGender=newValue as String;
                                    },),
                                  SizedBox(height: 5,),
                                  CustomDropDownButton(hint: 'No of Students', prefixIcon: CircleAvatar(child: SvgPicture.asset(icStudent,),backgroundColor: Colors.transparent,),
                                    value: chooseStudent="${data["student"]}", list: studentList,onChange: (newValue){
                                      chooseStudent=newValue as String;
                                    },),
                                  //CustomTextField(preffixIcon: Image.asset(icGender25), type: TextInputType.text, controller: genderController..text = "${data["gender"]}", hint: "Gender"),
                                  SizedBox(height: 5,),
                                  CustomTextField(label: "Class", preffixIcon: CircleAvatar(child: SvgPicture.asset(icClass,),backgroundColor: Colors.transparent,),
                                      type: TextInputType.text, controller: classController..text = "${data["class"]}", hint: "Class"),
                                  SizedBox(height: 5,),
                                  CustomTextField(label: "Salary", preffixIcon: CircleAvatar(child: SvgPicture.asset(icSalary,width: 17,),backgroundColor: Colors.transparent,),
                                      type: TextInputType.text, controller: salaryController..text = "${data["salary"]}", hint: "Salary"),
                                  SizedBox(height: 5,),
                                  CustomDropDownButton(hint: "Day/Week", prefixIcon: CircleAvatar(child: SvgPicture.asset(icDay,),backgroundColor: Colors.transparent,),
                                    value: chooseDay="${data["dayPerWeek"]}", list: dayList,onChange: (newValue){
                                      chooseDay=newValue as String;
                                    },),
                                  //CustomTextField(preffixIcon: Image.asset(icDay25), type: TextInputType.text, controller: dayPerWeekController..text = "${data["dayPerWeek"]}", hint: "Day/Week"),
                                  SizedBox(height: 5,),
                                  CustomTextField(label: "Location", preffixIcon: CircleAvatar(child: SvgPicture.asset(icLocation,),backgroundColor: Colors.transparent,),
                                      type: TextInputType.text, controller: locationController..text = "${data["location"]}", hint: "Location"),
                                  SizedBox(height: 5,),
                                  CustomDropDownButton(hint: "Curriculum",prefixIcon: CircleAvatar(child: SvgPicture.asset(icCurriculum,),backgroundColor: Colors.transparent,),
                                    value: chooseCurriculum="${data["curriculum"]}", list: curriculumList,onChange: (newValue){
                                      chooseCurriculum=newValue as String;
                                    },),

                                  //CustomTextField(preffixIcon: Image.asset(icCurriculum25), type: TextInputType.text, controller: curriculumController..text = "${data["curriculum"]}", hint: "Curriculum"),
                                  SizedBox(height: 5,),
                                  CustomTextField(label: "Subjects",preffixIcon: CircleAvatar(child: SvgPicture.asset(icSubjects,),backgroundColor: Colors.transparent,),
                                      type: TextInputType.text, controller: subjectController..text = "${data["subjects"]}", hint: "Subjects"),
                                  SizedBox(height: 5,),
                                  GestureDetector(
                                    onTap: _showTimePicker,
                                    child: Container(
                                        height: 65,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.black12),
                                            color: bgColor2
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 4,),
                                            CircleAvatar(child: SvgPicture.asset(icTime,),backgroundColor: Colors.transparent,),
                                            SizedBox(width: 2,),
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
                                  }, text: "Update", color: Colors.grey.shade600),
                                  SizedBox(height: 20,),
                                ],
                            )
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator(color: Colors.black12,strokeAlign: -1,));
                })
        ),
      ),
    );
  }
}
