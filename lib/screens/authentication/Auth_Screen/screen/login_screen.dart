import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/screens/authentication/Auth_Screen/screen/sign_up_screen.dart';

import '../../../../bloc/firebase_auth_services.dart';
import '../../../../const/images.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../home_screen/admin/admin_home.dart';
import '../../../home_screen/guardian/guardian_home.dart';
import '../../../home_screen/teacher/teacher_home.dart';
import '../../ChooseScreen/choose_screen.dart';
import '../../widget/continue_with.dart';
import '../../widget/google_apple.dart';
import 'forgot_password.dart';

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.to(()=>ForgotPassword());
                          }, child: Text("Forgot Password?",style: TextStyle(color: Colors.blue),))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      onPress: ()async{
                        if (_formKey.currentState!.validate()) {
                          User? user = await _firebaseAuthServices.signInWithEmailAndPassword(emailController.text, passwordController.text);
                          if(user != null){
                            await FirebaseFirestore.instance.collection("admin").where("email",isEqualTo: emailController.text).where("password").get().then((snap) {
                              if(snap.docs.isNotEmpty){
                                Get.to(()=>AdminHome());
                                box.write("user", "ad");
                              }else{
                                String? deviceToken;
                                FirebaseMessaging.instance.getToken().then((token) {
                                  setState(() {
                                    deviceToken = token;
                                    print('token : $deviceToken');
                                  });
                                });
                                FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snap) {
                                  if(snap.exists){
                                    if(snap.data()!["deviceToken"] != deviceToken){
                                      FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                        "deviceToken": deviceToken,
                                        "timestamp": FieldValue.serverTimestamp(),
                                      }).then((value) {print("New token detected");});
                                    }
                                    if(snap.data()!["role"] == "gd"){
                                      Get.to(()=>GuardianHome());
                                      box.write("user", "gd");
                                    }
                                    if(snap.data()!["role"] == "tt"){
                                      Get.to(()=>TeacherHome());
                                      box.write("user", "tt");
                                    }
                                  }

                                });
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
                            // print(user.uid);
                            // print(user.phoneNumber);
                            // box.write("userPhone", user.phoneNumber);


                            //Managing UserInfo
                            // String? deviceToken;
                            // await FirebaseMessaging.instance.getToken().then((token) {
                            //   setState(() {
                            //     deviceToken = token;
                            //     print('token : $deviceToken');
                            //   });
                            // });
                            //
                            // FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snap) {
                            //   if(!snap.exists){
                            //     FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).set({
                            //       "email": FirebaseAuth.instance.currentUser!.email,
                            //       "deviceToken": deviceToken,
                            //       "timestamp": FieldValue.serverTimestamp(),
                            //     });
                            //   }
                            //   if(snap.exists){
                            //     if(snap.data()!["deviceToken"] != deviceToken){
                            //       FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).update({
                            //         "deviceToken": deviceToken,
                            //         "timestamp": FieldValue.serverTimestamp(),
                            //       }).then((value) {print("New token detected");});
                            //     }
                            //   }
                            // });
                            print("User exists");
                            // Get.to(()=>TeacherHome());
                          }
                        }
                        //txtClear();
                      },
                      text: "SIGN IN",
                      color: Colors.grey.shade600),
                  SizedBox(
                    height: 30,
                  ),
                  ContinueWith(),
                  SizedBox(
                    height: 30,
                  ),
                  GoogleApple(onPressGoogle: ()async{
                    showDialog(context: context, builder: (BuildContext context){
                      return Center(child: CircularProgressIndicator());
                    });
                    UserCredential? credential = await _firebaseAuthServices.signInWithGoogle();
                    if(credential.user != null){
                      String? deviceToken;
                      await FirebaseMessaging.instance.getToken().then((token) {
                        setState(() {
                          deviceToken = token;
                          print('token : $deviceToken');
                        });
                      });
                      FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snap) {
                        if(snap.exists){
                          if(snap.data()!["role"] == "gd"){
                            Get.to(()=>GuardianHome());
                            box.write("user", "gd");
                          }
                          if(snap.data()!["role"] == "tt"){
                            Get.to(()=>TeacherHome());
                            box.write("user", "tt");
                          }
                          if(snap.data()!["deviceToken"] != deviceToken){
                            FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).update({
                              "deviceToken": deviceToken,
                              "timestamp": FieldValue.serverTimestamp(),
                            }).then((value) {print("New token detected");});
                          }
                        }
                        if(!snap.exists){
                          Get.to(()=>ChooseScreen());
                        }
                      });
                    }
                    Get.back();
                  }),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      GestureDetector(
                        onTap: (){
                          Get.off(()=>SignUpScreen());
                        },
                        child: Text(
                          "SIGN UP",
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
      floatingActionButton: FloatingActionButton(onPressed: () {
        print(FirebaseAuth.instance.currentUser);
      }),
    );
  }
}
