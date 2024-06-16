import 'package:bpc/styles.dart';
import 'package:flutter/cupertino.dart';

class FeatureSwitch extends StatefulWidget {
  final bool value;
  final String text;
  final Function(bool) onChanged;

  const FeatureSwitch({
    required this.value,
    required this.text,
    required this.onChanged
  });

  @override
  _FeatureSwitchState createState() => _FeatureSwitchState();
}

class _FeatureSwitchState extends State<FeatureSwitch> {
  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () => widget.onChanged(!widget.value),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Text(
            widget.text,
            style: AppStyles.inputLabelStyle
          ),
        ),
        const SizedBox(width: 8),
        CupertinoSwitch(
          value: widget.value,
          onChanged: widget.onChanged,
          activeColor: AppStyles.mainColor,
        )
      ],
    ),
  );
}