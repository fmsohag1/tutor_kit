import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_kit/const/consts.dart';


import '../../ChooseScreen/choose_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerified){
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (_)=>checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  Future sendVerificationEmail()async{
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future checkEmailVerified()async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified) timer?.cancel();
  }


  @override
  Widget build(BuildContext context){
    final box = GetStorage();
    return Scaffold(
      backgroundColor: bgColor2,
        body: isEmailVerified ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(repeat: false,"assets/icons/animation_lmej1fs8.json"),
              SizedBox(height: 10,),
              Text("EMAIL VARIFICATION SUCCESSFULL!"),
              SizedBox(height: 5,),
              Text("${FirebaseAuth.instance.currentUser!.email}",style: TextStyle(fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                Get.off(()=>const ChooseScreen());
                box.write("chooseQ", true);
              }, child: Text("CONTINUE",style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey.shade600),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),)
            ],
          ),
        ):
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icTutor,
                width: 100,
                color: inversePrimary,
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                width: 200,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.red,width: 2),
                ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/warning.svg",width: 20,),
                      SizedBox(width: 5,),
                      Text("Email not verified!"),
                    ],
                  )),
              SizedBox(height: 10,),
              Text("A verification email has sent to ",textAlign: TextAlign.center,),
              Text("${FirebaseAuth.instance.currentUser!.email.toString()}",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              Text("Please check and verify your email!"),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                sendVerificationEmail();
              }, child: Text("Resend Email",style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey.shade600),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),),
            ],
          ),
        )
    );
  }

}
