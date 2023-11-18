import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tutor_kit/bloc/crud_db.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_home.dart';

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

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController qualifyController = TextEditingController();
  TextEditingController instituteController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  String? chooseGender;
  List genderList = ["Male", "Female"];

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
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Create a Profile",
                          style: TextStyle(fontSize: 22, letterSpacing: 1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15
                    ),
                    CustomTextField(
                      preffixIcon: CircleAvatar(child: SvgPicture.asset(icName,),backgroundColor: Colors.transparent,),
                      type: TextInputType.text,
                      controller: nameController,
                      hint: "Enter your name",
                      label: "Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name!';
                        }
                        return null;
                      },
                      autoValidate: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      preffixIcon: CircleAvatar(child: SvgPicture.asset(icPhone,),backgroundColor: Colors.transparent,),
                      type: TextInputType.phone,
                      controller: numberController,
                      hint: "Enter your number",
                      label: "Mobile",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your number!';
                        }
                        return null;
                      },
                      autoValidate: AutovalidateMode.onUserInteraction,
                      autofillHints: [AutofillHints.telephoneNumberNational],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomDropDownButton(
                      hint: "Gender",
                      prefixIcon: CircleAvatar(child: SvgPicture.asset(icGender),backgroundColor: Colors.transparent,),
                      value: chooseGender,
                      list: genderList,
                      onChange: (newValue) {
                        chooseGender = newValue as String?;
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
                    GestureDetector(
                      onTap: _showDatePicker,
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.085,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black12),
                              color: secondary),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(icTime,),
                              SizedBox(
                                width: 12,
                              ),
                              isDate
                                  ? Text(
                                "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: roboto_regular),
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
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      preffixIcon: CircleAvatar(child: SvgPicture.asset(icLocation,),backgroundColor: Colors.transparent,),
                      type: TextInputType.text,
                      controller: addressController,
                      hint: "Address",
                      label: "Address",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address!';
                        }
                        return null;
                      },
                      autoValidate: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      preffixIcon: CircleAvatar(child: SvgPicture.asset(icClass,),backgroundColor: Colors.transparent,),
                      type: TextInputType.text,
                      controller: classController,
                      hint: "Preferable class",
                      label: "Preferable class",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Preferable class!';
                        }
                        return null;
                      },
                      autoValidate: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      preffixIcon: CircleAvatar(child: SvgPicture.asset(icSubjects,),backgroundColor: Colors.transparent,),
                      type: TextInputType.text,
                      controller: subjectController,
                      hint: "Tuition Subjects",
                      label: "Tuition Subjects",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Tuition Subjects!';
                        }
                        return null;
                      },
                      autoValidate: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      preffixIcon: CircleAvatar(child: SvgPicture.asset(icQualification,),backgroundColor: Colors.transparent,),
                      type: TextInputType.text,
                      controller: qualifyController,
                      hint: "Qualification",
                      label: "Qualification",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Qualification!';
                        }
                        return null;
                      },
                      autoValidate: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      preffixIcon: CircleAvatar(child: SvgPicture.asset(icInstitute,),backgroundColor: Colors.transparent,),
                      type: TextInputType.text,
                      controller: instituteController,
                      hint: "Institute",
                      label: "Institute",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your institute!';
                        }
                        return null;
                      },
                      autoValidate: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      preffixIcon: CircleAvatar(child: SvgPicture.asset(icDepartment,width: 25,),backgroundColor: Colors.transparent,),

                      type: TextInputType.text,
                      controller: departmentController,
                      hint: "Section/Department",
                      label: "Section/Department",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Section/Department!';
                        }
                        return null;
                      },
                      autoValidate: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            CrudDb().addTeacherInfo(
                                nameController.text,
                                numberController.text,
                                chooseGender.toString(),
                                _dateTime.year.toString(),
                                addressController.text,
                                classController.text,
                                subjectController.text,
                                qualifyController.text,
                                instituteController.text,
                                departmentController.text,
                                "tt");
                            Get.to(()=>TeacherHome(currentNavIndex: 1.obs,));
                          }
                        },
                        text: "Submit",
                        color: Colors.grey.shade600),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
