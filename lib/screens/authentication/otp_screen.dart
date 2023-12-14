import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/authentication/ChooseScreen/choose_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';

class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 55,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black12),
            )
        ),
        onSaved: (value) {},
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key,required this.myauth}) : super(key: key);
  final EmailOTP myauth ;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  String otpController = "1234";
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      backgroundColor: bgColor2,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icTutor,width: 100,color: inversePrimary,),
          const SizedBox(
            height: 20,
          ),

          const Text(
            "Enter your PIN",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Otp(
                otpController: otp1Controller,
              ),
              Otp(
                otpController: otp2Controller,
              ),
              Otp(
                otpController: otp3Controller,
              ),
              Otp(
                otpController: otp4Controller,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 100,
            child: TextButton(onPressed: ()async{
              if (await widget.myauth.verifyOTP(otp: otp1Controller.text +
              otp2Controller.text +
              otp3Controller.text +
              otp4Controller.text) == true) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("OTP is verified",textAlign: TextAlign.center,),
              ));
              Get.off(()=>ChooseScreen());
              box.write("chooseQ", true);
              } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Invalid OTP",textAlign: TextAlign.center,),
              ));
              }
            }, child: Text("Verify",style: TextStyle(color: Colors.white),),style: TextButton.styleFrom(backgroundColor: Colors.grey.shade600,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),),
          )
          /*ElevatedButton(
            onPressed: () async {
              if (await widget.myauth.verifyOTP(otp: otp1Controller.text +
                  otp2Controller.text +
                  otp3Controller.text +
                  otp4Controller.text) == true) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("OTP is verified",textAlign: TextAlign.center,),
                ));
                Get.off(()=>ChooseScreen());
                box.write("chooseQ", true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Invalid OTP",textAlign: TextAlign.center,),
                ));
              }
            },
            child: const Text(
              "Confirm",
              style: TextStyle(fontSize: 20),
            ),
          )*/
        ],
      ),
    );
  }
}
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
//
// import 'package:pinput/pinput.dart';
// import 'package:tutor_kit/const/consts.dart';
// import 'package:tutor_kit/screens/home_screen/teacher/teacher_home.dart';
// import 'package:tutor_kit/widgets/custom_button.dart';

// import '../home_screen/guardian/guardian_home.dart';
// import '../home_screen/teacher/teacher_form_screens.dart';
//
// //
//
// class OtpScreen extends StatefulWidget {
//   const OtpScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//
//   final box = GetStorage();
//
//   String? otpCode;
//   final String verificationId = Get.arguments[0];
//   FirebaseAuth auth = FirebaseAuth.instance;
//
//
//   // verify otp
//
//   void verifyOtp(
//       String verificationId,
//       String userOtp,
//       ) async {
//     try {
//       PhoneAuthCredential creds = PhoneAuthProvider.credential(
//           verificationId: verificationId, smsCode: userOtp);
//       User? user = (await auth.signInWithCredential(creds)).user;
//       if (user != null) {
//         if(box.read('user')=='gd'){
//           Get.to(()=>GuardianHome());
//         }else{
//           Get.to(()=>TeacherHome());
//         }
//         print(user.uid);
//         print(user.phoneNumber);
//         box.write("userPhone", user.phoneNumber);
//
//
//         //Managing UserInfo
//         String? deviceToken;
//           await FirebaseMessaging.instance.getToken().then((token) {
//             setState(() {
//               deviceToken = token;
//               print('token : $deviceToken');
//             });
//           });
//
//         FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snap) {
//           if(!snap.exists){
//             FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).set({
//               "mobile": FirebaseAuth.instance.currentUser!.phoneNumber,
//               "deviceToken": deviceToken,
//               "timestamp": FieldValue.serverTimestamp(),
//             });
//           }
//           if(snap.exists){
//             if(snap.data()!["deviceToken"] != deviceToken){
//               FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).update({
//                 "deviceToken": deviceToken,
//                 "timestamp": FieldValue.serverTimestamp(),
//               }).then((value) {print("New token detected");});
//             }
//           }
//         });
//
//
//
//       }
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar(
//         e.message.toString(),
//         "Failed",
//         backgroundColor: Colors.black12,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   void _login() {
//     if (otpCode != null) {
//       verifyOtp(verificationId, otpCode!);
//     } else {
//       Get.snackbar(
//         "Enter 6-Digit code",
//         "Failed",
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.w600),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//     );
//
//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: Colors.grey.shade500),
//       borderRadius: BorderRadius.circular(8),
//     );
//
//     final submittedPinTheme = defaultPinTheme.copyWith(
//       decoration: defaultPinTheme.decoration?.copyWith(
//         color: Color.fromRGBO(234, 239, 243, 1),
//       ),
//     );
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: bgColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(onPressed: (){
//           Navigator.pop(context);
//         }, icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,)),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                   radius: 60,
//                   backgroundColor: textfieldColor,
//                   child: Image.asset(icTutor,width: 65,)),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 txtOtpText,
//                 style: TextStyle(fontSize: 18,fontFamily: kalpurush),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Pinput(
//                 defaultPinTheme: defaultPinTheme,
//                 focusedPinTheme: focusedPinTheme,
//                 submittedPinTheme: submittedPinTheme,
//                 length: 6,
//                 showCursor: true,
//                 onCompleted: (value){
//                   setState(() {
//                     otpCode = value;
//                   });
//                 },
//
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               CustomButton(onPress: _login, text: Text(txtVerify,style: TextStyle(fontFamily: kalpurush,color: bgColor,fontSize: 18,letterSpacing: 1),), color: buttonColor),
//               SizedBox(height: 10,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("এই কোডের মেয়াদ শেষ হবে ",style: TextStyle(fontFamily: kalpurush),),
//                   TweenAnimationBuilder(tween: Tween(begin: 60.0,end: 0), duration: Duration(seconds: 60), builder: (context,value,child){
//                     return Text("00:${value.toInt()}",style: TextStyle(color: Colors.redAccent),);
//                   }),
//                   Text(" সেকেন্ড",style: TextStyle(fontFamily: kalpurush),),
//                 ],
//               ),
//               SizedBox(height: 10,),
//               Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   side: BorderSide(color: Colors.orange)
//                 ),
//                   child: Container(
//                     height: 26,
//                       width: 130,
//                       child: Center(child: Text("আবার OTP পাঠান",style: TextStyle(fontFamily: kalpurush,fontSize: 16)))))
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

