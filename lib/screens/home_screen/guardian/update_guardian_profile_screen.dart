import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/bloc/crud_db.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/widgets/custom_button.dart';

import '../../../widgets/custom_textfield.dart';

class UpdateGuardianProfileScreen extends StatelessWidget {
  UpdateGuardianProfileScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    void submit()async{
      showDialog(barrierDismissible: false,context: context, builder: (context){
        return Dialog(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: primary,strokeAlign: -1,),
                  SizedBox(width: 10,),
                  Text("Loading...",style: TextStyle(fontSize: 18),)
                ],
              ),
            ),
          ),
        );
      });
      CrudDb().updateGuardianProfile(
        nameController.text.trim(),
        addressController.text.trim(),
        mobileController.text.trim(),
      );
    }
    return Scaffold(
      backgroundColor: bgColor2,
        body: SafeArea(
            child: Center(
              child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get(),
                  builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
                    if(snapshot.hasError){
                      return Text("Something went wrong");
                    }
                    if(snapshot.hasData && !snapshot.data!.exists){
                      return Text("Document does not exist");
                    }
                    if(snapshot.connectionState == ConnectionState.done){
                      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: AnimationLimiter(
                            child: Column(
                              children: AnimationConfiguration.toStaggeredList(
                                duration: Duration(milliseconds: 200),
                                  childAnimationBuilder: (widget)=>SlideAnimation(
                                    verticalOffset: 50,
                                      child: FadeInAnimation(child: widget)),
                                  children: [
                                    CustomTextField(label: "Name", preffixIcon: CircleAvatar(child: SvgPicture.asset(icName,),backgroundColor: Colors.transparent,),
                                        type: TextInputType.text, controller: nameController..text = "${data["name"]}", hint: "Name"),
                                    SizedBox(height: 10,),
                                    CustomTextField(label: "Address", preffixIcon: CircleAvatar(child: SvgPicture.asset(icLocation,),backgroundColor: Colors.transparent,),
                                        type: TextInputType.text, controller: addressController..text = "${data["address"]}", hint: "Address"),
                                    SizedBox(height: 10,),
                                    CustomTextField(label: "Mobile", preffixIcon: CircleAvatar(child: SvgPicture.asset(icPhone,),backgroundColor: Colors.transparent,),
                                        type: TextInputType.text, controller: mobileController..text = "${data["mobile"]}", hint: "Mobile"),
                                    SizedBox(height: 15,),
                                    CustomButton(onPress: submit, text: "Update", color: Colors.grey.shade600)
                                    /*ElevatedButton(onPressed: (){
                                  showDialog(barrierDismissible: false,context: context, builder: (context){
                                    return Dialog(
                                      child: Container(
                                        height: 50,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    );
                                  });
                                  CrudDb().updateGuardianProfile(
                                      nameController.text.trim(),
                                      addressController.text.trim(),
                                      mobileController.text.trim(),
                                  );
                                }, child: Text("Update"))*/
                                  ],
                              )
                            ),
                          ),
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator(color: Colors.black12,strokeAlign: -1,));
                  }
              ),
            )
        )
    );
  }
}