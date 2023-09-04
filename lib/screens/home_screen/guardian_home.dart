
import 'package:get/get.dart';
import 'package:tutor_kit/screens/home_screen/posts_screen.dart';
import 'package:tutor_kit/screens/home_screen/add_postscreen.dart';
import 'package:tutor_kit/screens/home_screen/guardian_profilescreen.dart';

import '../../const/consts.dart';

class GuardianHome extends StatelessWidget {
  const GuardianHome({super.key});

  @override
  Widget build(BuildContext context) {
    var currentNavIndex=0.obs;
    var navbarItem=[
      //BottomNavigationBarItem(icon: Icon(Icons.home),label: txtHome),
      BottomNavigationBarItem(icon: Image.asset(icAdd,width: 30,),label: ""),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 30,),label: txtProfile),
    ];
    var navBody=[
      AddPostScreen(),
      GuardianProfile()
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
    );
  }
}
