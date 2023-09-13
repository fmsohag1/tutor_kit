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

class UpdatePostScreen extends StatelessWidget {
  UpdatePostScreen({super.key});
  var docId = Get.arguments[0];

  final TextEditingController genderController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController dayPerWeekController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController curriculumController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();


  List genderList=["Male","Female"];
  List dayList=['1','2','3','4','5','6','7'];
  List curriculumList=["Bangla","English"];



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
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton(onPress: (){
                            CrudDb().updatePost(genderController.text, classController.text, salaryController.text, dayPerWeekController.text, locationController.text, curriculumController.text, subjectController.text, docId);
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
