import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpm_fl/styles.dart';

class AttrField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String labelText;
  final String? hintText;
  final String? initialValue;
  final int maxLength;
  final bool editable;
  final VoidCallback? onTap;
  final ValueNotifier<bool> keyboardVisibility;
  final Function(bool isVisible) onKeyboardDisplayTap;

  AttrField({
    Key? key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onSaved,
    this.validator,
    required this.labelText,
    required this.hintText,
    this.initialValue,
    required this.maxLength,
    required this.editable,
    this.onTap,
    required this.keyboardVisibility,
    required this.onKeyboardDisplayTap
  }) : super(key: key) {
    if (initialValue != null) {
      controller.value = TextEditingValue(text: initialValue!);
    } else {
      controller.clear();
    }
    controller.addListener(() {
      final value = controller.text;
      if (value.length > maxLength) {
        controller.value = TextEditingValue(text: value.substring(0, maxLength));
      }
    });
  }

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            maxLength: maxLength,
            controller: controller,
            // initialValue: initialValue,
            autocorrect: false,
            onTap: () => editable ? onTap?.call() : null,
            showCursor: true,
            // readOnly: !editable,
            readOnly: true,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters ?? [],
            // inputFormatters: [LngthLimitingTextInputFormatter()],
            textInputAction: TextInputAction.done,
            style: TextStyle(
              color: editable
                ? AppStyles.mainTextColor
                : AppStyles.mainTextColor.withOpacity(0.55),
            ),
            decoration: InputDecoration(
              counterText: maxLength == 0 || !editable
                  ? ''
                  : 'до $maxLength символов',
              alignLabelWithHint: true,
              // filled: true,
              isDense: true,
              // fillColor: const Color(0xfff7f7f9),
              labelText: labelText,
              labelStyle: TextStyle(
                color: editable
                  ? AppStyles.mainTextColor
                  : AppStyles.mainTextColor.withOpacity(0.55),
              ),
              helperText: hintText,
              hintStyle: TextStyle(
                color: editable
                  ? AppStyles.mainTextColor
                  : AppStyles.mainTextColor.withOpacity(0.55),
              ),
              border: AppStyles.inputBorder,
              focusedBorder: AppStyles.inputBorderFocused,
              enabledBorder: AppStyles.inputBorderEnabled
            ),
            validator: (text) => validator?.call(text),
            onSaved: (email) {
              onSaved?.call(email);
            },
          ),
        ),
        const SizedBox(width: 8),
        ValueListenableBuilder<bool>(
          valueListenable: keyboardVisibility,
          builder: (context, curentValue, child) => InkWell(
            // hoverColor: Colors.red,
            onTap: () => onKeyboardDisplayTap(!curentValue),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppStyles.mainColor,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Icon(
                curentValue
                    ? Icons.keyboard_hide
                    : Icons.keyboard,
                color: Colors.white,
                // size: 22,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}