import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tutor_kit/const/colors.dart';
import 'package:tutor_kit/screens/auth_screens/login_screen.dart';
import 'package:tutor_kit/screens/home_screen/home.dart';
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
        title: Text(txtGaurdian,style: TextStyle(fontFamily: kalpurush,fontSize: 20),),
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
              Text(txtTutorkit,style: TextStyle(fontFamily: roboto_bold,fontSize: 22,color: Colors.black45),),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    CustomTextField(hint: txtName, obsecure: false, preffixIcon: OctIcons.person_16, type: TextInputType.text),
                    SizedBox(height: 5,),
                    CustomTextField(hint: txtMobileNo, obsecure: false, preffixIcon: Icons.phone_android_outlined, type: TextInputType.phone),
                    SizedBox(height: 5,),
                    CustomTextField(hint: txtEmail, obsecure: false, preffixIcon: Icons.email_outlined, type: TextInputType.emailAddress),

                    SizedBox(height: 10,),
                    CustomButton(onPress: (){
                      Get.to(()=>Home());
                    }, text: txtGaurdianSignUp, color: buttonColor),
                    SizedBox(height: 20,),
                   /* Row(
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
