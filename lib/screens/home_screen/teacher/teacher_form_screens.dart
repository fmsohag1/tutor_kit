import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/bloc/crud_db.dart';

import '../../../const/consts.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/dropdownbutton.dart';

class TeacherFormScreen extends StatefulWidget {
  const TeacherFormScreen({super.key});

  @override
  State<TeacherFormScreen> createState() => _TeacherFormScreenState();
}

class _TeacherFormScreenState extends State<TeacherFormScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController classController=TextEditingController();
  TextEditingController subjectController=TextEditingController();
  TextEditingController qualifyController=TextEditingController();
  TextEditingController instituteController=TextEditingController();
  TextEditingController departmentController=TextEditingController();

  String? chooseGender;
  List genderList=["Male","Female"];

  bool isDate = false;

  DateTime _dateTime=DateTime.now();

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
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Create a Profile",
                        style: TextStyle(
                            fontSize: 22,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  CustomTextField(preffixIcon: Image.asset(icName25), type: TextInputType.text, controller: nameController, hint: "Enter your name",label: "Name",),
                  SizedBox(height: 5,),
                  CustomDropDownButton(hint: "Gender", prefixIcon: Image.asset(icGender25), value: chooseGender, list: genderList,onChange: (newValue){
                    chooseGender=newValue as String?;
                  }
                  ),
                  SizedBox(height: 5,),
                  GestureDetector(
                    onTap: _showDatePicker,
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.085,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(icTime,width: 25,),
                            SizedBox(
                              width: 12,
                            ),
                            isDate
                                ? Text(
                              "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}",
                              style: TextStyle(fontSize: 17,fontFamily: roboto_regular),
                            )
                                : Text(
                              "Date of Birth",
                              style: TextStyle(
                                  fontFamily: roboto_regular,
                                  fontSize: 17,
                                  color: Colors.grey),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: 5,),
                  CustomTextField(preffixIcon: Image.asset(icLocation25), type: TextInputType.text, controller: addressController, hint: "Address",label: "Address",),
                  SizedBox(height: 5,),
                  CustomTextField(preffixIcon: Image.asset(icClass25), type: TextInputType.text, controller: classController, hint: "Preferable class",label: "Preferable class",),
                  SizedBox(height: 5,),
                  CustomTextField(preffixIcon: Image.asset(icSubjects25), type: TextInputType.text, controller: subjectController, hint: "Tuition Subjects",label: "Tuition Subjects",),
                  SizedBox(height: 5,),
                  CustomTextField(preffixIcon: Image.asset(icQualification25), type: TextInputType.text, controller: qualifyController, hint: "Qualification",label: "Qualification",),
                  SizedBox(height: 5,),
                  CustomTextField(preffixIcon: Image.asset(icInstitute25), type: TextInputType.text, controller: instituteController, hint: "Institute",label: "Institute",),
                  SizedBox(height: 5,),
                  CustomTextField(preffixIcon: Image.asset(icDepartment25), type: TextInputType.text, controller: departmentController, hint: "Section/Department",label: "Section/Department",),
                  SizedBox(height: 20,),
                  CustomButton(onPress: (){
                    CrudDb().addTeacherInfo(nameController.text, chooseGender.toString(), _dateTime.year.toString(), addressController.text, classController.text, subjectController.text, qualifyController.text, instituteController.text, departmentController.text, "tt");
                    Get.back();
                  }, text: "Submit", color: Colors.grey.shade600),
                  SizedBox(height: 10,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
