import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final postsRef = FirebaseFirestore.instance.collection("posts");

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userPhoneNumber = box.read("userPhone");
    return  Scaffold(
      body: StreamBuilder(
          stream: postsRef.snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator(),);
        }
        // final data = snapshot.requireData;
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 8),
            child: Card(child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Gender : ${snapshot.data!.docs[index]["gender"]}"),
                  Text("Class : ${snapshot.data!.docs[index]["class"]}"),
                  Text("Subjects : ${snapshot.data!.docs[index]["subjects"]}"),
                  Text("Day/Week : ${snapshot.data!.docs[index]["dayPerWeek"]}"),
                  Text("Location : ${snapshot.data!.docs[index]["location"]}"),
                  Text("Curriculum : ${snapshot.data!.docs[index]["curriculum"]}"),
                  Text("Salary : ${snapshot.data!.docs[index]["salary"]}"),
                ],
              ),
            ),),
          );
        });

      })
    );
  }
}
