import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin AppStyles {
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color colorBlue = Color(0xff0A457D);
  static const Color colorBlue2 = Color(0xff0261BB);
  static const Color colorBlue3 = Color(0xffEDF6FF);

  static const Color colorPurple = Colors.deepPurple;
  
  static const Color colorGold = Color(0xffB19D68);
  static const Color colorGold2 = Color(0xffD7BE7C);
  
  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color colorWhite2 = Color(0xffF1F2F3);
  static const Color colorWhite3 = Color(0xffE8EBED);
  static final Color colorWhite4 = const Color(0xffFFFFFF).withOpacity(0.55);

  static const Color colorBlack = Color(0xff000000);
  static const Color colorBlack2 = Color(0xff222222);

  static const Color colorDark = Color(0xff2E3647);
  static const Color colorDark2 = Color(0xff232B3C);
  static const Color colorDark3 = Color(0xff364157);

  static const Color colorGrey = Color(0xff83868D);
  static const Color colorGrey2 = Color(0xff9FA2AA);
  static const Color colorGrey3 = Color(0xffD8DDE1); 
  static const Color colorGrey4 = Color(0xffF1F2F3);

  static const Color errorColor = CupertinoColors.systemRed;
  static Color successColor = CupertinoColors.systemGreen.withOpacity(0.7);
  static Color infoColor = CupertinoColors.systemYellow.withOpacity(0.7);  
  static const Color mainColor = colorDark;
  static const Color mainTextColor = Color(0xff172030);
  static const Color colorSelected = whiteColor;
  static final Color colorUnSelected = whiteColor.withOpacity(0.6);

  static const EdgeInsetsGeometry contentPadding = EdgeInsets.symmetric(vertical: 8, horizontal: 8);

  static const primarySwatch = MaterialColor(0xff364157, {
    50: colorDark,
    100: colorDark2,
    200: colorDark3,
    300: colorDark3,
    400: colorDark3,
    500: colorDark3,
    600: colorDark3,
    700: colorDark3,
    800: colorDark3,
    900: colorDark3
  });

  static const TextStyle textStyleHint = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: colorGrey,
  );

  static TextStyle menuElementUnSelected = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: colorWhite4
  );

  static TextStyle menuElementSelected = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: colorWhite
  );


  static TextStyle appBarTitleStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    fontStyle: FontStyle.normal,
    color: colorBlack
  );

  static TextStyle tableHeaderTextStyle = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: whiteColor
  );

   static TextStyle infoTextStyle = const TextStyle(
    fontWeight: FontWeight.w600, 
    fontSize: 14, 
    color: mainTextColor
  ); 

  static TextStyle inputLabelStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: colorDark,
  );

  static TextStyle headerStyle = const TextStyle(
    fontWeight: FontWeight.w600, 
    fontSize: 24, 
    color: colorDark
  );

  static TextStyle headerTextStyle = const TextStyle(
    fontWeight: FontWeight.w600, 
    fontSize: 18, 
    color: mainTextColor
  );

  static TextStyle authTitleFieldStyle = const TextStyle(
    color: whiteColor, 
    fontSize: 80, 
    fontWeight: FontWeight.w500
  );

  static const TextStyle authTitleFieldLoginMenu = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    fontStyle: FontStyle.normal,
    color: colorBlack
  );

  static const TextStyle textStyleWhiteTextButton = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: whiteColor
  );


  static const TextStyle textStyleWhiteNavigationButton = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: colorWhite
  );


  static const TextStyle textStyleBlackTextButton = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: colorBlack
  );

  static const TextStyle textStyleBlackInfoCount = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: colorBlack,
  );

  static const TextStyle textStyleInfoTotal = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: colorGrey2,
  );


  static const TextStyle textStyleBlackTextFieldsContent = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 2,
    color: colorBlack,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle textStyleBlueTextButton = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: colorBlue2
  );



  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(4));



  static const InputBorder inputUnfocusBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: mainColor,
        width: 0.5,
      ),
      borderRadius: borderRadius);

  static const InputBorder inputFocusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: mainColor, width: 3),
      borderRadius: borderRadius);

  static const InputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: errorColor, width: 1),
      borderRadius: borderRadius);

  ///
  /// Buttons
  ///
  static TextStyle buttonTextStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: whiteColor);

  static TextStyle checkBoxTextStyle = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 14, color: mainTextColor);


  static TextStyle tableDataTextStyle = const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: mainTextColor);
}


