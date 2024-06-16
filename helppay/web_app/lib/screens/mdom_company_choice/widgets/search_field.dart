import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class SearchTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController controller;

  const SearchTextField({
    required this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    autocorrect: false,
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
      hintText: context.t.mobileScreens.mdomCompanyChoise.searchField.hint,
      counterText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelOutlineStyle,
      enabledBorder: AppStyles.inputBorderOutline,
      border: AppStyles.inputBorderOutline,
      isDense: true
    ),
  );
}
