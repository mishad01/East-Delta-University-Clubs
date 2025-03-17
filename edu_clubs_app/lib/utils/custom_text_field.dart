import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool showUnderline;
  final TextInputType? keyboardType; // New parameter for keyboard type

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.showUnderline = true,
    this.keyboardType, // Initialize keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType, // Apply keyboardType
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        border: showUnderline ? const UnderlineInputBorder() : InputBorder.none,
      ),
    );
  }
}
