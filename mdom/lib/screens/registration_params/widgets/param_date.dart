import 'package:bpc/styles.dart';
import 'package:bpc/utils/utils.dart';
import 'package:flutter/material.dart';

class ParamDate extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final String? initialValue;
  final Function(String value) onSaved;
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
    _dateController.dispose();
    super.dispose();
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
          labelStyle: AppStyles.inputLabelStyle,
          enabledBorder: AppStyles.inputBorder,
          border: AppStyles.inputBorder,
          isDense: true,
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) return 'Некорректная дата';
          return null;
        },
        onSaved: (value) => widget.onSaved(value!),
      );

  // ignore: avoid_void_async
  void _showDatePicker() async {
    final value = await Multiplatform.showdatePicker(
      context: context,
      initialDate: _dateController.text.toDateFormatted(),
      firstDate: DateTime.now().subtract(
        const Duration(days: 20000),
      ),
      lastDate: DateTime.now().add(
        const Duration(days: 20000),
      ),
    );
    if (value != null) {
      final _dueDate = DateTime(value.year, value.month, value.day);
      _dateController.text = _dueDate.toStringFormatted();
    }
  }
}
