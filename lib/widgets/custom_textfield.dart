

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutor_kit/const/consts.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final IconData preffixIcon;
  final TextInputType type;
  final TextEditingController controller;
  final int? max;
  const CustomTextField({super.key, this.label, required this.preffixIcon, required this.type, required this.controller, required this.hint,this.max});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: max,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontFamily: kalpurush),
        hintText: hint,
        hintStyle: TextStyle(fontFamily: kalpurush,color: Colors.grey),
        prefixIcon: Icon(preffixIcon,size: 25,),
        border: InputBorder.none,
        filled: true,
        fillColor: textfieldColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: bgColor),
        ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: bgColor),
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
  final TextEditingController controller;
  const CustomTextField2({super.key, required this.hint, required this.preffixIcon, required this.type, required this.controller,});

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  @override
  bool visible=true;
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: visible,
      keyboardType: widget.type,
      decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(fontFamily: kalpurush),
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
            borderSide: BorderSide(color: bgColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: bgColor),
          )

      ),
    );
  }
}
