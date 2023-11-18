import '../../../../const/consts.dart';

class ChooseScreenButton extends StatelessWidget {
  final Function() onPress;
  const ChooseScreenButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(onPressed: onPress, child: Text("➜",style: TextStyle(fontSize: 22),),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.orange.shade200))),
    );
  }
}
