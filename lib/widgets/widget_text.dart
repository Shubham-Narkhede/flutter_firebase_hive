import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget widgetText(
    {required String text,
    final bool isCentered = false,
    final int maxLine = 1,
    final double latterSpacing = 0.5,
    final bool textAllCaps = false,
    final isLongText = false,
    final TextStyle? style,
    TextAlign? textAlign}) {
  return Text(textAllCaps ? text.toUpperCase() : text,
      textAlign: textAlign ?? (isCentered
              ? TextAlign.center
              : TextAlign.start),
      maxLines: isLongText ? null : maxLine,
      overflow: TextOverflow.ellipsis,
      style: style);
}

TextStyle textStyleRubik(
    {double fontSize = 14,
    Color? textColor,
    FontWeight fontWeight = FontWeight.w500,
    TextStyle? textStyle,
    TextDecoration? decoration}) {
  return GoogleFonts.rubik(
      fontSize: fontSize,
      color: textColor,
      fontWeight: fontWeight,
      textStyle: textStyle,
      decoration: decoration);
}

TextStyle textStylePoppins(
    {double fontSize = 14,
    Color? textColor,
    FontWeight fontWeight = FontWeight.w500,
    TextDecoration? decoration,
    TextStyle? textStyle}) {
  return GoogleFonts.poppins(
      fontSize: fontSize,
      color: textColor,
      fontWeight: fontWeight,
      decoration: decoration,
      textStyle: textStyle);
}
 
