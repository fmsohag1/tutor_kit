import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tutor_kit/bloc/crud_db.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_status_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:tutor_kit/widgets/custom_textfield.dart';

class PayBill extends StatefulWidget {
  const PayBill({super.key});

  @override
  State<PayBill> createState() => _PayBillState();
}

class _PayBillState extends State<PayBill> {
  final _formKey = GlobalKey<FormState>();
  var salary = Get.arguments[0];
  var postId = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    TextEditingController transactionIdController = TextEditingController();
    var amount = (30 / 100) * double.parse(salary);
    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Text("Pay $amount BDT \nto \n01837471759\n(bKash / Nagad)",textAlign: TextAlign.center,),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.brown.shade100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "YOUR MEDIA FEE : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$amount",
                          style: TextStyle(color: Colors.green, fontSize: 18),
                        ),
                        Text(" BDT")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("To"),
                  SizedBox(
                    height: 10,
                  ),
                  //Text("Place transaction Id"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.brown.shade100),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CircleAvatar(
                                  child: Image.asset(
                                    "assets/icons/bkash.png",
                                    width: 30,
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SelectableText("01863275190",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.brown.shade100),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CircleAvatar(
                                  child: Image.asset(
                                    "assets/icons/nagad.png",
                                    width: 30,
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SelectableText(
                                "01863275190",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    preffixIcon: Image.asset(
                      "assets/icons/trans.png",
                      color: Colors.black,
                    ),
                    type: TextInputType.text,
                    controller: transactionIdController,
                    hint: "TYHFTHSJSR etc.",
                    label: "Transaction Id",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Transaction Id!';
                      }
                      return null;
                    },
                    autoValidate: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          CrudDb().teacherTransactionStatus(
                              FirebaseAuth.instance.currentUser!.email.toString(),
                              postId,
                              transactionIdController.text,
                              amount,
                              FieldValue.serverTimestamp());
                          Get.off(() => TeacherStatusScreen(), arguments: postId);
                        }

                      },
                      text: "Submit",
                      color: Colors.grey.shade600),
                  /*ElevatedButton(onPressed: (){
                  CrudDb().teacherTransactionStatus(FirebaseAuth.instance.currentUser!.email.toString(), postId, transactionIdController.text, amount, FieldValue.serverTimestamp());
                  Get.to(()=>TeacherStatusScreen(),arguments: postId);
                  // String transactionId = "abc123";
                  // if(transactionIdController.text.trim() == transactionId.toString()){
                  //   Get.to(()=>GuardianInfoForTeacher());
                  // }else {
                  //   Get.snackbar("Alert", "Wrong transactionId provided");
                  // }
                  // print(transactionId);

                }, child: Text("Submit"))*/
                ],
              ),
            ),
          )),
    );
  }
}
