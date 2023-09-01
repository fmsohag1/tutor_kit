
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pinput/pinput.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/home_screen/teacher_home.dart';
import 'package:tutor_kit/widgets/custom_button.dart';

import '../home_screen/guardian_home.dart';

//

class OtpScreen extends StatefulWidget { 
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final box = GetStorage();

  String? otpCode;
  final String verificationId = Get.arguments[0];
  FirebaseAuth auth = FirebaseAuth.instance;


  // verify otp

  void verifyOtp(
      String verificationId,
      String userOtp,
      ) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await auth.signInWithCredential(creds)).user;
      if (user != null) {
        if(box.read('user')=='gd'){
          Get.to(()=>GuardianHome());
        }else{
          Get.to(()=>TeacherHome());
        }
        print(user.uid);
        print(user.phoneNumber);
        box.write("userPhone", user.phoneNumber);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        e.message.toString(),
        "Failed",
        backgroundColor: Colors.black12,
        colorText: Colors.white,
      );
    }
  }

  void _login() {
    if (otpCode != null) {
      verifyOtp(verificationId, otpCode!);
    } else {
      Get.snackbar(
        "Enter 6-Digit code",
        "Failed",
        colorText: Colors.white,
      );
    }
  }

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
                onCompleted: (value){
                  setState(() {
                    otpCode = value;
                  });
                },

              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(onPress: _login, text: Text(txtVerify,style: TextStyle(fontFamily: kalpurush,color: bgColor,fontSize: 18,letterSpacing: 1),), color: buttonColor),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("এই কোডের মেয়াদ শেষ হবে ",style: TextStyle(fontFamily: kalpurush),),
                  TweenAnimationBuilder(tween: Tween(begin: 60.0,end: 0), duration: Duration(seconds: 60), builder: (context,value,child){
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

