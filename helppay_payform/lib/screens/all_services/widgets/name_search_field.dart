import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';

class NameSearchField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;
  final bool isSearchButtonVisible;
  final Function(String newValue) onSearchTap;

  const NameSearchField({
    Key? key,
    required this.controller,
    required this.maxLength,
    required this.isSearchButtonVisible,
    required this.onSearchTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    // color: Colors.red,
    constraints: const BoxConstraints(
      maxWidth: 400
    ),
    child: TextField(
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        isDense: true,
        // isCollapsed: true,
        // contentPadding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 14),
        filled: true,
        fillColor: const Color(0xffF1F3F4),
        labelText: 'Наименование услуги',
        labelStyle: const TextStyle(
          color: Color(0xffA2A9B1),
          fontSize: 16
        ),
        counterText: '',
        suffixIcon: isSearchButtonVisible ? GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => controller.text.isNotEmpty ? onSearchTap(controller.text) : null,
          child: Container(
            decoration: const BoxDecoration(
              color: AppStyles.mainColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4)
              )
            ),
            child: const Icon(
              Icons.search_outlined,
              size: 18,
              color: Colors.white,
            )
          ),
        ): null,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffF1F3F4),
            width: 1
          ),
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffF1F3F4),
            width: 1
          ),
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffF1F3F4),
            width: 1
          ),
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
      ),
    ),
  );
}
