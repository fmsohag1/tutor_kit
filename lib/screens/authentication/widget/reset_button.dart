import '../../../../const/consts.dart';

class ResetButton extends StatelessWidget {
  final Function()? onPress;
  const ResetButton({super.key, this.onPress});

  @override
  Widget build(BuildContext context) {
    return  TextButton(onPressed: onPress, child: Text("Reset Password",style: TextStyle(color: Colors.white),),style: TextButton.styleFrom(backgroundColor: Colors.grey.shade600,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),)
    ;
  }
}
