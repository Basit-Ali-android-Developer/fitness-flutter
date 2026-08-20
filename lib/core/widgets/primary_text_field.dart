import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool isObscure;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFA0AEC0),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: const Color(0xFF718096),
          size: 20,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF2F4F7),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}