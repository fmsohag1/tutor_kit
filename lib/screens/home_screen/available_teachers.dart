import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AvailableTeacher extends StatefulWidget {
  const AvailableTeacher({super.key});

  @override
  State<AvailableTeacher> createState() => _AvailableTeacherState();
}

class _AvailableTeacherState extends State<AvailableTeacher> {
  @override
  Widget build(BuildContext context) {
    CollectionReference teacherRequest = FirebaseFirestore.instance.collection("teacherRequest");
    return Scaffold(
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
            future: teacherRequest.doc().get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
              if(snapshot.hasError){
                return Text("Something went wrong");
              }
              if(snapshot.hasData && !snapshot.data!.exists){
                return Text("Document does not exist");
              }
              if(snapshot.connectionState == ConnectionState.done){
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context,index){
                  return Text(data[index]["postID"]);
                });
              }
              return CircularProgressIndicator();
            }
        ),
      ),
    );
  }
}
