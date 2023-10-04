import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/screens/auth_screens/sign_up_screen.dart';

import '../../bloc/firebase_auth_services.dart';
import '../home_screen/guardian/guardian_home.dart';
import '../home_screen/teacher/teacher_home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  get firebaseAuthServices => null;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  final FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Log In",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
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
                        User? user = await _firebaseAuthServices.signInWithEmailAndPassword(emailController.text, passwordController.text);
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
                          print("User exists");
                          // Get.to(()=>TeacherHome());
                        }
                      }
                    },
                    child: const Text('Log In'),
                  ),
                  TextButton(onPressed: (){
                    Get.off(()=>SignUpScreen());
                  }, child: Text("Sign Up")),
                  ElevatedButton(onPressed: ()async{
                    UserCredential? credential = await _firebaseAuthServices.signInWithGoogle();
                    if(credential.user != null){
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
                    }
                  }, child: Text("Sign In with Google"))
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        print(FirebaseAuth.instance.currentUser);
      }),
    );
  }
}
