import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';


// ignore: must_be_immutable
class SelectBox extends StatefulWidget {
  bool value;
  final Function(bool)? onChanged;
  final bool editable;
  final EdgeInsets padding;
  final Color borderSideColor;

  SelectBox({
    this.value = false,
    this.onChanged,
    this.editable = true,
    this.borderSideColor = AppStyles.colorGrey,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  _SelectBoxState createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  @override
  Widget build(BuildContext context) => Container(
    padding: widget.padding,
    child: GestureDetector(
      onTap: () => _onTap(!widget.value),
      behavior: HitTestBehavior.translucent,          
      child: SizedBox(
        width: 20,
        height: 20,            
        child: Checkbox(
          side: BorderSide(
            color: widget.editable? widget.borderSideColor: Colors.grey.shade300,
          ),
          tristate: true,
          splashRadius: 1,
          value: widget.value,
          onChanged: (value) => _onTap(value ?? false),
          activeColor: AppStyles.colorDark3,
        ),
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