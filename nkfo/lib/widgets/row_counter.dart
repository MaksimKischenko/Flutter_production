import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';

class RowCounter extends StatelessWidget {
  final int value;

  const RowCounter(this.value);

  @override
  Widget build(BuildContext context) => Container(
    width: double.maxFinite,
    color: AppStyles.mainColor.withOpacity(0.8),
    padding: const EdgeInsets.symmetric(
        horizontal: 16, vertical: 8),
    child: Text(
      'Всего $value ${value.plural("запись", "записи", "записей")}.',
      style: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: const Color(0xffFFFFFF)
      )
    )
  );
}