
import 'package:get/get.dart';
import 'package:tutor_kit/screens/home_screen/posts_screen.dart';
import 'package:tutor_kit/screens/home_screen/add_postscreen.dart';
import 'package:tutor_kit/screens/home_screen/profile_screen.dart';
import 'package:tutor_kit/screens/home_screen/teacher_homescreen.dart';
import 'package:tutor_kit/screens/home_screen/teacher_profile.dart';

import '../../const/consts.dart';

class TeacherHome extends StatelessWidget {
  const TeacherHome({super.key});

  @override
  Widget build(BuildContext context) {
    var currentNavIndex=0.obs;
    var navbarItem=[
      BottomNavigationBarItem(icon: Icon(Icons.home),label: txtHome),
      //BottomNavigationBarItem(icon: CircleAvatar(radius:20,backgroundColor:bgColor,foregroundColor: Colors.yellow[800],child: Icon(Icons.add)),label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined),label: txtProfile),
    ];
    var navBody=[
      PostsScreen(),
      TeacherProfile()
    ];
    return Scaffold(
      body: Column(
        children: [
          Obx(()=>Expanded(child: navBody.elementAt(currentNavIndex.value))),
        ],
      ),
      bottomNavigationBar: Obx(()=>
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BottomNavigationBar(
                currentIndex: currentNavIndex.value,
                backgroundColor: Colors.grey[600],
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.lightGreen,
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
    );
  }
}
