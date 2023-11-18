
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/screens/home_screen/teacher/PostScreen/screen/posts_screen.dart';
import 'package:tutor_kit/screens/home_screen/teacher/TeacherProfileScreen/screen/teacher_profile_screen.dart';

import '../../../const/consts.dart';

class TeacherHome extends StatelessWidget {
  var currentNavIndex=0.obs;
   TeacherHome({required this.currentNavIndex,super.key});

   DateTime? currentBackPressTime;


  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("press again to exit")));
        return Future.value(false);
      }
      return Future.value(true);
    }
    // var currentNavIndex=0.obs;
    var navbarItem=[
      BottomNavigationBarItem(icon: SvgPicture.asset(icHome,width: 30,),label: txtHome),
      //BottomNavigationBarItem(icon: CircleAvatar(radius:20,backgroundColor:bgColor,foregroundColor: Colors.yellow[800],child: Icon(Icons.add)),label: ""),
      BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(icName,width: 30,),
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("guardianResponse").where("tEmail", isEqualTo: FirebaseAuth.instance.currentUser!.email.toString()).where("isRead",isEqualTo: false).snapshots(),
                  builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> pSnap){
                    if(!pSnap.hasData){
                      return SizedBox();
                    }
                    if(pSnap.data!.docs.isEmpty){
                      return SizedBox();
                    }
                    if(pSnap.data!.docs.length > 0){
                      return Positioned(
                          right: -4,
                          top: -4,
                          child: CircleAvatar(backgroundColor: Colors.red,radius: 9,child: Text(pSnap.data!.docs.length.toString(),style: TextStyle(fontSize: 13,color: Colors.white),),)
                      );
                    }
                    return SizedBox();
                  }
              ),
            ],
          ),
          label: txtProfile
      ),
    ];
    var navBody=[
      PostsScreen(),
      TeacherProfileScreen(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(child: Column(
        children: [
          Obx(()=>Expanded(child: navBody.elementAt(currentNavIndex.value))),
        ],
      ), onWillPop: onWillPop),
      bottomNavigationBar: Obx(()=>
          Card(
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                side: BorderSide(color: primary)
            ),
            color: Colors.white,
            child: BottomNavigationBar(
              showUnselectedLabels: false,
              showSelectedLabels: false,
              currentIndex: currentNavIndex.value,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.orangeAccent,
              unselectedItemColor: Colors.grey[600],
              items: navbarItem,
              onTap: (value){
                currentNavIndex.value=value;
              },
            ),
          ),
      ),
    );
  }
}
