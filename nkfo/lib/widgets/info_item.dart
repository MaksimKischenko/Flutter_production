import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_ui/responsive_ui.dart';

class InfoItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final int colL;

  const InfoItem({
    required this.title,
    required this.subtitle,
    this.colL = 6,
  });

  @override
  Widget build(BuildContext context) => Div(
    colL: colL,
    colM: 12,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.openSans(
              fontSize: 16,
            )
          ),
          const SizedBox(height: 8),
          Text(
            subtitle ?? '',
            style: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.bold
            )
          )
        ],
      )
    ),
  );
}