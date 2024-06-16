import 'package:flutter/material.dart';
import 'package:helppay_web_app/styles.dart';


// ignore: must_be_immutable
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
      children: [
        Expanded(
          child: Text(
            widget.text,
            // style: AppStyles.inputLabelStyle
            style: const TextStyle(
              color: AppStyles.mainColorDark
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