
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/auth_screens/choose_screen.dart';
import 'package:tutor_kit/screens/auth_screens/otp_screen.dart';
import 'package:tutor_kit/screens/controller/authentication_repository.dart';
import 'package:tutor_kit/screens/controller/signup_controller.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:tutor_kit/widgets/custom_textfield.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key, });
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}
class _PhoneScreenState extends State<PhoneScreen> {
  // var controller=Get.put(SignUpController());

final box = GetStorage();


  //auth start
  final TextEditingController phoneController = TextEditingController();

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        // authentication successful, do something
      },
      verificationFailed: (FirebaseAuthException e) {
        // authentication failed, do something
      },
      codeSent: (String verificationId, int? resendToken) async {
        // code sent to phone number, save verificationId for later use
        String smsCode = ''; // get sms code from user
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );
        Get.to(OtpScreen(), arguments: [verificationId]);
        await auth.signInWithCredential(credential);
        // authentication successful, do something
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void _userLogin() async {
    String mobile = "+88"+phoneController.text;
    if (mobile == "") {
      Get.snackbar(
        "Please enter the mobile number!",
        "Failed",
        colorText: Colors.black,
      );
    } else {
      signInWithPhoneNumber(mobile);
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  //auth end

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
              CustomTextField(controller: phoneController,hint: txtMobileNo, obsecure: false, preffixIcon: Icons.phone_android_outlined, type: TextInputType.phone),
              SizedBox(height: 10,),
              CustomButton(onPress: _userLogin, text: txtSubmit, color: buttonColor),
              // ElevatedButton(onPressed: _userLogin, child: Text("Send Code")),
            ],
          ),
        ),
      ),
    );
  }
}


