
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_form_screen.dart';
import 'package:tutor_kit/screens/home_screen/guardian/teacher_list.dart';
import 'package:tutor_kit/screens/home_screen/teacher/PostScreen/screen/posts_screen.dart';
import 'package:tutor_kit/screens/home_screen/guardian/add_postscreen.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_profilescreen.dart';

import '../../../bloc/lite_api.dart';
import '../../../const/consts.dart';

class GuardianHome extends StatelessWidget {
  var currentNavIndex=0.obs;
   GuardianHome({required this.currentNavIndex,super.key});


  @override
  Widget build(BuildContext context) {
    DateTime? currentBackPressTime;

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
    // FirebaseFirestore.instance.collection("posts").where("userEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email).get().then((pSnap) {
    //   FirebaseFirestore.instance.collection("teacherRequest").where("postID",isEqualTo: pSnap.docs.first.id).where("isRead", isEqualTo: false).get().then((trSnap) {
    //     LiteApi.trTotal = trSnap.docs.length;
    //   });
    // });

    var navbarItem=[
      BottomNavigationBarItem(icon: SvgPicture.asset(icStudent,width: 30,),label: ""),
      BottomNavigationBarItem(icon: SvgPicture.asset(icAdd,width: 35,),label: ""),
      BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(icName,width: 30,),
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("posts").where("userEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots(),
                  builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> pSnap){
                    if(!pSnap.hasData){
                      return SizedBox();
                    }
                    if(pSnap.data!.docs.isEmpty){
                      return SizedBox();
                    }
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("teacherRequest").where("postID",isEqualTo: pSnap.data!.docs.first.id).where("isRead", isEqualTo: false).snapshots(),
                        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> trSnap){
                          if(!trSnap.hasData){
                            return SizedBox();
                          }
                          if(trSnap.data!.docs.isEmpty){
                            return SizedBox();
                          }
                          if(trSnap.data!.docs.length > 0){
                            return Positioned(
                                right: -4,
                                top: -4,
                                child: CircleAvatar(backgroundColor: Colors.red,radius: 9,child: Text(trSnap.data!.docs.length.toString(),style: TextStyle(fontSize: 13,color: Colors.white),),)
                            );
                          }
                          return SizedBox();
                        }
                    );
                  }
              ),
            ],
          ),
          label: txtProfile
      ),
    ];
    var navBody=[
      TeacherList(),
      AddPostScreen(),
      GuardianProfile()
    ];
    // FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snap){
    //   if(snap.data()!["mobile"]==null){
    //     print("no data");
    //     print(snap.data()!["mobile"]);
    //   } else {
    //     print("has data");
    //   }
    // });


    return SizedBox(
      child: Scaffold(
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
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: currentNavIndex.value,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.orangeAccent,
                unselectedItemColor: Colors.grey[600],
                selectedLabelStyle: TextStyle(fontFamily: kalpurush,),
                unselectedLabelStyle: TextStyle(fontFamily: kalpurush),
                items: navbarItem,
                onTap: (value){
                  currentNavIndex.value=value;
                },
              ),
            ),
        ),
      ),
    );
  }
}
