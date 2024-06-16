import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
class AppStyles {
  ///
  /// Colors
  ///

  /// RGB 43, 80, 161
  static const Color mainColor = Color(0xff1E3E7A);

  static const Color mainColorLight = Color(0xff1E50A8);

  /// RGB 56, 58, 81
  static const Color mainColorDark = Color(0xff383a51);

  /// RGB 51, 196, 168
  static const Color secondaryColor = Color(0xff33C4A8);

  /// RGB 51, 196, 168
  // static const Color scaffoldColor = Color(0xfff8f8f8);
  static const Color scaffoldColor = Colors.white;

  static const Color infoHeaderColor = Color.fromRGBO(40, 52, 74, 0.7);

  ///
  /// Text
  ///

  static const Color mainTextColor = Color(0xff172030);

  static const Color secondaryTextColor = Color(0xffBBC8CE);

  static const TextStyle headerTextStyle = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 26, color: mainColorDark);

  /// header textstyle with 18 font size
  static const TextStyle headerTextStyleLess = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 18, color: mainColorDark);

  static const TextStyle infoTextStyleHeader =
      TextStyle(fontSize: 14, color: infoHeaderColor);

  static const TextStyle infoTextStyle = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 14, color: mainColorDark);

  //Redesign

  static TextStyle hintTextStyleWeb = GoogleFonts.roboto(
      color: Color(0xff767676), fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle hintTextStyleDevice = GoogleFonts.openSans(
      color: Color(0xff767676), fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle labelTextStyle = GoogleFonts.openSans(
      color: Color(0xff333333),
      fontSize: 18,
      height: 1.3,
      fontWeight: FontWeight.w600);

  ///
  /// Inputs
  ///

  static InputBorder inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(
          color: Color(0xffDCDFE5),
          // color: Colors.grey,
          width: 1),
      borderRadius: BorderRadius.circular(4));

  static InputBorder inputBorderFocused = OutlineInputBorder(
      borderSide: const BorderSide(
          color: AppStyles.mainColor,
          // color: Colors.grey,
          width: 2),
      borderRadius: BorderRadius.circular(4));

  static InputBorder inputBorderEnabled = OutlineInputBorder(
      borderSide: const BorderSide(
          color: Color(0xffDCDFE5),
          // color: Colors.grey,
          width: 1),
      borderRadius: BorderRadius.circular(4));

  static InputBorder inputBorderUnderline = UnderlineInputBorder(
      borderSide: BorderSide(color: AppStyles.mainColor.withOpacity(0.1)));

  static TextStyle inputLabelStyle =
      TextStyle(color: mainColorDark.withOpacity(0.5));

  static TextStyle inputLabelUnderlineStyle = TextStyle(
    fontSize: 18,
    color: AppStyles.mainColorDark.withOpacity(0.6),
  );

  // static TextStyle inputHintStyle = TextStyle(
  //   color: Color(0xff9D9D9F)
  //   // color: Color(0xff383A51)
  // );

  static double inputIconSize = 24;

  static const Color inputIconColor = Color(0xff9D9D9F);

  ///
  /// Buttons
  ///

}
