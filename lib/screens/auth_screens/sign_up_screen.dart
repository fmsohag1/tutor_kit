import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/bloc/firebase_auth_services.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_home.dart';

import '../home_screen/guardian/guardian_home.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 20,),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email"
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5,),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password"
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    User? user = await _firebaseAuthServices.signUpWithEmailAndPassword(emailController.text, passwordController.text);
                    if(user != null){
                      if(box.read('user')=='gd'){
                        Get.to(()=>GuardianHome());
                      }else{
                        Get.to(()=>TeacherHome());
                      }
                      // print(user.uid);
                      // print(user.phoneNumber);
                      // box.write("userPhone", user.phoneNumber);


                      //Managing UserInfo
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
                      print("User created");
                      // Get.to(()=>TeacherHome());
                    }
                }
                },
                child: const Text('Sign Up'),
              ),
              TextButton(onPressed: (){
                Get.off(()=>LoginScreen());
              }, child: Text("Log In"))
            ],
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        print(FirebaseAuth.instance.currentUser!.email);
      }),
    );
  }
}
