import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tutor_kit/const/colors.dart';
import 'package:tutor_kit/screens/auth_screens/login_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:tutor_kit/widgets/custom_textfield.dart';

import '../../const/consts.dart';

class GaurdianScreen extends StatelessWidget {
  const GaurdianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(txtGaurdian,style: TextStyle(fontFamily: kalpurush,fontSize: 20),),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundColor: textfieldColor,
                  child: Image.asset(icTutor,width: 55,)),
              const Text(txtTutorkit,style: TextStyle(fontFamily: roboto_bold,fontSize: 22,color: Colors.black45),),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const CustomTextField(hint: txtName, obsecure: false, preffixIcon: OctIcons.person_16, type: TextInputType.text),
                    const SizedBox(height: 5,),
                    const CustomTextField(hint: txtMobileNo, obsecure: false, preffixIcon: Icons.phone_android_outlined, type: TextInputType.phone),
                    const SizedBox(height: 5,),
                    const CustomTextField(hint: txtEmail, obsecure: false, preffixIcon: Icons.email_outlined, type: TextInputType.emailAddress),
                    const SizedBox(height: 5,),
                    const CustomTextField2(hint: txtPassword, preffixIcon: Icons.lock_open_outlined, type: TextInputType.visiblePassword),
                    const SizedBox(height: 5,),
                    const CustomTextField(hint: txtConfirmPassword, obsecure: true, preffixIcon: Icons.verified_user_outlined, type: TextInputType.visiblePassword),
                    const SizedBox(height: 10,),
                    CustomButton(onPress: (){}, text: txtGaurdianSignUp, color: buttonColor),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(txtHaveAccount,
                            style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: kalpurush)
                        ),
                        GestureDetector(
                            onTap: (){
                              Get.to(()=>const LoginScreen());
                            },
                            child: const Text(txtLogin,style: TextStyle(fontSize: 16,color: Colors.blue,fontFamily: kalpurush,fontWeight: FontWeight.bold)))
                      ],
                    )
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
