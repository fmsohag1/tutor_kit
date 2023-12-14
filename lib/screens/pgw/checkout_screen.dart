import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tutor_kit/const/colors.dart';

import 'pgw_bkash/checkout_controller.dart';

class CheckoutScreen extends StatelessWidget {

  var salary = Get.arguments[0];
  var postId = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    // var amount = (30 / 100) * int.parse(salary);
    String amount = "1";
    int invoiceNumber = DateTime.now().microsecondsSinceEpoch;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: const Color(0xffEE1284),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown.shade100
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("YOUR MEDIA FEE : ",style: TextStyle(fontWeight: FontWeight.w600),),
                  Text(amount.toString(),style: TextStyle(color: Color(0xffEE1284)),),
                  Text(" BDT"),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Text("TO"),
            SizedBox(height: 10,),
            RichText(text: TextSpan(
              children:[
                TextSpan(
                  text: 'By pressing the payment button you are agreed with our ',
                    style: TextStyle(color: Colors.grey)
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=(){print('Baler apps');},
                  text: 'privacy policy ',
                  style: TextStyle(color: Colors.blue)
                ),
                TextSpan(
                  text: ' and',
                    style: TextStyle(color: Colors.grey)
                ),
                TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=(){},
                  text: ' payment conditions.',
                    style: TextStyle(color: Colors.blue)
                )
              ]
            ),textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                CheckoutController().checkout(context, double.parse(amount), invoiceNumber.toString(), postId);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xffEE1284),width: 2)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/bkash.svg',width: 50,),
                    SizedBox(width: 10,),
                    Text("Pay with Bkash",style: TextStyle(fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}