import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userPhoneNumber = box.read("userPhone");
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome \n$userPhoneNumber",textAlign: TextAlign.center,style: TextStyle(fontSize: 25),),
            // ElevatedButton(onPressed: (){
            // }, child: Text("Test"))
          ],
        ),
      )
    );
  }
}
