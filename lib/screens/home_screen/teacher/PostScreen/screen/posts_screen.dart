import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tutor_kit/screens/home_screen/teacher/post_details_screen.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_form_screens.dart';
import '../../../../../const/consts.dart';
import '../../../../../const/colors.dart';
import '../widget/postdata.dart';

class PostsScreen extends StatefulWidget {
  PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}
final box = GetStorage();
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

class _PostsScreenState extends State<PostsScreen> {
  var location = "bangladesh".obs;


  // String? getSelectedDivisionName() {
  //   if (selectedDivisionId != null) {
  //     return divisions.firstWhere((division) => division.id == selectedDivisionId).name;
  //   }
  //   return null;
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
    _loadCityFromPreferences();
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

  _loadCityFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      location.value = prefs.getString('city') ?? "Bangladesh";
    });
  }

  _saveCityToPreferences(String newCity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('city', newCity);
  }

  _deleteCityToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('city');
  }



  @override
  Widget build(BuildContext context) {
    final postsRefNotSelected = FirebaseFirestore.instance.collection("posts").orderBy("timestamp",descending: true);
    final postsRef = FirebaseFirestore.instance.collection("posts").where("upazila",isEqualTo: location.value).orderBy("timestamp",descending: true);

    // String location = box.read("location");

    final userPhoneNumber = box.read("userPhone");
    bool isThreeFilled = false;
    return  Scaffold(
      backgroundColor: bgColor2,
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                showModalBottomSheet(context: context, builder: (context){
                  return StatefulBuilder(builder: (context,setState){
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                        color: bgColor2
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Container(
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: primary
                              ),
                            ),
                            SizedBox(height: 15,),
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
                                  isThreeFilled = true;

                                });
                              },
                            ),
                            SizedBox(height: 10,),
                            // DropdownButtonFormField<int?>(
                            //   isExpanded: true,
                            //   icon: Icon(Icons.keyboard_arrow_down_outlined),
                            //   borderRadius: BorderRadius.circular(10),
                            //   decoration: InputDecoration(
                            //       hintText: "Select Union",
                            //       hintStyle: TextStyle(fontFamily: roboto_regular,color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w400),
                            //       prefixIcon: CircleAvatar(child: SvgPicture.asset(icUnion),backgroundColor: Colors.transparent,),
                            //       border: InputBorder.none,
                            //       focusedErrorBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //         borderSide: BorderSide(color: Colors.red),
                            //       ),
                            //       errorBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //         borderSide: BorderSide(color: Colors.red),
                            //       ),
                            //       enabledBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //         borderSide: BorderSide(color: Colors.black12),
                            //       ),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //         borderSide: BorderSide(color: Colors.black12),
                            //       )
                            //   ),
                            //   validator: (value) {
                            //     if (value == null) {
                            //       return 'Please choose your Union!';
                            //     }
                            //     return null;
                            //   },
                            //   autovalidateMode: AutovalidateMode.onUserInteraction,
                            //   value: selectedUnionId,
                            //   items: filteredUnions.map((union) {
                            //     return DropdownMenuItem<int?>(
                            //       value: union.id,
                            //       child: Text(union.name),
                            //     );
                            //   }).toList(),
                            //   onChanged: (value) {
                            //     setState(() {
                            //       selectedUnionId = value;
                            //     });
                            //   },
                            // ),
                            SizedBox(
                              width: 120,
                              child: isThreeFilled == false ? ElevatedButton(onPressed: (){}, child: Text("Change",style: TextStyle(color: Colors.white),),style: ButtonStyle(elevation: MaterialStatePropertyAll(0),backgroundColor: MaterialStatePropertyAll(primary),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),) : ElevatedButton(onPressed: (){
                                // box.write("location", getSelectedUpazilaName()!);
                                Get.back();
                                // location.value = getSelectedUpazilaName()!;
                                isThreeFilled = true;
                                String newCity = getSelectedUpazilaName()!;
                                _saveCityToPreferences(newCity);
                                _loadCityFromPreferences();

                              }, child: Text("Change",style: TextStyle(color: Colors.white),),style: ButtonStyle(elevation: MaterialStatePropertyAll(0),backgroundColor: MaterialStatePropertyAll(Colors.grey.shade600),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))))),
                            ),
                            TextButton(onPressed: (){
                              Get.back();
                              _deleteCityToPreferences();
                              _loadCityFromPreferences();
                            }, child: Text("All Bangladesh",style: TextStyle(color: Colors.black),),style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),side: MaterialStatePropertyAll(BorderSide(color: Colors.grey.shade300,width: 2))),)
                          ],
                        ),
                      ),
                    );
                  });
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 150,left: 18,top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey.shade300,width: 2),
                    color: bgColor2
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,top: 8,bottom: 8,right: 5),
                    child: Row(
                      children: [
                        SvgPicture.asset(icLocation,width: 20,),
                        SizedBox(width: 5,),
                        Container(child: Obx(() => Text(location.value.toString(),style: TextStyle(color: Colors.black),))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              child: StreamBuilder(
                  stream: location.value=="Bangladesh"?postsRefNotSelected.snapshots():postsRef.snapshots(),
                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.hasError){
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if(!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator(color: Colors.black12,strokeAlign: -1,),);
                }
                if(snapshot.data!.docs.length==0){
                  return const Center(child: Text("No posts available"),);
                }
                // final data = snapshot.requireData;
                return AnimationLimiter(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                      Timestamp timestamp = snapshot.data!.docs[index]["timestamp"];
                      var data = snapshot.data!.docs[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: Duration(milliseconds: 100),
                      child: SlideAnimation(
                        duration: Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                          duration: Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                            child: GestureDetector(
                              onTap: (){
                                FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snap){
                                  if(snap.data()!["name"]==null){
                                    Get.to(()=>TeacherFormScreen());
                                  } else {
                                    Get.to(()=>PostDetailesScreen(),arguments: snapshot.data!.docs[index].id);
                                  }
                                  // if(snap.data()!["name"]!=null){
                                  //   Get.to(()=>TeacherHome());
                                  // }
                                });
                              },
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.black12)
                                ),
                                color: bgColor2,
                                child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        PostData(
                                          icon: SvgPicture.asset(icGender),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.410,
                                          title: "Gender",
                                          subtitle: "${snapshot.data!.docs[index]["gender"]}",
                                        ),
                                        PostData(
                                          icon: SvgPicture.asset(icClass),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.410,
                                          title: "Class",
                                          subtitle: "${snapshot.data!.docs[index]["class"]}",
                                        ),

                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    PostData(
                                      icon: SvgPicture.asset(icSubjects),
                                      width: double.infinity,
                                      title: "Subjects",
                                      subtitle: "${snapshot.data!.docs[index]["subjects"]}",
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        PostData(
                                          icon: SvgPicture.asset(icDay),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.410,
                                          title: "Day/Week",
                                          subtitle: "${snapshot.data!.docs[index]["dayPerWeek"]}",
                                        ),
                                        PostData(
                                          icon: SvgPicture.asset(icSalary,width: 17,),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.410,
                                          title: "Salary",
                                          subtitle: "${snapshot.data!.docs[index]["salary"]} BDT",
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    PostData(
                                      icon: SvgPicture.asset(icLocation),
                                      width: double.infinity,
                                      title: "Location",
                                      subtitle: "${data["union"]}, ${data["upazila"]}, ${data["district"]}",
                                      maxline: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        PostData(
                                          icon: SvgPicture.asset(icStudent),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.410,
                                          title: "Students",
                                          subtitle: "${snapshot.data!.docs[index]["student"]}",
                                        ),
                                        PostData(
                                          icon: SvgPicture.asset(icTime),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.410,
                                          title: "Time",
                                          subtitle: "${snapshot.data!.docs[index]["time"]}",
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     PostData(
                                       icon: SvgPicture.asset(icCurriculum),
                                       width: MediaQuery.of(context)
                                           .size
                                           .width *
                                           0.410,
                                       title: "Curriculum",
                                       subtitle: "${snapshot.data!.docs[index]["curriculum"]}",
                                     ),

                                        Column(
                                          children: [
                                            Center(child: Text(timeago.format(DateTime.parse(timestamp.toDate().toString())),style: TextStyle(fontFamily: roboto_regular,color: Colors.blueGrey),)),
                                            SizedBox(height: 5,),
                                            snapshot.data!.docs[index]["isBooked"] == false ? Container(decoration: BoxDecoration(color: Colors.green.shade100,borderRadius: BorderRadius.circular(5)),child: Padding(
                                              padding: const EdgeInsets.only(left: 8,right: 8),
                                              child: Text("Available",style: TextStyle(color: Colors.green),),
                                            )) : Container(decoration: BoxDecoration(color: Colors.red.shade100,borderRadius: BorderRadius.circular(5)),child: Padding(
                                              padding: const EdgeInsets.only(left: 8,right: 8),
                                              child: Text("Booked",style: TextStyle(color: Colors.red),),
                                            ))

                                          ],
                                        ),
                                      ],
                                    )

                                 /* Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text("Gender : ${snapshot.data!.docs[index]["gender"]}",),
                                          )),
                                      SizedBox(width: 30,),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text("Class : ${snapshot.data!.docs[index]["class"]}"),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Subjects : ${snapshot.data!.docs[index]["subjects"]}"),
                                      )),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text("Day/Week : ${snapshot.data!.docs[index]["dayPerWeek"]}"),
                                          )),
                                      SizedBox(width: 20,),

                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text("Curriculum : ${snapshot.data!.docs[index]["curriculum"]}"),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Location : ${snapshot.data!.docs[index]["location"]}"),
                                      )),
                                  SizedBox(height: 10,),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text("Salary : ${snapshot.data!.docs[index]["salary"]}"),
                                      )),*/
                                ],
                              ),
                            ),),
                          )),
                        ),
                      ),
                    );
                  }),
                );

              }),
            ),
          ],
        ),
      ),
    );
  }
}
