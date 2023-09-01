
import 'package:get/get.dart';
import 'package:tutor_kit/screens/home_screen/posts_screen.dart';
import 'package:tutor_kit/screens/home_screen/add_postscreen.dart';
import 'package:tutor_kit/screens/home_screen/profile_screen.dart';

import '../../const/consts.dart';

class GuardianHome extends StatelessWidget {
  const GuardianHome({super.key});

  @override
  Widget build(BuildContext context) {
    var currentNavIndex=0.obs;
    var navbarItem=[
      //BottomNavigationBarItem(icon: Icon(Icons.home),label: txtHome),
      BottomNavigationBarItem(icon: CircleAvatar(radius:15,backgroundColor:bgColor,foregroundColor: Colors.yellow[800],child: Icon(Icons.add)),label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined,size: 30,),label: txtProfile),
    ];
    var navBody=[
      AddPostScreen(),
      ProfileScreen()
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
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: currentNavIndex.value,
                backgroundColor: buttonColor,
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
    );
  }
}
