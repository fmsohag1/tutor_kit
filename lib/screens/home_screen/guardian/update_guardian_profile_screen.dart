import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/bloc/crud_db.dart';

class UpdateGuardianProfileScreen extends StatelessWidget {
  UpdateGuardianProfileScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          child: Column(
                            children: [
                              TextField(
                                controller: nameController..text = "${data["name"]}",
                                decoration: InputDecoration(
                                    label: Text("name")
                                ),
                              ),
                              TextField(
                                controller: addressController..text = "${data["address"]}",
                                decoration: InputDecoration(
                                    label: Text("address")
                                ),
                              ),
                              TextField(
                                controller: mobileController..text = "${data["mobile"]}",
                                decoration: InputDecoration(
                                    label: Text("mobile")
                                ),
                              ),
                              SizedBox(height: 15,),
                              ElevatedButton(onPressed: (){
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
                              }, child: Text("Update"))
                            ],
                          ),
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  }
              ),
            )
        )
    );
  }
}