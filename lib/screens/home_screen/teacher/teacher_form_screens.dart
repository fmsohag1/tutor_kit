import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor2,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: AnimationLimiter(
                    child: Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: Duration(milliseconds: 200),
                          childAnimationBuilder: (widget)=>SlideAnimation(
                            verticalOffset: 50,
                              child: FadeInAnimation(child: widget)),
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
                                if (value == null) {
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
                                      color: bgColor2),
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
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            DropdownButtonFormField<int?>(
                              style: TextStyle(color: Colors.black),
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              borderRadius: BorderRadius.circular(10),
                              decoration: InputDecoration(
                                  hintText: "Select Division",
                                  hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),
                                  prefixIcon: CircleAvatar(child: SvgPicture.asset(icDivision),backgroundColor: Colors.transparent,),
                                  border: InputBorder.none,
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.black12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.black12),
                                  )
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please choose your Division!';
                                }
                                return null;
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            SizedBox(height: 10,),
                            DropdownButtonFormField<int?>(
                              style: TextStyle(color: Colors.black),
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              borderRadius: BorderRadius.circular(10),
                              decoration: InputDecoration(
                                  hintText: "Select District",
                                  hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),
                                  prefixIcon: CircleAvatar(child: SvgPicture.asset(icDistrict),backgroundColor: Colors.transparent,),
                                  border: InputBorder.none,
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.black12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.black12),
                                  )
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please choose your District!';
                                }
                                return null;
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            SizedBox(height: 10,),
                            DropdownButtonFormField<int?>(
                              style: TextStyle(color: Colors.black),
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              borderRadius: BorderRadius.circular(10),
                              decoration: InputDecoration(
                                  hintText: "Select Upazila",
                                  hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),
                                  prefixIcon: CircleAvatar(child: SvgPicture.asset(icUpazila),backgroundColor: Colors.transparent,),
                                  border: InputBorder.none,
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.black12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.black12),
                                  )
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please choose your Upazila!';
                                }
                                return null;
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            SizedBox(height: 10,),
                            DropdownButtonFormField<int?>(
                              style: TextStyle(color: Colors.black),
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              borderRadius: BorderRadius.circular(10),
                              decoration: InputDecoration(
                                  hintText: "Select Union",
                                  hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),
                                  prefixIcon: CircleAvatar(child: SvgPicture.asset(icUnion),backgroundColor: Colors.transparent,),
                                  border: InputBorder.none,
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.black12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.black12),
                                  )
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please choose your Union!';
                                }
                                return null;
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              height: 5,
                            ),
                            CustomTextField(
                              preffixIcon: CircleAvatar(child: SvgPicture.asset(icLocation,),backgroundColor: Colors.transparent,),
                              type: TextInputType.text,
                              controller: addressController,
                              hint: "Street Address",
                              label: "Street Address",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your street address!';
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
                                        getSelectedDivisionName()!,
                                        getSelectedDistrictName()!,
                                        getSelectedUpazilaName()!,
                                        getSelectedUnionName()!,
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
                      )
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
