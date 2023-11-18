import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/screens/authentication/Auth_Screen/screen/sign_up_screen.dart';
import 'package:tutor_kit/screens/home_screen/admin/admin_dashboard.dart';

import '../../../../bloc/firebase_auth_services.dart';
import '../../../../const/colors.dart';
import '../../../../const/images.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../home_screen/admin/payment_approvalse.dart';
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
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    preffixIcon: CircleAvatar(child: SvgPicture.asset(icEmail,),backgroundColor: Colors.transparent,),
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
                    autofillHints: [AutofillHints.email],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField2(
                    hint: 'Enter your password',
                    preffixIcon: CircleAvatar(child: SvgPicture.asset(icPassword),backgroundColor: Colors.transparent,),
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
                    autofillHints: [AutofillHints.password],

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
                          showDialog(barrierDismissible: false,context: context, builder: (context){
                            return Dialog(
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          });
                          User? user = await _firebaseAuthServices.signInWithEmailAndPassword(emailController.text, passwordController.text, context);
                          if(user != null){
                            await FirebaseFirestore.instance.collection("admin").where("email",isEqualTo: emailController.text).where("password",isEqualTo: passwordController.text).get().then((snap) {
                              if(snap.docs.isNotEmpty){
                                Get.off(()=>AdminDashboard());
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
                                    if(snap.data()!.keys.contains("name")){
                                      if(snap.data()!["role"] == "gd"){
                                        Get.offAll(()=>GuardianHome(currentNavIndex: 0.obs,));
                                        box.write("user", "gd");
                                      }
                                    }
                                    if(!snap.data()!.keys.contains("name")){
                                      if(snap.data()!["role"] == "gd"){
                                        Get.to(()=>GuardianFormScreen());
                                      }
                                    }
                                    if(snap.data()!["role"] == "tt"){
                                      Get.offAll(()=>TeacherHome(currentNavIndex: 0.obs,));
                                      box.write("user", "tt");
                                    }
                                  }

                                });
                              }
                            });
                            print("User exists");
                          }
                        }
                        // Navigator.of(context).pop();
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
                      Text("Don't have an account? ",style: TextStyle(color: inversePrimary),),
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
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   print(FirebaseAuth.instance.currentUser);
      // }),
    );
  }
}
