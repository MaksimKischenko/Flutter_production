import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';

class AttrLogic extends StatefulWidget {
  final String text;
  bool value;
  final Function(bool) onChanged;
  final bool editable;

  AttrLogic({
    required this.text,
    required this.value,
    required this.onChanged,
    required this.editable
  });

  @override
  _AttrLogicState createState() => _AttrLogicState();
}

class _AttrLogicState extends State<AttrLogic> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Text(
            widget.text,
            // style: AppStyles.inputLabelStyle
            style: const TextStyle(
              color: AppStyles.mainTextColor
            ),
          ),
        ),
        const SizedBox(width: 8),
        Checkbox(
          tristate: true,
          value: widget.value,
          onChanged: (value) {
            if (widget.editable) {
              setState(() {
                widget.value = value ?? false;
              });
              widget.onChanged(value ?? false);
            }
          },
          activeColor: AppStyles.mainColor,
        )
      ],
    ),
  );
}