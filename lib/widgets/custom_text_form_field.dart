import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.text,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.text,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xff667C89)),
        ),
        errorStyle: TextStyle(color: Colors.blueGrey[600]),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: (Colors.blueGrey[500])!),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
