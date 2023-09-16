
import 'package:get/get.dart';
import 'package:tutor_kit/screens/home_screen/posts_screen.dart';
import 'package:tutor_kit/screens/home_screen/teacher_profile.dart';

import '../../const/consts.dart';

class TeacherHome extends StatelessWidget {
  const TeacherHome({super.key});

  @override
  Widget build(BuildContext context) {
    var currentNavIndex=0.obs;
    var navbarItem=[
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 30,),label: txtHome),
      //BottomNavigationBarItem(icon: CircleAvatar(radius:20,backgroundColor:bgColor,foregroundColor: Colors.yellow[800],child: Icon(Icons.add)),label: ""),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 30,),label: txtProfile),
    ];
    var navBody=[
      PostsScreen(),
      TeacherProfile()
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Obx(()=>Expanded(child: navBody.elementAt(currentNavIndex.value))),
        ],
      ),
      bottomNavigationBar: Obx(()=>
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
            child: Card(
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.black)
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
      ),
    );
  }
}
