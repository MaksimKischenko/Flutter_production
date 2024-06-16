import 'package:flutter/material.dart';
import 'package:kpm_fl/styles.dart';
import 'package:kpm_fl/utils/utils.dart';

class AttrDate extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final String initialValue;
  final Function(String?) onSaved;
  final bool editable;
  final String? dateFormat;

  const AttrDate({
    Key? key,
    required this.labelText,
    this.hintText,
    this.initialValue = '',
    required this.onSaved,
    required this.editable,
    required this.dateFormat
  }): super(key: key);

  @override
  _AttrDateState createState() => _AttrDateState();
}

class _AttrDateState extends State<AttrDate> {

  TextEditingController? _dateController;
  
  @override
  void initState() {
    super.initState();

    _dateController = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: _dateController,
    onTap: () {
      if (widget.editable) _showDatePicker();
    },
    readOnly: true,
    style: TextStyle(
      color: widget.editable
        ? AppStyles.mainTextColor
        : AppStyles.mainTextColor.withOpacity(0.55),
    ),
    decoration: InputDecoration(
      alignLabelWithHint: true,
      // filled: true,
      isDense: true,
      // fillColor: const Color(0xfff7f7f9),
      labelText: widget.labelText,
      labelStyle: TextStyle(
        color: widget.editable
          ? AppStyles.mainTextColor
          : AppStyles.mainTextColor.withOpacity(0.55),
      ),
      helperText: widget.hintText,
      hintStyle: TextStyle(
        color: widget.editable
          ? AppStyles.mainTextColor
          : AppStyles.mainTextColor.withOpacity(0.55),
      ),
      border: AppStyles.inputBorder,
      focusedBorder: AppStyles.inputBorderFocused,
      enabledBorder: AppStyles.inputBorderEnabled,
    ),
    validator: (value) {
      if (value?.isEmpty ?? true) return 'Некорректная дата';
      return null;
    },
    onSaved: (value) {
      widget.onSaved(value);
    },
  );

  //TODO: remove
  // ignore: avoid_void_async
  void _showDatePicker() async {
    final value = await Multiplatform.showdatePicker(
      context: context,
      initialDate: _dateController?.text.toDateFormatted() ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 20000)),
      lastDate: DateTime.now().add(const Duration(days: 20000))
    );

    if (value != null) {
      final _dueDate = DateTime(value.year, value.month, value.day);
      // TODO: change this format in DB
      final dateFormat = widget.dateFormat == 'MMYY' ? 'MMyy' : widget.dateFormat;
      _dateController?.text = _dueDate.toStringFormatted(format: dateFormat);
    }
  }
}