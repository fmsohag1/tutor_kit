import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';


class CustomAlertDialog extends StatelessWidget {
  final String assets;
  final String text;
  final Function() onTap;
  const CustomAlertDialog({super.key, required this.text,required this.assets, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Container(
        height: 230,
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                color: Colors.green.shade200,
              ),
              child: Lottie.asset(height: 100,assets),
            ),
            SizedBox(height: 20,),
            Text(text,textAlign: TextAlign.center,),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green.shade100
                      ),
                      child: Center(child: Text("OK",)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showLoaderDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    backgroundColor: Colors.transparent,
    content: Builder(builder: (context){
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Colors.red.shade300,
            ),
          ],
        ),
      );
    }),
  );
  showDialog(
      barrierDismissible: false,
      context: context, builder: (context){
    return alert;
  });
}
