import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'package:get/get.dart';

import '../../../bloc/crud_db.dart';

class CheckoutController {
  final flutterBkash = FlutterBkash(
    bkashCredentials: BkashCredentials(
      username: "sandboxTokenizedUser02",
      password: "sandboxTokenizedUser02@12345",
      appKey: "4f6o0cjiki2rfm34kfdadl1eqq",
      appSecret: "2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b",
      isSandbox: true,
    ),
  );

  checkout(BuildContext context, double amount, String invoiceNumber, String postId) async {
    try {
      final result = await flutterBkash.pay(
        postId: postId,
        context: context,
        amount: amount,
        merchantInvoiceNumber: invoiceNumber,
      );
      if (result.trxId.isNotEmpty) {
        print(result.trxId);
        print(result);
        CrudDb().teacherTransactionStatus(
            FirebaseAuth.instance.currentUser!.email.toString(),
            postId,
            result.merchantInvoiceNumber,
            amount,
            result.trxId,
            result.payerReference,
            result.paymentId,
            result.customerMsisdn,
            FieldValue.serverTimestamp()
        );
      FirebaseFirestore.instance.collection("posts").doc(postId).update({
        "isBooked" : true,
      });
        return Get.showSnackbar(GetSnackBar(duration: Duration(seconds: 3),animationDuration: Duration(seconds: 1),message: 'Payment Successful. Your Transaction ID is: ${result.trxId}',));
      }
    } on BkashFailure catch (e) {
      print(e.message);
      print(e.error);
      return Get.showSnackbar(GetSnackBar(duration: Duration(seconds: 3),animationDuration: Duration(seconds: 1),message: e.message,));
    }
  }
}
