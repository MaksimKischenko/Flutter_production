import 'package:flutter/material.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class TextSearchField extends StatelessWidget {
  final TextEditingController? controller;

  const TextSearchField({
    this.controller
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 300,
    child: TextField(
      autocorrect: false,  
      textInputAction: TextInputAction.done,
      style: const TextStyle(
        color: AppStyles.mainTextColor
      ),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        filled: true,
        isDense: true,
        fillColor: const Color(0xfff7f7f9),
        labelText: 'Текст',
        labelStyle: AppStyles.labelTextFieldStyle,
        hintStyle: const TextStyle(
          color: AppStyles.mainTextColor
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10)
        )
      ),
    ),
  );
}