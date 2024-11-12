import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextfieldTwo extends StatelessWidget {
  const CustomTextfieldTwo({
    super.key,
    this.controller,
    this.onSubmit,
    this.color,
    this.maxLines,
    this.validator,
    this.onChanged,
    required this.hintText,
    this.autofocus,
    this.keyboardType,
  });
  final TextEditingController? controller;
  final bool? autofocus;
  final void Function(String)? onSubmit;
  final String hintText;
  final Color? color;
  final int? maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus ?? false,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.grey.withOpacity(0.9),
        fontSize: 12,
      ),
      maxLines: maxLines,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w200,
          color: Colors.grey.withOpacity(0.9),
          fontSize: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.9),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.9),
          ),
        ),
      ),
    );
  }
}
