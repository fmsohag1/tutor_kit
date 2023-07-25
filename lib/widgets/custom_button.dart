import '../const/consts.dart';

class CustomButton extends StatelessWidget {
  final Function() onPress;
  final String text;
  const CustomButton({super.key, required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          //side: BorderSide(color: Colors.lightBlue,width: 2),
        ),
        color: buttonColor,
        child: Container(
          height: 55,
          width: double.infinity,
          child: Center(child: Text(txtLogin,style: TextStyle(fontFamily: roboto_bold,color: bgColor,fontSize: 18,letterSpacing: 1),)),
        ),
      ),
    );
  }
}
