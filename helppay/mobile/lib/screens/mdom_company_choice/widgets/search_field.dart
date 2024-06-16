import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class SearchTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController controller;

  const SearchTextField({
    required this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        autocorrect: false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        maxLength: 32,
        focusNode: focusNode,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black.withOpacity(0.35),
              size: 22,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 25,
            ),
            hintText:
                context.t.mobileScreens.mdomCompanyChoise.searchField.hint,
            counterText: '',
            alignLabelWithHint: true,
            labelStyle: TextStyle(
                fontSize: 16,
                color: AppStyles.mainColorDark.withOpacity(0.6),
                fontWeight: FontWeight.normal),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    // color: AppStyles.mainColorDark.withOpacity(0.3)
                    color: Colors.transparent)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent)),
            fillColor: AppStyles.mainColorDark.withOpacity(0.1),
            filled: true,
            isDense: true),
      );
}
