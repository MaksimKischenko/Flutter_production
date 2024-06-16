import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageSubtitle extends StatelessWidget {
  final String text;
  final bool isDevice;

  const PageSubtitle(this.text, this.isDevice);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: GoogleFonts.openSans(
      fontSize: isDevice? 16 : 18,
      fontStyle: FontStyle.normal,
      height: 1.6,
      letterSpacing: 0.01,
      fontWeight: FontWeight.w600,
      color: Color(0xff333333)
    )
  );
}