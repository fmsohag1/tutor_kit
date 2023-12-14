import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_kit/const/colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor2,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/icons/animation_lmej1fs8.json',repeat: false),
            SizedBox(height: 10,),
            Text("PAYMENT SUCCESSFULL!"),
          ],
        ),
      ),
    );
  }
}

class FailedScreen extends StatelessWidget {
  const FailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor2,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/icons/warning.json',repeat: false),
            SizedBox(height: 10,),
            Text("PAYMENT FAILED!"),
          ],
        ),
      ),
    );
  }
}

class CancelledScreen extends StatelessWidget {
  const CancelledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor2,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/icons/wrong.json',repeat: false),
            SizedBox(height: 10,),
            Text("PAYMENT CANCELLED!"),
          ],
        ),
      ),
    );
  }
}
