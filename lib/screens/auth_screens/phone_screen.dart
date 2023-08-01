import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/auth_screens/otp_screen.dart';
import 'package:tutor_kit/screens/controller/user_controller.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:tutor_kit/widgets/custom_textfield.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key, });

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 60,
                  backgroundColor: textfieldColor,
                  child: Image.asset(icTutor,width: 65,)),
              SizedBox(height: 20,),
              Text(txtPhoneText,style: TextStyle(fontFamily: kalpurush,fontSize: 18),),
              SizedBox(height: 10,),
              CustomTextField(hint: txtMobileNo, obsecure: false, preffixIcon: Icons.phone_android_outlined, type: TextInputType.phone),
              SizedBox(height: 10,),
              CustomButton(onPress: (){
                Get.to(()=>OtpScreen());

              }, text: txtSubmit, color: buttonColor)

            ],
          ),
        ),
      ),
    );
  }
}


