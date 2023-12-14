import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/bloc/firebase_auth_services.dart';
import 'package:tutor_kit/screens/authentication/Auth_Screen/screen/email_verification_screen.dart';
import 'package:tutor_kit/screens/home_screen/admin/admin_dashboard.dart';

import '../../../../const/colors.dart';
import '../../../../const/images.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../otp_screen.dart';
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


  Future<void> verifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
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
                    preffixIcon: CircleAvatar(backgroundColor: Colors.transparent,child: SvgPicture.asset(icPassword,),),

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
                    autofillHints: const [AutofillHints.newPassword],

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField2(
                    hint: 'Enter your confirm password',
                    preffixIcon: CircleAvatar(backgroundColor: Colors.transparent,child: SvgPicture.asset(icConfirm,),),

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
                    autofillHints: const [AutofillHints.password],

                  ),
                  const SizedBox(height: 20,),
                  CustomButton(onPress:()async{
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
                      User? user = await _firebaseAuthServices.signUpWithEmailAndPassword(emailController.text, passwordController.text, context);
                      if(user != null){
                        await FirebaseFirestore.instance.collection("admin").where("email",isEqualTo: emailController.text).where("password",isEqualTo: passwordController.text).get().then((snap) async {
                          if(snap.docs.isNotEmpty){
                             Get.off(()=>const AdminDashboard());
                            box.write("user", "ad");
                          }else{
                            Get.off(()=>EmailVerificationScreen(),arguments: emailController.text);
                            // sendOtp();
                            /*Get.off(()=>ChooseScreen());
                            box.write("chooseQ", true);*/
                          }
                        });
                        // Get.to(()=>TeacherHome());
                      }

                    }
                  }, text: "SIGN UP", color: Colors.grey.shade600),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ",style: TextStyle(color: inversePrimary),),
                      GestureDetector(
                        onTap: (){
                          Get.off(()=>const LoginScreen());
                        },
                        child: const Text(
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
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //   print(FirebaseAuth.instance.currentUser!.email);
      // }),
    );
  }
}
