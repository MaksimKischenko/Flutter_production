import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class FioField extends StatefulWidget {
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSaved;

  const FioField({this.focusNode, this.onFieldSubmitted, this.onSaved});

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
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.deny(
            RegExp('[0-9]'),
          )
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
            return context.t.widgets.fioField.errors.empty;
          }
          if (fio!.length > 90) {
            return context.t.widgets.fioField.errors.incorrect;
          }
          return null;
        },
        onFieldSubmitted: (fio) => widget.onFieldSubmitted?.call(fio),
        onSaved: (fio) => widget.onSaved?.call(fio!),
      );
}
