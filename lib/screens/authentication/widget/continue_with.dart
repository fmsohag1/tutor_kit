import '../../../../const/consts.dart';

class ContinueWith extends StatelessWidget {
  const ContinueWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey,
            )),
        SizedBox(
          width: 5,
        ),
        Text(
          "Or Continue with",
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey,
            )),
      ],
    );
  }
}
