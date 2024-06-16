import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageTitle extends StatelessWidget {
  final String text;
  final bool isDevice;

  const PageTitle(this.text, this.isDevice);

  @override
  Widget build(BuildContext context) => Text(text,
      style: GoogleFonts.openSans(
          color: const Color(0xff333333),
          fontSize: isDevice ? 16 : 20,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.01,
          height: 1.6,
          fontWeight: FontWeight.w700));
}
