// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../const/consts.dart';
// import '../screens/auth_screens/otp_screen.dart';
//
// class Auth {
//
//  Future signInWithPhoneNumber(String phoneNumber) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//
//     await auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await auth.signInWithCredential(credential);
//         // authentication successful, do something
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         // authentication failed, do something
//       },
//       codeSent: (String verificationId, int? resendToken) async {
//         // code sent to phone number, save verificationId for later use
//         String smsCode = ''; // get sms code from user
//         PhoneAuthCredential credential = PhoneAuthProvider.credential(
//           verificationId: verificationId,
//           smsCode: smsCode,
//         );
//         Get.to(OtpScreen(), arguments: [verificationId]);
//         await auth.signInWithCredential(credential);
//         // authentication successful, do something
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }
//
//    userLogin(String mobileNo) async {
//     String mobile = "+88"+mobileNo;
//     if (mobile == "") {
//       Get.snackbar(
//         "Please enter the mobile number!",
//         "Failed",
//         colorText: Colors.white,
//       );
//     } else {
//       signInWithPhoneNumber(mobile);
//     }
//   }
// }