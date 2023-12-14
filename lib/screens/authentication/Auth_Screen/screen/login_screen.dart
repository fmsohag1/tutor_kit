import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/screens/authentication/Auth_Screen/screen/email_verification_screen.dart';
import 'package:tutor_kit/screens/authentication/Auth_Screen/screen/sign_up_screen.dart';
import 'package:tutor_kit/screens/home_screen/admin/admin_dashboard.dart';

import '../../../../bloc/firebase_auth_services.dart';
import '../../../../const/colors.dart';
import '../../../../const/images.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../home_screen/guardian/guardian_form_screen.dart';
import '../../../home_screen/guardian/guardian_home.dart';
import '../../../home_screen/teacher/teacher_home.dart';
import '../../ChooseScreen/choose_screen.dart';
import '../widget/continue_with.dart';
import '../widget/google_apple.dart';
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
    print(box.read("user"));
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
                    color: inversePrimary,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    preffixIcon: CircleAvatar(backgroundColor: Colors.transparent,child: SvgPicture.asset(icEmail,),),
                    type: TextInputType.emailAddress,
                    controller: emailController,
                    hint: 'Enter your email',
                    label: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email!';
                      }
                      return null;
                    },
                    autoValidate: AutovalidateMode.onUserInteraction,
                    autofillHints: const [AutofillHints.email],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField2(
                    hint: 'Enter your password',
                    preffixIcon: CircleAvatar(backgroundColor: Colors.transparent,child: SvgPicture.asset(icPassword),),
                    type: TextInputType.text,
                    controller: passwordController,
                    label: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password!';
                      }
                      return null;
                    },
                    autoValidate: AutovalidateMode.onUserInteraction,
                    autofillHints: const [AutofillHints.password],

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.to(()=>const ForgotPassword());
                          }, child: const Text("Forgot Password?",style: TextStyle(color: Colors.blue),))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      onPress: ()async{
                        if (_formKey.currentState!.validate()) {
                          showDialog(barrierDismissible: false,context: context, builder: (context){
                            return Dialog(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: const Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(color: Colors.black12,),
                                      SizedBox(width: 10,),
                                      Text("Loading...",style: TextStyle(fontSize: 18),)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                          User? user = await _firebaseAuthServices.signInWithEmailAndPassword(emailController.text, passwordController.text, context);
                          if(user != null){
                            await FirebaseFirestore.instance.collection("admin").where("email",isEqualTo: emailController.text).where("password",isEqualTo: passwordController.text).get().then((snap) {
                              if(snap.docs.isNotEmpty){
                                Get.off(()=>const AdminDashboard());
                                box.write("user", "ad");
                              }else{
                                final user = FirebaseAuth.instance.currentUser;
                                if(!user!.emailVerified){
                                  Get.to(()=>EmailVerificationScreen());
                                }
                                else {
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
                                      if(snap.data()!.keys.contains("role")) {
                                        if (snap.data()!["role"] == "gd") {
                                          if (snap.data()!.keys.contains(
                                              "name")) {
                                            Get.offAll(() =>
                                                GuardianHome(
                                                  currentNavIndex: 0.obs,));
                                            box.write("user", "gd");
                                          }
                                          if (!snap.data()!.keys.contains(
                                              "name")) {
                                            Get.to(() => GuardianFormScreen());
                                          }
                                        }
                                        if(snap.data()!["role"] == "tt"){
                                          Get.offAll(()=>TeacherHome(currentNavIndex: 0.obs,));
                                          box.write("user", "tt");
                                        }
                                      }
                                        if (!snap.data()!.keys.contains(
                                            "role")) {
                                          Get.off(() => ChooseScreen());
                                        }
                                      }
                                      if(!snap.exists){
                                        Get.off(()=>ChooseScreen());
                                      }
                                  });
                                }
                              }
                            });
                            print("User exists");
                          }
                        }
                        // Navigator.of(context).pop();
                      },
                      text: "SIGN IN",
                      color: Colors.grey.shade600),
                  const SizedBox(
                    height: 30,
                  ),
                  const ContinueWith(),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: ()async{
                        showDialog(context: context, builder: (BuildContext context){
                          return const Center(child: CircularProgressIndicator());
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
                                Get.off(()=>GuardianHome(currentNavIndex: 0.obs,));
                                box.write("user", "gd");
                              }
                              if(snap.data()!["role"] == "tt"){
                                Get.off(()=>TeacherHome(currentNavIndex: 0.obs,));
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
                              Get.to(()=>const ChooseScreen());
                            }
                          });
                        }
                        Get.back();
                      },
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
//side: BorderSide(color: Colors.orangeAccent,),
                        ),
                        color: primary,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(icGoogle,width: 30,),
                              SizedBox(width: 5,),
                              Text("Signin with Google",style: TextStyle(fontSize: 16),)
                            ],
                          ),
                        ),
                      )
                  ),
                  /*GoogleApple(onPressGoogle: ()async{
                    showDialog(context: context, builder: (BuildContext context){
                      return const Center(child: CircularProgressIndicator());
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
                            Get.off(()=>GuardianHome(currentNavIndex: 0.obs,));
                            box.write("user", "gd");
                          }
                          if(snap.data()!["role"] == "tt"){
                            Get.off(()=>TeacherHome(currentNavIndex: 0.obs,));
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
                          Get.to(()=>const ChooseScreen());
                        }
                      });
                    }
                    Get.back();
                  }),*/
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ",style: TextStyle(color: inversePrimary),),
                      GestureDetector(
                        onTap: (){
                          Get.off(()=>const SignUpScreen());
                        },
                        child: const Text(
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
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   print(FirebaseAuth.instance.currentUser);
      // }),
    );
  }
}
