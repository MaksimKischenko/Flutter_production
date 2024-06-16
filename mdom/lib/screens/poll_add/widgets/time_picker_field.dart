import 'package:bpc/styles.dart';
import 'package:bpc/utils/utils.dart';
import 'package:flutter/material.dart';

class TimePickerField extends StatelessWidget {
  final TextEditingController controller;
  final DateTime? initialDate;
  final Function(DateTime value) onChanged;
  final String? Function()? validator;

  const TimePickerField({
    Key? key,
    required this.controller,
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
      labelText: '',
      // hintText: hint,
      counterText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelUnderlineStyle,
      focusedBorder: AppStyles.inputBorderUnderline,
      enabledBorder: AppStyles.inputBorderUnderline,
      border: AppStyles.inputBorderUnderline,
      isDense: true,
      suffixIcon: Icon(
        Icons.access_time,
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
    final value = await Multiplatform.showOnlyTimePicker(
      context: context,
      initialTime: initialDate ?? DateTime.now(),
    );

    if (value != null) {
      onChanged(value);
    }
  }
}