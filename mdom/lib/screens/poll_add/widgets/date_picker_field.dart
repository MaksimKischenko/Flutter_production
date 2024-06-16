import 'package:bpc/styles.dart';
import 'package:bpc/utils/utils.dart';
import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final DateTime? initialDate;
  final Function(DateTime value) onChanged;
  final String? Function()? validator;

  const DatePickerField({
    Key? key,
    required this.controller,
    required this.label,
    required this.initialDate,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
    onTap: () => _onTap(context),
    controller: controller,
    autocorrect: false,
    readOnly: true,
    decoration: InputDecoration(
      labelText: label,
      // hintText: hint,
      counterText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelUnderlineStyle,
      focusedBorder: AppStyles.inputBorderUnderline,
      enabledBorder: AppStyles.inputBorderUnderline,
      border: AppStyles.inputBorderUnderline,
      isDense: true,
      suffixIcon: Icon(
        Icons.date_range_rounded,
        color: AppStyles.mainTextColor.withOpacity(.2),
      )
    ),
    validator: (value) => validator?.call(),
    // onChanged: (value) {
    //   try {
    //     final date = DateFormat('dd/MM/yyyy').parse(value);
    //     return onChanged?.call(date);
    //   } catch (e) {}
    // },
  );

  // ignore: avoid_void_async
  void _onTap(BuildContext context) async {
    final value = await Multiplatform.showdatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 20000)),
      lastDate: DateTime.now().add(const Duration(days: 20000))
    );

    if (value != null) {
      onChanged(value);
    }
  }
}