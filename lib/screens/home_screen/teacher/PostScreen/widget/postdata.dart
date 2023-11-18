import 'dart:ffi';

import '../../../../../const/consts.dart';

class PostData extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final String? subtitle;
  final double? width;
  const PostData({super.key, this.icon, this.title, this.subtitle, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
      ),
      child: Row(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(color: Colors.black)
            ),
              child: CircleAvatar(child: icon,backgroundColor: bgColor2,)),
          SizedBox(width: 5,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                Text(subtitle!),
              ],
            ),
          )
        ],
      ),
    );
  }
}
