
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/auth_screens/choose_screen.dart';
import 'package:tutor_kit/screens/auth_screens/phone_screen.dart';
import 'package:tutor_kit/screens/controller/user_controller.dart';
import 'package:tutor_kit/widgets/custom_button.dart';



class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.grey.shade500),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 60,
                  backgroundColor: textfieldColor,
                  child: Image.asset(icTutor,width: 65,)),
              SizedBox(
                height: 10,
              ),
              Text(
                txtOtpText,
                style: TextStyle(fontSize: 18,fontFamily: kalpurush),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                length: 6,
                showCursor: true,
                onChanged: (value){
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(onPress: (){
                Get.to(()=>ChooseScreen());
              }, text: txtVerify, color: buttonColor),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("এই কোডের মেয়াদ শেষ হবে ",style: TextStyle(fontFamily: kalpurush),),
                  TweenAnimationBuilder(tween: Tween(begin: 30.0,end: 0), duration: Duration(seconds: 30), builder: (context,value,child){
                    return Text("00:${value.toInt()}",style: TextStyle(color: Colors.redAccent),);
                  }),
                  Text(" সেকেন্ড",style: TextStyle(fontFamily: kalpurush),),
                ],
              ),
              SizedBox(height: 10,),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.orange)
                ),
                  child: Container(
                    height: 26,
                      width: 130,
                      child: Center(child: Text("আবার OTP পাঠান",style: TextStyle(fontFamily: kalpurush,fontSize: 16)))))

            ],
          ),
        ),
      ),
    );
  }
}

