import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tutor_kit/const/consts.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final Widget preffixIcon;
  final TextInputType type;
  final TextEditingController controller;
  final int? max;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidate;
  final Iterable<String>? autofillHints;
  const CustomTextField(
      {super.key,
        this.label,
        required this.preffixIcon,
        required this.type,
        required this.controller,
        required this.hint,
        this.max,
        this.validator,
        this.autoValidate, this.autofillHints});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: autofillHints,
      autovalidateMode: autoValidate,
      validator: validator,
      maxLength: max,
      controller: controller,
      keyboardType: type,
      style: TextStyle(fontSize: 17,),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: preffixIcon,
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
    );
  }
}

//for suffix icon text_field
class CustomTextField2 extends StatefulWidget {
  final String? label;
  final String hint;
  final Widget preffixIcon;
  final TextInputType type;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidate;
  final Iterable<String>? autofillHints;
  const CustomTextField2({
    super.key,
    required this.hint,
    required this.preffixIcon,
    required this.type,
    required this.controller, this.label, this.validator, this.autoValidate, this.autofillHints,
  });

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  @override
  bool visible = true;
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: widget.autofillHints,
      validator: widget.validator,
      autovalidateMode: widget.autoValidate,
      controller: widget.controller,
      obscureText: visible,
      keyboardType: widget.type,
      decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(color: Colors.grey),
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: widget.preffixIcon,
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  visible = !visible;
                });
              },
              child: CircleAvatar(child: SvgPicture.asset(visible?icEye_off:icEye_on),backgroundColor: Colors.transparent,),
          ),

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
          )),
    );
  }
}
