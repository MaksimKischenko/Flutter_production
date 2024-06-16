// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

class AppStyles {
  ///
  /// Colors
  ///
  ///#f7f9fc

  /// RGB 43, 80, 161
  static const Color mainColor = Color(0xff1E50A8);
  static Color headingRowColor =  const Color(0xfff7f9fc);//Colors.grey.shade100;

  static const Color colorSelectedElement = Color(0xffEDF6FF);
  static const Color colorDark3 = Color(0xff364157);
  /// RGB 56, 58, 81
  static const Color mainColorDark = Color(0xff383a51);

  /// RGB 51, 196, 168
  static const Color secondaryColor = Color(0xff33C4A8);

  /// RGB 51, 196, 168
  static const Color scaffoldColor = Color(0xffFCFCFC);

  static const Color appBarColor = Color(0xffFFFFFF);

  static const Color supplierTitleColor = Color(0xff7E7E8C);

  static const Color backgroundColor = Color(0xfff8f8f8);

  ///
  /// Text
  ///

  static const Color mainTextColor = Color(0xff172030);

  static const Color cabinetMenuTextColor = Color(0xff303246);

  static const TextStyle headerTextStyle = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 26, color: mainColorDark);

  static const TextStyle aboutOrganizationTextStyle = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 22, color: mainColorDark);    

  ///
  /// Inputs
  ///
  ///
  ///
  ///
  ///
  // static InputBorder inputWebBorder = OutlineInputBorder(
  //   borderSide: BorderSide(color: Colors.grey.withOpacity(0.6), width: 1),
  //   borderRadius: BorderRadius.circular(8)
  // );

  static InputBorder errorWebBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: 1),
    borderRadius: BorderRadius.circular(8)
  );

  static InputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: mainColor.withOpacity(0.2),
    ),
  );

  static InputBorder inputBorderUnderline = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppStyles.mainColor.withOpacity(0.1),
    ),
  );
  static InputBorder inputBorderOutline = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppStyles.mainColor.withOpacity(0.1),
    ),
    borderRadius: BorderRadius.circular(8)
  );

  static TextStyle inputLabelStyle = TextStyle(
    color: mainColorDark.withOpacity(0.5),
  );

  static TextStyle inputLabelUnderlineStyle = TextStyle(
    fontSize: 18,
    color: AppStyles.mainColorDark.withOpacity(0.6),
  );
  static TextStyle inputLabelOutlineStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: Color(0xFF7E7E8C),
  );

  // static TextStyle inputHintStyle = TextStyle(
  //   color: Color(0xff9D9D9F)
  //   // color: Color(0xff383A51)
  // );

  static const double inputIconSize = 24;
  static TextStyle tableDataTextStyle = const TextStyle(
      fontSize: 13, fontWeight: FontWeight.w400, color: mainTextColor);

  static TextStyle tableHeaderTextStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 11,
    color: mainTextColor
  );    
      
  static const Color inputIconColor = Color(0xff9D9D9F);

  ///
  /// Buttons
  ///

}
