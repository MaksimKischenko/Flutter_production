import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class ParamLogic extends StatefulWidget {
  final String text;
  final bool? value;
  final Function(bool? value) onChanged;
  final bool editable;

  const ParamLogic({
    required this.text,
    required this.value,
    required this.onChanged,
    required this.editable
  });

  @override
  _ParamLogicState createState() => _ParamLogicState();
}

class _ParamLogicState extends State<ParamLogic> {
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        child: Text(
          widget.text,
          style: AppStyles.inputLabelStyle
        ),
      ),
      const SizedBox(width: 8),
      Checkbox(
        tristate: true,
        value: widget.value,
        onChanged: widget.editable ? (value) => widget.onChanged(value) : null,
        activeColor: AppStyles.mainColor,
      )
    ],
  );
}