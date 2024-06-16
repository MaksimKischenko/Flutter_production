import 'package:flutter/cupertino.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

// ignore: must_be_immutable
class StatusSwitcher extends StatefulWidget {
  final String text;
  bool value;
  final Function(bool)? onChanged;
  final Color activeColor;

   StatusSwitcher({
    Key? key,
    required this.text,
    required this.value,
    this.onChanged,
    this.activeColor = AppStyles.colorDark3
  }) : super(key: key);

  @override
  State<StatusSwitcher> createState() => _StatusSwitcherState();
}

class _StatusSwitcherState extends State<StatusSwitcher> {
  @override
  Widget build(BuildContext context) => Row(
      children: [
        SelectBox(
          value: widget.value,
          onChanged: _onTap,
        ),
        // Transform.scale(
        //   scale: 0.7,
        //   child: SizedBox(
        //     width: 40,
        //     child: CupertinoSwitch(
        //       value: widget.value,
        //       activeColor: widget.activeColor,
        //       onChanged: _onTap,
        //     ),
        //   ),
        // ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            widget.text,
            style: AppStyles.checkBoxTextStyle
          ),
        ),            
      ],
    );

  void _onTap(bool value) {
    setState(() {
      widget.value = value;
    });
    widget.onChanged?.call(value);
  }
}