import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/bloc/firebase_auth_services.dart';
import 'package:tutor_kit/screens/home_screen/admin/admin_home.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_home.dart';

import '../../../../const/images.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../home_screen/guardian/guardian_home.dart';
import '../../ChooseScreen/choose_screen.dart';
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
  TextEditingController ConfirmpasswordController = TextEditingController();


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
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icTutor,
                    width: 100,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    preffixIcon: Image.asset(icEmail25),
                    type: TextInputType.emailAddress,
                    controller: emailController,
                    hint: 'Enter your email',
                    label: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    autoValidate: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField2(
                    hint: 'Enter your password',
                    preffixIcon: Image.asset(icPassword25),
                    type: TextInputType.text,
                    controller: passwordController,
                    label: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    autoValidate: AutovalidateMode.onUserInteraction,

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: 'Enter your confirm password',
                    preffixIcon: Image.asset(icConfirm25),
                    type: TextInputType.text,
                    controller: ConfirmpasswordController,
                    label: 'Confirm Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your confirm password';
                      }
                      if(value!=passwordController.text){
                        return 'Password not Match!';
                      }
                      return null;
                    },
                    autoValidate: AutovalidateMode.onUserInteraction,

                  ),
                  SizedBox(height: 20,),
                  CustomButton(onPress:()async{
                    if (_formKey.currentState!.validate()) {
                      User? user = await _firebaseAuthServices.signUpWithEmailAndPassword(emailController.text, passwordController.text);
                      if(user != null){
                        await FirebaseFirestore.instance.collection("admin").where("email",isEqualTo: emailController.text).where("password").get().then((snap){
                          if(snap.docs.isNotEmpty){
                            Get.to(()=>AdminHome());
                            box.write("user", "ad");
                          }else{
                            Get.to(()=>ChooseScreen());
                          }
                        });
                        // if(box.read('user')=='gd'){
                        //   String? deviceToken;
                        //   await FirebaseMessaging.instance.getToken().then((token) {
                        //     setState(() {
                        //       deviceToken = token;
                        //       print('token : $deviceToken');
                        //     });
                        //   });
                        //
                        //   FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snap) {
                        //     if(!snap.exists){
                        //       FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).set({
                        //         "email": FirebaseAuth.instance.currentUser!.email,
                        //         "deviceToken": deviceToken,
                        //         "timestamp": FieldValue.serverTimestamp(),
                        //         "role" : "gd"
                        //       });
                        //     }
                        //     if(snap.exists){
                        //       if(snap.data()!["deviceToken"] != deviceToken){
                        //         FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).update({
                        //           "deviceToken": deviceToken,
                        //           "timestamp": FieldValue.serverTimestamp(),
                        //         }).then((value) {print("New token detected");});
                        //       }
                        //     }
                        //   });
                        //   Get.to(()=>GuardianHome());
                        // }else{
                        //   String? deviceToken;
                        //   await FirebaseMessaging.instance.getToken().then((token) {
                        //     setState(() {
                        //       deviceToken = token;
                        //       print('token : $deviceToken');
                        //     });
                        //   });
                        //
                        //   FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snap) {
                        //     if(!snap.exists){
                        //       FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).set({
                        //         "email": FirebaseAuth.instance.currentUser!.email,
                        //         "deviceToken": deviceToken,
                        //         "timestamp": FieldValue.serverTimestamp(),
                        //         "role" : "tt"
                        //       });
                        //     }
                        //     if(snap.exists){
                        //       if(snap.data()!["deviceToken"] != deviceToken){
                        //         FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).update({
                        //           "deviceToken": deviceToken,
                        //           "timestamp": FieldValue.serverTimestamp(),
                        //         }).then((value) {print("New token detected");});
                        //       }
                        //     }
                        //   });
                        //   Get.to(()=>TeacherHome());
                        // }
                        // // print(user.uid);
                        // // print(user.phoneNumber);
                        // // box.write("userPhone", user.phoneNumber);
                        //
                        //
                        // //Managing UserInfo
                        // // String? deviceToken;
                        // // await FirebaseMessaging.instance.getToken().then((token) {
                        // //   setState(() {
                        // //     deviceToken = token;
                        // //     print('token : $deviceToken');
                        // //   });
                        // // });
                        // //
                        // // FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snap) {
                        // //   if(!snap.exists){
                        // //     FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).set({
                        // //       "email": FirebaseAuth.instance.currentUser!.email,
                        // //       "deviceToken": deviceToken,
                        // //       "timestamp": FieldValue.serverTimestamp(),
                        // //     });
                        // //   }
                        // //   if(snap.exists){
                        // //     if(snap.data()!["deviceToken"] != deviceToken){
                        // //       FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).update({
                        // //         "deviceToken": deviceToken,
                        // //         "timestamp": FieldValue.serverTimestamp(),
                        // //       }).then((value) {print("New token detected");});
                        // //     }
                        // //   }
                        // // });
                        print("User created");
                        // Get.to(()=>TeacherHome());
                      }
                    }
                  }, text: "SIGN UP", color: Colors.grey.shade600),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      GestureDetector(
                        onTap: (){
                          Get.off(()=>LoginScreen());
                        },
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      /*body: Center(
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
      ),*/
      floatingActionButton: FloatingActionButton(onPressed: (){
        print(FirebaseAuth.instance.currentUser!.email);
      }),
    );
  }
}
