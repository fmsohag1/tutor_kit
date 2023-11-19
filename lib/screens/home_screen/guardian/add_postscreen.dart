import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class Division {
  int id;
  String name;

  Division({required this.id, required this.name});
}

class District {
  int id;
  int parentId;
  String name;

  District({required this.id, required this.parentId, required this.name});
}

class Upazila {
  int id;
  int parentId;
  String name;

  Upazila({required this.id, required this.parentId, required this.name});
}

class Union {
  int id;
  int parentId;
  String name;

  Union({required this.id, required this.parentId, required this.name});
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
  String? getSelectedDivisionName() {
    if (selectedDivisionId != null) {
      return divisions.firstWhere((division) => division.id == selectedDivisionId).name;
    }
    return null;
  }

  String? getSelectedDistrictName() {
    if (selectedDistrictId != null) {
      return filteredDistricts.firstWhere((district) => district.id == selectedDistrictId).name;
    }
    return null;
  }

  String? getSelectedUpazilaName() {
    if (selectedUpazilaId != null) {
      return filteredUpazilas.firstWhere((upazila) => upazila.id == selectedUpazilaId).name;
    }
    return null;
  }

  String? getSelectedUnionName() {
    if (selectedUnionId != null) {
      return filteredUnions.firstWhere((union) => union.id == selectedUnionId).name;
    }
    return null;
  }

  List<Division> divisions = [];
  List<District> districts = [];
  List<Upazila> upazilas = [];
  List<Union> unions = [];

  List<District> filteredDistricts = [];
  List<Upazila> filteredUpazilas = [];
  List<Union> filteredUnions = [];

  int? selectedDivisionId;
  int? selectedDistrictId;
  int? selectedUpazilaId;
  int? selectedUnionId;

  @override
  void initState() {
    super.initState();
    // Load data from local JSON files
    loadData();
  }

  Future<void> loadData() async {
    final divisionData = await rootBundle.loadString('assets/bd_info/divisions.json');
    final districtData = await rootBundle.loadString('assets/bd_info/districts.json');
    final upazilaData = await rootBundle.loadString('assets/bd_info/upazilas.json');
    final unionData = await rootBundle.loadString('assets/bd_info/unions.json');

    final List<dynamic> divisionList = json.decode(divisionData);
    final List<dynamic> districtList = json.decode(districtData);
    final List<dynamic> upazilaList = json.decode(upazilaData);
    final List<dynamic> unionList = json.decode(unionData);

    divisions = divisionList.map((item) => Division(id: int.parse(item['id']), name: item['name'])).toList();
    districts = districtList.map((item) => District(id: int.parse(item['id']), parentId: int.parse(item['division_id']), name: item['name'])).toList();
    upazilas = upazilaList.map((item) => Upazila(id: int.parse(item['id']), parentId: int.parse(item['district_id']), name: item['name'])).toList();
    unions = unionList.map((item) => Union(id: int.parse(item['id']), parentId: int.parse(item['upazilla_id']), name: item['name'])).toList();

    // Set the initial values to null
    selectedDivisionId = null;
    selectedDistrictId = null;
    selectedUpazilaId = null;
    selectedUnionId = null;

    setState(() {});
  }
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
                      DropdownButtonFormField<int?>(
                        decoration: InputDecoration(
                            hintText: "Select Division"
                        ),
                        value: selectedDivisionId,
                        items: divisions.map((division) {
                          return DropdownMenuItem<int?>(
                            value: division.id,
                            child: Text(division.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDivisionId = value;
                            filteredDistricts = districts.where((district) => district.parentId == value).toList();
                            selectedDistrictId = null;
                            filteredUpazilas = [];
                            selectedUpazilaId = null;
                            filteredUnions = [];
                            selectedUnionId = null;
                          });
                        },
                      ),
                      DropdownButtonFormField<int?>(
                        decoration: InputDecoration(
                            hintText: "Select District"
                        ),
                        value: selectedDistrictId,
                        items: filteredDistricts.map((district) {
                          return DropdownMenuItem<int?>(
                            value: district.id,
                            child: Text(district.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDistrictId = value;
                            filteredUpazilas = upazilas.where((upazila) => upazila.parentId == value).toList();
                            selectedUpazilaId = null;
                            filteredUnions = [];
                            selectedUnionId = null;
                          });
                        },
                      ),
                      DropdownButtonFormField<int?>(
                        decoration: InputDecoration(
                            hintText: "Select Upazila"
                        ),
                        value: selectedUpazilaId,
                        items: filteredUpazilas.map((upazila) {
                          return DropdownMenuItem<int?>(
                            value: upazila.id,
                            child: Text(upazila.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedUpazilaId = value;
                            filteredUnions = unions.where((union) => union.parentId == value).toList();
                            selectedUnionId = null;
                          });
                        },
                      ),
                      DropdownButtonFormField<int?>(
                        decoration: InputDecoration(
                            hintText: "Select Union"
                        ),
                        value: selectedUnionId,
                        items: filteredUnions.map((union) {
                          return DropdownMenuItem<int?>(
                            value: union.id,
                            child: Text(union.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedUnionId = value;
                          });
                        },
                      ),
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
