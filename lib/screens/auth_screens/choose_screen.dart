import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/auth_screens/guardian_screen.dart';
import 'package:tutor_kit/screens/auth_screens/teacher_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(right: 15,left: 15),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: textfieldColor,
            image: DecorationImage(image: AssetImage(icTutorGrey,),scale: 3,)
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(txtChooseText,style: TextStyle(fontFamily: kalpurush,fontSize: 18,),textAlign: TextAlign.justify,),
                ),
                const SizedBox(height: 20,),
                CustomButton(onPress: (){
                  Get.to(()=>const GaurdianScreen());
                }, text: txtGaurdian,color: Colors.black26,),
                const SizedBox(height: 5,),
                CustomButton(onPress: (){
                  Get.to(()=>const TeacherScreen());
                }, text: txtTeacher,color: Colors.black26,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
