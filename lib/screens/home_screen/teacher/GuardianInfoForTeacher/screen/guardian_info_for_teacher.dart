import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/home_screen/teacher/GuardianInfoForTeacher/widget/guardian_info.dart';
import 'package:url_launcher/url_launcher.dart';

class GuardianInfoForTeacher extends StatelessWidget {
  const GuardianInfoForTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    var postId = Get.arguments;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection("posts").doc(postId).get(),
              builder: (BuildContext context,AsyncSnapshot <DocumentSnapshot>snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return FutureBuilder(
                      future: FirebaseFirestore.instance.collection("userInfo").where("email",isEqualTo: data["userEmail"]).get(),
                      builder: (BuildContext context,AsyncSnapshot <QuerySnapshot>detSnap){
                        if(detSnap.connectionState == ConnectionState.done){
                          // Map<String, dynamic> data = detSnap.data! as Map<String, dynamic>;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 40,
                                  width: double.infinity,
                                  color: Colors.black12,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8,left: 10),
                                    child: Text("Guardian Info",style: TextStyle(fontSize: 17,),),
                                  )),
                              SizedBox(height: 20,),
                              GuardianInfo(iconData: Icons.email_outlined,title: detSnap.data!.docs.first["email"],onPress: (){
                                launch(
                                    'mailto:${detSnap.data!.docs.first["email"]}');
                              },),
                              SizedBox(height: 10,),
                              GuardianInfo(iconData: Icons.call,title: detSnap.data!.docs.first["mobile"],onPress: ()async{
                                await FlutterPhoneDirectCaller.callNumber('${detSnap.data!.docs.first["mobile"]}');
                              },),
                              SizedBox(height: 10,),
                              GuardianInfo(iconData: Icons.location_on_outlined,title: detSnap.data!.docs.first["address"],),
                            ],
                          );
                        }
                        return CircularProgressIndicator();
                      }
                  );
                }
                return CircularProgressIndicator();
              }
          ),
        ),
      ),
    );
  }
}
