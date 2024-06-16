import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helppay_payform_app/styles.dart';

class AttrField extends StatelessWidget {
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool editable;
  final bool isDevice;
  final int maxLength;

  const AttrField(
      {this.keyboardType = TextInputType.text,
      this.inputFormatters,
      this.onSaved,
      this.validator,
      this.initialValue,
      required this.maxLength,
      required this.editable,
      required this.isDevice});

  @override
  Widget build(BuildContext context) => TextFormField(
        maxLength: maxLength,
        initialValue: initialValue,
        autocorrect: false,
        cursorWidth: 1,
        readOnly: !editable,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters ?? [],
        // inputFormatters: [LngthLimitingTextInputFormatter()],
        textInputAction: TextInputAction.done,
        cursorColor: AppStyles.mainColor,
        style: TextStyle(
          color: editable
              ? AppStyles.mainTextColor
              : AppStyles.mainTextColor.withOpacity(0.55),
        ),
        decoration: InputDecoration(
          counterText: "",
          alignLabelWithHint: true,
          filled: true,
          isDense: true,
          // fillColor: const Color(0xfff7f7f9),
          labelStyle: TextStyle(
            color: editable
                ? AppStyles.mainTextColor
                : AppStyles.mainTextColor.withOpacity(0.55),
          ),
          fillColor: editable ? Colors.transparent : Color(0xffEBEBEB),
          helperStyle: GoogleFonts.roboto(
              color: Color(0xff767676),
              fontSize: 16,
              fontWeight: FontWeight.w400),
          hintStyle: TextStyle(
            color: editable
                ? AppStyles.mainTextColor
                : AppStyles.mainTextColor.withOpacity(0.55),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffEBEBEB), width: 2),
            borderRadius: BorderRadius.circular(6),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(6)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffEBEBEB), width: 2),
              borderRadius: BorderRadius.circular(6)),
          errorStyle: TextStyle(
            fontSize: isDevice ? 14 : 16,
            fontWeight: FontWeight.w400,
          ),
        ),

        validator: (text) => validator?.call(text),
        onSaved: (email) {
          onSaved?.call(email);
        },
      );
}
