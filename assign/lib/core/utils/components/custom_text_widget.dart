// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final EdgeInsets padding;
  final Color color;

  const CustomTextWidget({
    Key? key,
    required this.text,
    required this.color,
    this.fontSize = 18, // Default font size
    this.padding = const EdgeInsets.all(8.0), // Default padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: GoogleFonts.ptSans(fontSize: fontSize, color: color),
      ),
    );
  }
}
