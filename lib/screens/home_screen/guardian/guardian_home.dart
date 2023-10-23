
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_form_screen.dart';
import 'package:tutor_kit/screens/home_screen/guardian/teacher_list.dart';
import 'package:tutor_kit/screens/home_screen/teacher/posts_screen.dart';
import 'package:tutor_kit/screens/home_screen/guardian/add_postscreen.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_profilescreen.dart';

import '../../../const/consts.dart';

class GuardianHome extends StatelessWidget {
  const GuardianHome({super.key});

  @override
  Widget build(BuildContext context) {
    var currentNavIndex=0.obs;
    var navbarItem=[
      BottomNavigationBarItem(icon: Image.asset(icStudent,width: 30,),label: ""),
      BottomNavigationBarItem(icon: Image.asset(icAdd,width: 40,),label: ""),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 30,),label: txtProfile),
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
        body: Column(
          children: [
            Obx(()=>Expanded(child: navBody.elementAt(currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(()=>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black)
                ),
                color: Colors.white,
                child: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  currentIndex: currentNavIndex.value,
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.orangeAccent,
                  unselectedItemColor: bgColor,
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
      ),
    );
  }
}
