
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static heading(
    String text, {
    Color? color,
        int? maxline,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    String? fontFamily,
    double? fontsize,
        double? letterSpacing,
  }) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      overflow: TextOverflow.ellipsis,
      maxLines:  maxline ?? 1,
      style: TextStyle(
        letterSpacing: letterSpacing ?? 0.0,
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: fontsize ?? 24,
        fontFamily: fontFamily ?? GoogleFonts.lato().fontFamily,
      ),
    );
  }

  static subHeading(
    String text, {
    Color? color,
        int? maxline,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    String? fontFamily,
    double? fontsize,
        double? letterSpacing,
  }) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      overflow: TextOverflow.ellipsis,
      maxLines:  maxline ?? 1,
      style: TextStyle(
        letterSpacing: letterSpacing ?? 0.0,
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontsize ?? 14,
        fontFamily: fontFamily ?? GoogleFonts.josefinSans().fontFamily,
      ),
    );
  }

  static normal(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxline,
    double? fontsize,
        double? letterSpacing,
  }) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      overflow: TextOverflow.ellipsis,
      maxLines:  maxline ?? 1,
      style: TextStyle(
        letterSpacing: letterSpacing ?? 0.0,
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontsize ?? 12,
        fontFamily: fontFamily ?? GoogleFonts.jost().fontFamily,
      ),
    );
  }
}
