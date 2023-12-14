import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../const/consts.dart';

class GuardianInfo extends StatelessWidget {
  final String? title;
  final Function()? onPress;
  final Widget? icon;
  const GuardianInfo({super.key, this.title, this.onPress,this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        leading: icon,
        title: Text(title!,style: TextStyle(fontSize: 17,fontFamily: roboto_medium),),
        tileColor: bgColor,
        trailing: Icon(Icons.arrow_forward_ios_rounded,size: 15,),
      ),
    );
  }
}
