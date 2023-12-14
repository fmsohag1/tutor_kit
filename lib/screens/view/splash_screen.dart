import 'package:flutter/material.dart';
import 'package:tutor_kit/const/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor2,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundImage: AssetImage("assets/images/tutor_kit1.jpeg",),radius: 50,),
            SizedBox(height: 10,),
            Text("TUTOR KIT")
          ],
        ),
      ),
      floatingActionButton: CircularProgressIndicator(color: primary,strokeAlign: -2),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
