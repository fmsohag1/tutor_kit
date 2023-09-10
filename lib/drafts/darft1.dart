// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class Draft1 extends StatelessWidget {
//    Draft1({super.key});
//  var docId = Get.arguments[0];
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference posts = FirebaseFirestore.instance.collection("posts");
//     return Scaffold(
//       body: Center(
//         child: FutureBuilder<DocumentSnapshot>(future: posts.doc(docId).get(),
//             builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
//           if(snapshot.hasError){
//             return Text("Something went wrong");
//           }
//           if(snapshot.hasData && !snapshot.data!.exists){
//             return Text("Document does not exist");
//           }
//           if(snapshot.connectionState == ConnectionState.done){
//             Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//             return Text("gender: ${data["salary"]}");
//           }
//           return CircularProgressIndicator();
//         })
//       ),
//     );
//   }
// }
