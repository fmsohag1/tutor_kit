import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tutor_kit/const/colors.dart';
import 'package:tutor_kit/screens/auth_screens/login_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:tutor_kit/widgets/custom_textfield.dart';

import '../../const/consts.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          txtTeacher,
          style: TextStyle(fontFamily: kalpurush, fontSize: 20),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundColor: textfieldColor,
                  child: Image.asset(
                    icTutor,
                    width: 55,
                  )),
              const Text(
                txtTutorkit,
                style: TextStyle(
                    fontFamily: roboto_bold,
                    fontSize: 22,
                    color: Colors.black45),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const CustomTextField(
                        hint: txtName,
                        obsecure: false,
                        preffixIcon: OctIcons.person_16,
                        type: TextInputType.text),
                    const SizedBox(
                      height: 5,
                    ),
                    const CustomTextField(
                        hint: txtMobileNo,
                        obsecure: false,
                        preffixIcon: Icons.phone_android_outlined,
                        type: TextInputType.phone),
                    const SizedBox(
                      height: 5,
                    ),
                    const CustomTextField(
                        hint: txtEmail,
                        obsecure: false,
                        preffixIcon: Icons.email_outlined,
                        type: TextInputType.emailAddress),
                    const SizedBox(
                      height: 5,
                    ),
                    const CustomTextField2(
                        hint: txtPassword,
                        preffixIcon: Icons.lock_open_outlined,
                        type: TextInputType.visiblePassword),
                    const SizedBox(
                      height: 5,
                    ),
                    const CustomTextField(
                        hint: txtConfirmPassword,
                        obsecure: true,
                        preffixIcon: Icons.verified_user_outlined,
                        type: TextInputType.visiblePassword),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        onPress: () {
                          Get.to(() => const TeacherScreenInfo());
                        },
                        text: txtNext,
                        color: buttonColor),
                    const SizedBox(
                      height: 20,
                    ),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(txtHaveAccount,
                            style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: kalpurush)
                        ),
                        GestureDetector(
                            onTap: (){
                              Get.to(()=>LoginScreen());
                            },
                            child: Text(txtLogin,style: TextStyle(fontSize: 16,color: Colors.blue,fontFamily: kalpurush,fontWeight: FontWeight.bold)))
                      ],
                    )*/
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TeacherScreenInfo extends StatefulWidget {
  const TeacherScreenInfo({super.key});

  @override
  State<TeacherScreenInfo> createState() => _TeacherScreenInfoState();
}

class _TeacherScreenInfoState extends State<TeacherScreenInfo> {
  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isMaleSelected = true;
                        isFemaleSelected = false;
                      });
                    },
                    child: Container(
                      height: 70,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: isMaleSelected == true ? Colors.green : buttonColor
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person,color: Colors.white,),
                          Text(txtMale,style: TextStyle(color: Colors.white,fontFamily: kalpurush),),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isMaleSelected = false;
                        isFemaleSelected = true;
                      });
                    },
                    child: Container(
                      height: 70,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: isFemaleSelected == true ? Colors.green : buttonColor
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_2,color: Colors.white,),
                          Text(txtFemale,style: TextStyle(color: Colors.white,fontFamily: kalpurush),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // CustomTextField(hint: txtGender, obsecure: false, preffixIcon: FontAwesome.venus, type: TextInputType.text),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                  hint: txtBirthYear,
                  obsecure: false,
                  preffixIcon: FontAwesome.calendar,
                  type: TextInputType.phone),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                  hint: txtInstitute,
                  obsecure: false,
                  preffixIcon: Icons.school_outlined,
                  type: TextInputType.emailAddress),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                  hint: txtDepartment,
                  obsecure: false,
                  preffixIcon: FontAwesome.book_open,
                  type: TextInputType.emailAddress),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                  hint: txtClass,
                  obsecure: false,
                  preffixIcon: Icons.class_outlined,
                  type: TextInputType.emailAddress),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                  hint: txtSubject,
                  obsecure: false,
                  preffixIcon: Icons.subtitles_outlined,
                  type: TextInputType.emailAddress),
              SizedBox(
                height: 5,
              ),
              CustomButton(onPress: (){}, text: txtGaurdianSignUp, color: buttonColor)
            ],
          ),
        ),
      )),
    );
  }
}
