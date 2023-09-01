import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/consts.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({super.key});

  final postsRef = FirebaseFirestore.instance.collection("posts");

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userPhoneNumber = box.read("userPhone");
    return  Scaffold(
      backgroundColor: bgColor,
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
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.orange,width: 2)
              ),
              color: Colors.grey[700],
              child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)
                        ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("Gender : ${snapshot.data!.docs[index]["gender"]}",),
                          )),
                      SizedBox(width: 30,),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("Class : ${snapshot.data!.docs[index]["class"]}"),
                          )),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Subjects : ${snapshot.data!.docs[index]["subjects"]}"),
                      )),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("Day/Week : ${snapshot.data!.docs[index]["dayPerWeek"]}"),
                          )),
                      SizedBox(width: 20,),

                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("Curriculum : ${snapshot.data!.docs[index]["curriculum"]}"),
                          )),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Location : ${snapshot.data!.docs[index]["location"]}"),
                      )),
                  SizedBox(height: 10,),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text("Salary : ${snapshot.data!.docs[index]["salary"]}"),
                      )),
                ],
              ),
            ),),
          );
        });

      })
    );
  }
}
