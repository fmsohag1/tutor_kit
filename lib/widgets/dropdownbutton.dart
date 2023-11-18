import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/consts.dart';

class CustomDropDownButton extends StatelessWidget {
  final String hint;
  final Widget prefixIcon;
  final String? value;
  final List list;
  final Function()? onTap;
  final Function(Object?)? onChange;
  final FormFieldValidator? validator;
  final AutovalidateMode? autoValidate;
  const CustomDropDownButton({super.key, required this.hint, required this.prefixIcon, required this.value, required this.list, this.onChange, this.validator, this.onTap, this.autoValidate});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(

      autovalidateMode: autoValidate,
      validator: validator,
      decoration: InputDecoration(

          hintText: hint,
          hintStyle: TextStyle(fontFamily: roboto_regular,color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w400),
          prefixIcon: prefixIcon,
          border: InputBorder.none,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black12),
          )
      ),
      isExpanded: true,
      icon: Icon(Icons.keyboard_arrow_down_outlined),
      value: value,
      borderRadius: BorderRadius.circular(10),
      items: list.map((valueItem){
        return DropdownMenuItem(
          onTap: onTap,
          child: Text(valueItem,style: TextStyle(fontFamily: roboto_regular),),value: valueItem,);
      }).toList(), onChanged: onChange,
    );
  }
}

