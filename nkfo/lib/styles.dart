import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// ignore: avoid_classes_with_only_static_members
class AppStyles {

  static const Color mainColor = Color(0xff1E3E7A);
  static const Color mainColorDark = Color(0xff383a51);
  static const Color scaffoldColor = Color(0xfff8f8f8);
  static const Color infoHeaderColor = Color.fromRGBO(40, 52, 74, 0.7);
  static const Color mainTextColor = Color(0xff172030);


  static TextStyle labelTextFieldStyle = GoogleFonts.openSans(
    color: AppStyles.mainTextColor
  );  

  static TextStyle buttonsWhiteTextStyle = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xffFFFFFF)
  );

  static TextStyle buttonsBlueTextStyle = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppStyles.mainColor
  );

  static TextStyle headingTableTextStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppStyles.mainColor,
  );

  static TextStyle headerTextStyle = GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
    fontSize: 26,
    color: mainColorDark
  );

  static TextStyle headerTextStyleLess =  GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: mainColorDark
  );

  static TextStyle infoTextStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: mainColorDark
  );
}