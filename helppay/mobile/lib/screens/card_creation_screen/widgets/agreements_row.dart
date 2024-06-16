import 'package:flutter/material.dart';

class AgreementsRow extends StatefulWidget {
  final String text;
  final bool value;
  final Function(bool) onChange;
  const AgreementsRow(
      {required this.onChange, required this.value, required this.text});
  @override
  State<AgreementsRow> createState() => _AgreementsRowState();
}

class _AgreementsRowState extends State<AgreementsRow> {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.text),
          Switch(
            value: widget.value,
            onChanged: widget.onChange,
          ),
        ],
      );
}
