import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/auth_screens/choose_screen.dart';

import '../auth_screens/phone_screen.dart';

class GuardianProfile extends StatelessWidget {
  GuardianProfile({super.key});
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar :AppBar(
        actions: [
          Text("Logout"),
          IconButton(onPressed: (){
            Get.offAll(()=>ChooseScreen());
            box.remove("userPhone");
          }, icon: Icon(Icons.logout))
        ],
      ),*/
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: Colors.black)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset(icAddUser,width: 80,color: Colors.grey[600],),
                    )),
                Text("Shah Arif Abdullah",style: TextStyle(fontSize: 20,fontFamily: roboto_bold),),
                SizedBox(height: 20,),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  leading: Image.asset(icPhone,width: 30,),
                  title: Text("+8801837471759",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                  tileColor: bgColor,
                  trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                ),
                SizedBox(height: 10,),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  leading: Image.asset(icNotification,width: 30,),
                  title: Text("Notification",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                  tileColor: bgColor,
                  trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                ),
                SizedBox(height: 10,),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  leading: Image.asset(icHistory,width: 30,),
                  title: Text("History",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                  tileColor: bgColor,
                  trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                ),
                SizedBox(height: 10,),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  leading: Image.asset(icLogout,width: 30,),
                  title: Text("Logout",style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
                  tileColor: bgColor,
                  trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//dhufhdufhd
