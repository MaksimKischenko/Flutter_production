import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeButton extends StatelessWidget {
  final SizingInformation sizingInformation;
  final VoidCallback? onTap;

  const HomeButton({
    Key? key,
    required this.sizingInformation,
    required this.onTap,
  }) : super(key: key);

  bool get isDevice => sizingInformation.isMobile || sizingInformation.isTablet;

  @override
  Widget build(BuildContext context) => MaterialButton(
        padding: EdgeInsets.symmetric(
          horizontal: isDevice ? 17 : 24,
          vertical: isDevice ? 8 : 12,
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: onTap == null
                  ? AppStyles.mainTextColor.withOpacity(.3)
                  : AppStyles.mainColor,
            ),
            borderRadius: BorderRadius.circular(6)),
        onPressed: onTap,
        child: Center(
          child: FittedBox(
            child: Text(
              'Вернуться на сайт',
              maxLines: 1,
              style: GoogleFonts.openSans(
                  textBaseline: TextBaseline.ideographic,
                  fontSize: isDevice ? 12 : 16,
                  // height: isDevice ? 12 / 18 : 16 / 24,
                  fontWeight: FontWeight.w400,
                  color: onTap == null
                      ? AppStyles.mainTextColor.withOpacity(.3)
                      : AppStyles.mainColor,
                  wordSpacing: 0.01),
            ),
          ),
        ),
      );
}
