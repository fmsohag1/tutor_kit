
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_form_screen.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_home.dart';
import 'package:tutor_kit/widgets/custom_button.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({super.key});

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  final box = GetStorage();
  bool isGuardian = false;
  bool isTutor = false;
  bool isLoading=false;
  // bool? isGuardianSelected;
  @override
  Widget build(BuildContext context) {
    print(box.read("user"));
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(right: 15,left: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(icTutorGrey),height: 100,),
              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text(txtChooseText,style: TextStyle(fontFamily: kalpurush,fontSize: 18,),textAlign: TextAlign.justify,),
              // ),
               const SizedBox(height: 80,),
              CustomButton(onPress: (){
                // print(isGuardian);
                setState(() {
                  isGuardian = true;
                  isTutor = false;
                });
                // Get.to(()=>const GaurdianScreen());
              }, text: txtGaurdian,color: isGuardian ? Colors.green : Colors.black26,),
              const SizedBox(height: 5,),
              CustomButton(onPress: (){
                setState(() {
                  isGuardian = false;
                  isTutor = true;
                });
                // Get.to(()=>const TeacherScreen());
              }, text: txtTeacher,color: isTutor ? Colors.green : Colors.black26,),
              SizedBox(height: 20,),
              SizedBox(
                width: 100,
                child: ElevatedButton(onPressed: (){
                  setState(() async{

                    if(isGuardian || isTutor == true){
                      isLoading=true;
                      // Get.to(()=>LoginScreen(),);
                      if(isGuardian == true){
                        //start
                        String? deviceToken;
                          await FirebaseMessaging.instance.getToken().then((token) {
                            setState(() {
                              deviceToken = token;
                              print('token : $deviceToken');
                            });
                          });
                          FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snap) {
                            if(!snap.exists){
                              FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).set({
                                "email": FirebaseAuth.instance.currentUser!.email,
                                "deviceToken": deviceToken,
                                "timestamp": FieldValue.serverTimestamp(),
                                "role" : "gd"
                              });
                            }
                            if(snap.exists){
                              if(snap.data()!["deviceToken"] != deviceToken){
                                FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                  "deviceToken": deviceToken,
                                  "timestamp": FieldValue.serverTimestamp(),
                                }).then((value) {print("New token detected");});
                              }
                            }
                          });
                          Get.to(()=>GuardianFormScreen());
                          //end
                        // box.write("user", "gd");
                      }
                      if(isTutor == true) {
                        //start
                        String? deviceToken;
                        await FirebaseMessaging.instance.getToken().then((token) {
                          setState(() {
                            deviceToken = token;
                            print('token : $deviceToken');
                          });
                        });
                        FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snap) {
                          if(!snap.exists){
                            FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).set({
                              "email": FirebaseAuth.instance.currentUser!.email,
                              "deviceToken": deviceToken,
                              "timestamp": FieldValue.serverTimestamp(),
                              "role" : "tt"
                            });
                          }
                          if(snap.exists){
                            if(snap.data()!["deviceToken"] != deviceToken){
                              FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                "deviceToken": deviceToken,
                                "timestamp": FieldValue.serverTimestamp(),
                              }).then((value) {print("New token detected");});
                            }
                          }
                        });
                        Get.to(()=>TeacherHome());
                        //end
                        box.write("user", "tt");
                      }
                    }
                    else {
                      Get.snackbar("সতর্কতা", "অভিবাবক অথবা শিক্ষক বাচাই করুন ।",);
                    }

                  });
                }, child: isLoading?CircularProgressIndicator(color: Colors.purpleAccent,):Text("➜",style: TextStyle(fontSize: 22),),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.orange.shade200))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
