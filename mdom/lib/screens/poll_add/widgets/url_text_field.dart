import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class UrlTextField extends StatelessWidget {
  final TextEditingController controller;

  const UrlTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: 'Ссылка на подробную информацию',
          // hintText: hint,
          counterText: '',
          alignLabelWithHint: true,
          labelStyle: AppStyles.inputLabelUnderlineStyle,
          focusedBorder: AppStyles.inputBorderUnderline,
          enabledBorder: AppStyles.inputBorderUnderline,
          border: AppStyles.inputBorderUnderline,
          isDense: true,
        ),
        validator: (value) {
          try {
            final url = Uri.parse(value ?? '');
            if (!(url.scheme == 'http' ||
                url.scheme == 'https' ||
                url.scheme == '')) throw Exception('invalid url');
            // ignore: avoid_catches_without_on_clauses
          } catch (e) {
            return 'Невалидный url';
          }

          return null;
        },
        // onChanged: (value) {
        //   try {
        //     final date = DateFormat('dd/MM/yyyy').parse(value);
        //     return onChanged?.call(date);
        //   } catch (e) {}
        // },
      );
}
