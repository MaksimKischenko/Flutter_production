import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/utils.dart';

class ParamDate extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final String? initialValue;
  final Function(String) onSaved;
  final bool editable;

  const ParamDate({
    required this.labelText,
    this.hintText,
    this.initialValue,
    required this.onSaved,
    required this.editable,
  });

  @override
  _ParamDateState createState() => _ParamDateState();
}

class _ParamDateState extends State<ParamDate> {
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();

    _dateController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: _dateController,
        onTap: () {
          if (widget.editable) _showDatePicker();
        },
        readOnly: true,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          alignLabelWithHint: true,
          labelStyle: AppStyles.inputLabelUnderlineStyle,
          enabledBorder: AppStyles.inputBorderUnderline,
          border: AppStyles.inputBorderUnderline,
          isDense: true,
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) return 'Некорректная дата';
          return null;
        },
        onSaved: (value) => widget.onSaved(value!),
      );

  void _showDatePicker() {
    Multiplatform.showdatePicker(
      context: context,
      initialDate: _dateController.text.toDateFormatted(),
      firstDate: DateTime.now().subtract(const Duration(days: 20000)),
      lastDate: DateTime.now().add(const Duration(days: 20000)),
    ).then((pickedDate) {
      if (pickedDate != null) {
        final _dueDate =
            DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
        _dateController.text = _dueDate.toStringFormatted();
      }
    });
  }
}
