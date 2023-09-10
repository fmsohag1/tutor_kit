import '../const/consts.dart';

class CustomButton extends StatelessWidget {
  final Function() onPress;
  final Widget text;
  final Color color;
  const CustomButton({super.key, required this.onPress, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.orangeAccent,),
        ),
        color: color,
        child: Container(
          height: 55,
          width: double.infinity,
          child: Center(child: text),
        ),
      ),
    );
  }
}

class MiniCustomButton extends StatelessWidget {
  final Function() onPress;
  final Widget text;
  final Color color;
  const MiniCustomButton({super.key, required this.onPress, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.orangeAccent,),
        ),
        color: color,
        child: Container(
          height: 30,
          width: 100,
          child: Center(child: text),
        ),
      ),
    );
  }
}



