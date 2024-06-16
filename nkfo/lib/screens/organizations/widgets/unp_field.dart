import 'package:flutter/material.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class UnpField extends StatelessWidget {
  final TextEditingController? controller;

  const UnpField({
    this.controller
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 300,
    child: TextField(
      controller: controller,
      autocorrect: false,  
      cursorColor: AppStyles.mainColor,
      textInputAction: TextInputAction.done,
      style: const TextStyle(
        color: AppStyles.mainTextColor
      ),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        filled: true,
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppStyles.mainColor, width: 1),
          borderRadius: BorderRadius.circular(5)
        ),
        fillColor: AppStyles.mainTextColor.withOpacity(0.03),
        labelText: 'УНП',
        labelStyle: AppStyles.labelTextFieldStyle,
        hintStyle: const TextStyle(
          color: AppStyles.mainTextColor
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5)
        ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide:  BorderSide(color: AppStyles.mainColor.withOpacity(0.4), width: 1),
        //   borderRadius: BorderRadius.circular(5)
        // )
      ),
    ),
  );
}