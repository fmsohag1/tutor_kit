/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/auth_screens/choose_screen.dart';
import 'package:tutor_kit/screens/home_screen/home_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:tutor_kit/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override

  Widget build(BuildContext context) {
    return  Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                    radius: 60,
                    backgroundColor: textfieldColor,
                    child: Image.asset(icTutor,width: 65,)),
              Text(txtTutorkit,style: TextStyle(fontFamily: roboto_bold,fontSize: 25,color: Colors.black45),),

              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    CustomTextField(hint: txtMobileNo, obsecure: false, preffixIcon: Icons.phone_android_outlined, type: TextInputType.phone),
                    SizedBox(height: 10,),
                    CustomTextField2(hint: txtPassword, preffixIcon: Icons.lock_open_outlined, type: TextInputType.visiblePassword),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(txtforgetPassword,style: TextStyle(color: Colors.blue,fontFamily: kalpurush),)
                      ],
                    ),
                    SizedBox(height: 20,),
                   CustomButton(onPress: (){
                     Get.to(()=>HomeScreen());
                   }, text: txtLogin,color: buttonColor,),
                    SizedBox(height: 20,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(txtDontAcc,
                         style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: kalpurush)
                         ),
                         GestureDetector(
                           onTap: (){
                             Get.to(()=>ChooseScreen());
                           },
                             child: Text(txtAccount,style: TextStyle(fontSize: 16,color: Colors.blue,fontFamily: kalpurush,fontWeight: FontWeight.bold)))
                       ],
                     )
                     
                   ]))
                  ],
                ),
              )
          ),
    );
  }
}
*/
