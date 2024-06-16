import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_cabinet_nkfo/styles.dart';

// ignore: must_be_immutable
class AttrLogic extends StatefulWidget {
  final String text;
  bool value;
  final Function(bool)? onChanged;
  final bool editable;
  final EdgeInsets padding;

  AttrLogic({
    required this.text,
    required this.value,
    this.onChanged,
    this.editable = true,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  _AttrLogicState createState() => _AttrLogicState();
}

class _AttrLogicState extends State<AttrLogic> {
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => _onTap(!widget.value),
    behavior: HitTestBehavior.translucent,
    child: Container(
      padding: widget.padding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Checkbox(
            tristate: true,
            splashRadius: 1,
            value: widget.value,
            onChanged: (value) => _onTap(value ?? false),
            activeColor: AppStyles.mainColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.text,
              // style: AppStyles.inputLabelStyle
              style: GoogleFonts.openSans(
                color: AppStyles.mainTextColor
              ),
            ),
          ),
        ],
      ),
    ),
  );

  void _onTap(bool value) {
    if (widget.editable) {
      setState(() {
        widget.value = value;
      });
      widget.onChanged?.call(value);
    }
  }
}