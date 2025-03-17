import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextForPdf extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextStyle? customStyle;
  final int? maxLine;
  final TextAlign? textAlign;

  const CustomTextForPdf({
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.customStyle,
    this.maxLine,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: customStyle ??
          GoogleFonts.roboto(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: color,
          ),
      textAlign: textAlign,
      maxLines: maxLine,
    );
  }
}
