import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FioField extends StatefulWidget {
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSaved;

  const FioField({
    this.focusNode,
    this.onFieldSubmitted,
    this.onSaved,
  });

  @override
  State<FioField> createState() => _FioFieldState();
}

class _FioFieldState extends State<FioField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: _controller,
        autocorrect: false,
        // keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          // FilteringTextInputFormatter.allow(RegExp('[\s]')),ss
          FilteringTextInputFormatter.deny(RegExp('[0-9]'))
          // [\u0430-\u044F\u0410-\u042F]|\u0020
        ],
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          labelText: 'ФИО',
          alignLabelWithHint: false,
          labelStyle: AppStyles.inputLabelStyle,
          enabledBorder: AppStyles.inputBorder,
          border: AppStyles.inputBorder,
          isDense: true,
        ),
        validator: (fio) {
          if (fio?.isEmpty ?? true) {
            return 'Введите ФИО';
          }
          if (fio!.length > 90) {
            return 'Неверный формат ФИО';
          }
          return null;
        },
        onFieldSubmitted: (fio) => widget.onFieldSubmitted?.call(fio),
        onSaved: (fio) => widget.onSaved?.call(fio!),
      );
}
