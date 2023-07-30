import 'package:flutter/material.dart';
import 'package:tutor_kit/const/consts.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData preffixIcon;
  final bool obsecure;
  final TextInputType type;
  const CustomTextField({super.key, required this.hint, required this.obsecure, required this.preffixIcon, required this.type});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontFamily: kalpurush),
        prefixIcon: Icon(preffixIcon,size: 25,),
        border: InputBorder.none,
        filled: true,
        fillColor: textfieldColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: bgColor),
        ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: bgColor),
          )

      ),
    );
  }
}

//for suffix icon text_field
class CustomTextField2 extends StatefulWidget {
  final String hint;
  final IconData preffixIcon;
  final TextInputType type;
  const CustomTextField2({super.key, required this.hint, required this.preffixIcon, required this.type});

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  @override
  bool visible=true;
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: visible,
      keyboardType: widget.type,
      decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(fontFamily: kalpurush),
          prefixIcon: Icon(widget.preffixIcon,size: 25,),
          suffixIcon: GestureDetector(
            onTap: (){
              setState(() {
                visible=!visible;
              });
            },
              child: Icon(visible?Icons.visibility_outlined:Icons.visibility_off_outlined,size: 25,)),
          border: InputBorder.none,
          filled: true,
          fillColor: textfieldColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: bgColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: bgColor),
          )

      ),
    );
  }
}
