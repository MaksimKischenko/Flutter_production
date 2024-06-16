import 'package:flutter/cupertino.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class SmsSwitch extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;

  const SmsSwitch({
    required this.value,
    required this.onChanged
  });

  @override
  _SmsSwitchState createState() => _SmsSwitchState();
}

class _SmsSwitchState extends State<SmsSwitch> {
  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () => widget.onChanged(!widget.value),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Text(
            context.t.mobileScreens.registration.smsSwitch.tilte,
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