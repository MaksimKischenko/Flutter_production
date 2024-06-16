

import 'package:flutter/material.dart';

mixin AppStyles {
  ///
  /// Colors
  ///

  /// RGB 43, 80, 161
  static const Color mainColor = Color(0xff1E50A8);

  /// RGB 56, 58, 81
  static const Color mainColorDark = Color(0xff383a51);

  /// RGB 51, 196, 168
  static const Color secondaryColor = Color(0xff33C4A8);

  /// RGB 51, 196, 168
  static const Color scaffoldColor = Color(0xffFCFCFC);

  static const Color cardDesignTextColor = Color(0xff383A51);

  ///
  /// Text
  ///

  static const Color mainTextColor = Color(0xff172030);

  static const TextStyle headerTextStyle = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 26, color: mainColorDark);

  static const TextStyle agreementsTextStyle = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 13, color: cardDesignTextColor);

  static const TextStyle agreementsTextStyleBold = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 13, color: cardDesignTextColor);

  static const TextStyle agreementsLinkTextStyle =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: mainColor);

  ///
  /// Inputs
  ///

  static InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: mainColor.withOpacity(0.2)));

  static InputBorder inputBorderUnderline = UnderlineInputBorder(
      borderSide: BorderSide(color: AppStyles.mainColor.withOpacity(0.1)));

  static TextStyle inputLabelStyle =
      TextStyle(color: mainColorDark.withOpacity(0.5));

  static TextStyle prefixTextStyle = const TextStyle(color: Colors.black);

  static TextStyle inputLabelUnderlineStyle = TextStyle(
    fontSize: 18,
    color: AppStyles.mainColorDark.withOpacity(0.6),
  );

  static const double inputIconSize = 24;

  static const Color inputIconColor = Color(0xff9D9D9F);
}
