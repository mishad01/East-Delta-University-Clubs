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
  final bool showUnderline; // New parameter to toggle underline

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
    this.showUnderline = true, // Default: underline is visible
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon:
            suffixIcon != null ? Icon(suffixIcon) : null, // Fix suffix icon
        border: showUnderline
            ? const UnderlineInputBorder() // Show underline
            : InputBorder.none, // Hide underline
      ),
    );
  }
}
