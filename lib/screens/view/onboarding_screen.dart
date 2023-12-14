
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tutor_kit/screens/authentication/Auth_Screen/screen/login_screen.dart';

import '../../const/consts.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  final List <PageViewModel> pages=[
    PageViewModel(
      title: "",
        bodyWidget: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",textAlign: TextAlign.justify,),
        image: Center(
          child: Image.asset("assets/icons/onboarding1.png",),
        )
    ),
    PageViewModel(
      title: "",
        bodyWidget: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",textAlign: TextAlign.justify,),
        image: Center(
          child: Image.asset("assets/images/9461510.png",width: 150,),
        )
    ),
    PageViewModel(
      title: "",
        bodyWidget: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",textAlign: TextAlign.justify,),
        image: Center(
          child: Image.asset("assets/images/6342486.jpg",width: 250,),
        )
    ),
  ];

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: secondary,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(12,80,12,12),
          child: IntroductionScreen(
            globalBackgroundColor: secondary,
            pages: pages,
            done: Text("DONE",style: TextStyle(color: Colors.black),),
            doneStyle: ButtonStyle(alignment: Alignment.center),
            showDoneButton: true,
            onDone: (){
              Get.off(()=>LoginScreen());
            },
            next: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
            showNextButton: true,
            skip: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,),
            showSkipButton: true,
            //curve: Curves.bounceOut,
          ),
        )
    );
  }
}