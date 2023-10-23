import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/bloc/crud_db.dart';
import 'package:tutor_kit/screens/home_screen/teacher/guardian_info_for_teacher.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_status_screen.dart';

class PayBill extends StatefulWidget {
  const PayBill({super.key});

  @override
  State<PayBill> createState() => _PayBillState();
}

class _PayBillState extends State<PayBill> {
  var salary = Get.arguments[0];
  var postId = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    TextEditingController transactionIdController = TextEditingController();
    var amount = (15/100)*double.parse(salary);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Pay $amount BDT \nto \n01837471759\n(bKash / Nagad)",textAlign: TextAlign.center,),
              Text("&"),
              Text("Place transaction Id"),
              TextField(
                controller: transactionIdController,
                decoration: InputDecoration(
                  hintText: "Transaction id here"
                ),
              ),
              ElevatedButton(onPressed: (){
                CrudDb().teacherTransactionStatus(FirebaseAuth.instance.currentUser!.email.toString(), postId, transactionIdController.text, amount, FieldValue.serverTimestamp());
                Get.to(()=>TeacherStatusScreen(),arguments: postId);
                // String transactionId = "abc123";
                // if(transactionIdController.text.trim() == transactionId.toString()){
                //   Get.to(()=>GuardianInfoForTeacher());
                // }else {
                //   Get.snackbar("Alert", "Wrong transactionId provided");
                // }
                // print(transactionId);

              }, child: Text("Submit"))
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(()=>TeacherStatusScreen(),arguments: postId);
      }),
    );
  }
}
