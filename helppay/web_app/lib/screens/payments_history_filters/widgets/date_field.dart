import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/utils.dart';

class DateField extends StatelessWidget {
  final String prefix;
  final TextEditingController controller;
  final String? Function(String)? validator;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function()? onPicked;

  const DateField({
    required this.prefix,
    required this.controller,
    this.validator,
    this.firstDate,
    this.lastDate,
    this.onPicked
  });

  @override
  Widget build(BuildContext context) => Expanded(
    child: Row(
      children: [
        Text(prefix),
        const SizedBox(width: 6),
        Expanded(
          child: TextFormField(
            controller: controller,
            onTap: () => _showDatePicker(context),
            readOnly: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
              fillColor: AppStyles.mainColor.withOpacity(0.1),
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(6)
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset('assets/icon/calendar.svg'),
              ),
              suffixIconConstraints: const BoxConstraints(maxWidth: 34)
            ),
            validator: (value) => validator?.call(value!),
          ),
        )
      ],
    ),
  );

  void _showDatePicker(BuildContext context) {
    Multiplatform.showdatePicker(
      context: context,
      initialDate: controller.text.toDateFormatted(),
      firstDate: firstDate ?? DateTime.now().subtract(const Duration(days: 20000)),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 20000))
    ).then((pickedDate) {
      if (pickedDate != null) {
        final _dueDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
        controller.text = _dueDate.toStringFormatted();
      }
      onPicked?.call();
    });
  }
}