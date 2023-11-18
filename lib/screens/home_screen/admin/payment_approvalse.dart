import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';


class PaymentApprovals extends StatelessWidget {
  const PaymentApprovals({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Approvals"),
      ),
      body: Center(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("teacherTransactionStatus").orderBy("timestamp",descending: true).snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, index){
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Container(
                                child: CircleAvatar(backgroundImage: AssetImage("assets/icons/display-pic.png"),radius: 25,)
                            ),
                            SizedBox(width: 10,),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(child: Text(snapshot.data!.docs[index]["tEmail"].toString(),style: TextStyle(fontSize: 17),)),
                                  Row(
                                    children: [
                                      Text("Amount : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text(snapshot.data!.docs[index]["amount"].toString(),style: TextStyle(color: Colors.green),),
                                      Text(" BDT",),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("TrxID : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text(snapshot.data!.docs[index]["transactionId"].toString(),style: TextStyle(color: Colors.green),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: snapshot.data!.docs[index]["status"] == true ?
                              GestureDetector(onTap: (){
                                FirebaseFirestore.instance.collection("teacherTransactionStatus").doc(snapshot.data!.docs[index].id).update({
                                  "status" : false
                                });
                                FirebaseFirestore.instance.collection("posts").doc(snapshot.data!.docs[index]["postId"]).update({
                                  "isBooked" : false,
                                });
                              }, child: Icon(Icons.check_circle,color: Colors.green,size: 30,)) :
                              GestureDetector(onTap: (){
                                FirebaseFirestore.instance.collection("teacherTransactionStatus").doc(snapshot.data!.docs[index].id).update({
                                  "status" : true
                                });
                                FirebaseFirestore.instance.collection("posts").doc(snapshot.data!.docs[index]["postId"]).update({
                                  "isBooked" : true,
                                });
                              }, child: Icon(Icons.circle_outlined,color: Colors.red,size: 30,)),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
        ),
      )
    );
  }
}
