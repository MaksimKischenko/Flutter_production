import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';

class AttrDropdown extends StatefulWidget {
  final List<String?> items;
  final String? initialValue;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final bool editable;

  const AttrDropdown({
    required this.items,
    required this.initialValue,
    this.onSaved,
    this.validator,
    required this.labelText,
    required this.hintText,
    this.editable = true
  });

  @override
  _AttrDropdownState createState() => _AttrDropdownState();
}

class _AttrDropdownState extends State<AttrDropdown> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.text = widget.initialValue ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: _controller,
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
      hintStyle: TextStyle(
        color: widget.editable
          ? AppStyles.mainTextColor
          : AppStyles.mainTextColor.withOpacity(0.55),
      ),
      border: AppStyles.inputBorder,
      focusedBorder: AppStyles.inputBorderFocused,
      enabledBorder: AppStyles.inputBorderEnabled,
      suffixIcon: widget.editable
      ? PopupMenuButton<String>(
        tooltip: widget.hintText,
        onSelected: (value) {
          _controller.text = value;
        },
        itemBuilder: (BuildContext context) => widget.items.map((e) => PopupMenuItem(
          value: e,
          child: Text(
            e ?? 'item',
            style: TextStyle(
              fontWeight: _controller.text == e
                ? FontWeight.bold
                : FontWeight.normal
            ),
          ),
        )).toList(),
        child: const Icon(CupertinoIcons.chevron_down),
      )
      : Container(),
    ),
    validator: (value) => widget.validator?.call(value),
    onSaved: (email) => widget.onSaved?.call(email),
  );
}