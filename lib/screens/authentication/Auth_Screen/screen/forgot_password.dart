import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/widgets/custom_alert_dialog.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:tutor_kit/widgets/custom_textfield.dart';

import '../../widget/reset_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(text: "Password reset link sent! Check your email", assets: "assets/icons/animation_lmej1fs8.json",onTap: ()=>Get.back(),);
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(text: "${e.message.toString()}", assets: "assets/icons/warning.json",onTap: ()=>Get.back(),);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Reset Password",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter your email and we will send you a password reset link",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                preffixIcon: Image.asset(icEmail25),
                type: TextInputType.emailAddress,
                controller: emailController,
                hint: "Enter your email",
                label: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email!';
                  }
                  return null;
                },
                autoValidate: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(
                height: 10,
              ),
              ResetButton(
                onPress: resetPassword,
              )
            ],
          ),
        ),
      ),
    );
  }
}
