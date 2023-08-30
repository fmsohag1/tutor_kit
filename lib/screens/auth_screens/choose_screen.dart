
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/auth_screens/guardian_screen.dart';
import 'package:tutor_kit/screens/auth_screens/phone_screen.dart';
import 'package:tutor_kit/screens/auth_screens/teacher_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({super.key});

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  final box = GetStorage();
  bool isGuardian = false;
  bool isTutor = false;
  // bool? isGuardianSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(right: 15,left: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(icTutorGrey),height: 100,),
              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text(txtChooseText,style: TextStyle(fontFamily: kalpurush,fontSize: 18,),textAlign: TextAlign.justify,),
              // ),
               const SizedBox(height: 80,),
              CustomButton(onPress: (){
                // print(isGuardian);
                setState(() {
                  isGuardian = true;
                  isTutor = false;
                });
                // Get.to(()=>const GaurdianScreen());
              }, text: txtGaurdian,color: isGuardian ? Colors.green : Colors.black26,),
              const SizedBox(height: 5,),
              CustomButton(onPress: (){
                setState(() {
                  isGuardian = false;
                  isTutor = true;
                });
                // Get.to(()=>const TeacherScreen());
              }, text: txtTeacher,color: isTutor ? Colors.green : Colors.black26,),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                setState(() {
                  if(isGuardian || isTutor == true){
                    Get.to(()=>PhoneScreen(),);
                    if(isGuardian == true){
                      box.write("user", "gd");
                    }
                    if(isTutor == true) {
                      box.write("user", "tt");
                    }
                  }
                  else {
                    Get.snackbar("Warning", "Select Tutor or Guardian");
                  }
                });
              }, child: Text("Login with Phone"))
            ],
          ),
        ),
      ),
    );
  }
}
