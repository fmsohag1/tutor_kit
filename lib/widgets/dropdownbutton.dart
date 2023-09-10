import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/consts.dart';

class CustomDropDownButton extends StatelessWidget {
  final String hint;
  final Widget prefixIcon;
  final String? value;
  final List list;
  final Function(Object?)? onChange;
  const CustomDropDownButton({super.key, required this.hint, required this.prefixIcon, required this.value, required this.list, this.onChange});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontFamily: roboto_regular,color: Colors.grey),
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey),
          )
      ),
      isDense: true,
      //isExpanded: true,
      icon: Icon(Icons.keyboard_arrow_down_outlined),
      value: value,
      borderRadius: BorderRadius.circular(10),
      items: list.map((valueItem){
        return DropdownMenuItem(
          child: Text(valueItem,style: TextStyle(fontFamily: roboto_regular),),value: valueItem,);
      }).toList(), onChanged: onChange,
    );
  }
}
