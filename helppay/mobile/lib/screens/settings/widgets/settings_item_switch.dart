import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';

class SettingsItemSwitch extends StatefulWidget {
  final String text;
  final bool value;
  final Function(bool) onChanged;

  const SettingsItemSwitch({
    required this.text,
    required this.value,
    required this.onChanged
  });

  @override
  _SettingsItemSwitchState createState() => _SettingsItemSwitchState();
}

class _SettingsItemSwitchState extends State<SettingsItemSwitch> {
  @override
  Widget build(BuildContext context) => InkWell(
      onTap: () => widget.onChanged(!widget.value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Expanded(
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Color(0xff383A51),
                  fontSize: 18
                ),
              ),
            ),
            const SizedBox(height: 8),
            CupertinoSwitch(
              value: widget.value,
              activeColor: AppStyles.mainColor,
              onChanged: widget.onChanged,
            )
          ],
        ),
      ),
    );
}