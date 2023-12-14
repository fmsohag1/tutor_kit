import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_home.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:tutor_kit/widgets/custom_textfield.dart';
import 'package:tutor_kit/widgets/dropdownbutton.dart';

class GuardianFormScreen extends StatefulWidget {
  GuardianFormScreen({super.key});

  @override
  State<GuardianFormScreen> createState() => _GuardianFormScreenState();
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

class _GuardianFormScreenState extends State<GuardianFormScreen> {
  final box = GetStorage();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      height: 15,
                    ),
                    CustomTextField(
                      preffixIcon: CircleAvatar(child: SvgPicture.asset(icName,),backgroundColor: Colors.transparent,),
                      type: TextInputType.text,
                      controller: nameController,
                      hint: "Enter your full name",
                      label: "Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name!';
                        }
                        return null;
                      },
                      autoValidate: AutovalidateMode.onUserInteraction,
                      autofillHints: [AutofillHints.name],
                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      preffixIcon: CircleAvatar(child: SvgPicture.asset(icPhone,),backgroundColor: Colors.transparent,),

                      type: TextInputType.number,
                      controller: mobileController,
                      hint: "Enter your phone number",
                      label: "Mobile No.",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      autoValidate: AutovalidateMode.onUserInteraction,
                      autofillHints: [AutofillHints.telephoneNumberNational],
                    ),
                    SizedBox(height: 10,),
                    DropdownButtonFormField<int?>(
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(
                          hintText: "Select Division",
                          hintStyle: TextStyle(fontFamily: roboto_regular,color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w400),
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
                     isExpanded: true,
                     icon: Icon(Icons.keyboard_arrow_down_outlined),
                     borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(
                          hintText: "Select District",
                          hintStyle: TextStyle(fontFamily: roboto_regular,color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w400),
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
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(
                          hintText: "Select Upazila",
                          hintStyle: TextStyle(fontFamily: roboto_regular,color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w400),
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
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(
                          hintText: "Select Union",
                          hintStyle: TextStyle(fontFamily: roboto_regular,color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w400),
                          prefixIcon: CircleAvatar(child: SvgPicture.asset(icUnion,),backgroundColor: Colors.transparent,),
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
                    SizedBox(height: 10,),
                    CustomTextField(
                      preffixIcon: CircleAvatar(child: SvgPicture.asset(icLocation,),backgroundColor: Colors.transparent,),

                      type: TextInputType.text,
                      controller: addressController,
                      hint: "Enter your street address",
                      label: "Street Address",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your street address';
                        }
                        return null;
                      },
                      autoValidate: AutovalidateMode.onUserInteraction,
                      autofillHints: [AutofillHints.postalAddressExtendedPostalCode],
                    ),
                    SizedBox(height: 15,),
                    CustomButton(onPress: (){
                      if (_formKey.currentState!.validate()) {
                        var _auth = FirebaseAuth.instance;
                        FirebaseFirestore.instance
                            .collection("userInfo")
                            .doc(_auth.currentUser!.uid)
                            .update({
                          "mobile": mobileController.text.trim(),
                          "timestamp": FieldValue.serverTimestamp(),
                          "address": addressController.text.trim(),
                          "name": nameController.text.trim(),
                          "division": getSelectedDivisionName(),
                          "district": getSelectedDistrictName(),
                          "upazila": getSelectedUpazilaName(),
                          "union": getSelectedUnionName(),
                        });
                        Get.off(() => GuardianHome(currentNavIndex: 0.obs,));
                        box.write("user", "gd");
                      }
                    }, text: "Submit", color: Colors.grey.shade600)
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
