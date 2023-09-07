import 'package:flutter/material.dart';
import 'package:tutor_kit/widgets/custom_button.dart';

class AlertDialog extends StatelessWidget {
  final String text;
  final Function() onPressNo;
  final Function() onPressYes;
  const AlertDialog({super.key, required this.text, required this.onPressNo, required this.onPressYes});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          Text(text),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(onPress: onPressNo, text: Text("No"), color: Colors.white),
              CustomButton(onPress: onPressYes, text: Text("Yes"), color: Colors.white),
            ],
          )
        ],
      ),
    );
  }
}
