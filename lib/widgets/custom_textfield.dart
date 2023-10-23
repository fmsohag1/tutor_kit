import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  const CustomTextField(
      {super.key,
        this.label,
        required this.preffixIcon,
        required this.type,
        required this.controller,
        required this.hint,
        this.max,
        this.validator,
        this.autoValidate});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autoValidate,
      validator: validator,
      maxLength: max,
      controller: controller,
      keyboardType: type,
      style: TextStyle(fontSize: 17, fontFamily: roboto_regular),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: roboto_regular,
            color: Colors.grey,
          ),
          prefixIcon: preffixIcon,
          border: InputBorder.none,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey),
          )),
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
  const CustomTextField2({
    super.key,
    required this.hint,
    required this.preffixIcon,
    required this.type,
    required this.controller, this.label, this.validator, this.autoValidate,
  });

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  @override
  bool visible = true;
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      autovalidateMode: widget.autoValidate,
      controller: widget.controller,
      obscureText: visible,
      keyboardType: widget.type,
      decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(color: Colors.grey),
          hintText: widget.hint,
          prefixIcon: widget.preffixIcon,
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  visible = !visible;
                });
              },
              child: Icon(
                visible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 25,
              )),
          border: InputBorder.none,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey),
          )),
    );
  }
}
