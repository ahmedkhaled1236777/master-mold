import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class customtextform extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefixicon;
  final String hintText;
  bool obscureText;
  Widget? suffixIcon;
  String? val;
  TextInputType keyboardType;

  List<TextInputFormatter>? inputFormatters;
  customtextform(
      {super.key,
      this.keyboardType = TextInputType.text,
      this.inputFormatters,
      required this.controller,
      required this.prefixicon,
      required this.hintText,
      this.obscureText = false,
      this.val,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: (value) {
        if (value!.isEmpty) {
          return val;
        }
      },
      obscureText: obscureText,
      style: TextStyle(fontSize: 13, color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 15),
          focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.5)),
          enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.5)),
          prefixIcon: Icon(
            prefixicon,
            color: Colors.white,
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: const Color.fromARGB(255, 47, 46, 46), width: 0.5)),
          hintText: hintText,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(
            fontSize: 13,
            fontFamily: "cairo",
            color: Colors.white,
          )),
    );
  }
}
