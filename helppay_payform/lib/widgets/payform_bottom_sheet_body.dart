import 'package:flutter/material.dart';
import 'package:helppay_payform_app/models/models.dart';

class PayformBottomSheetBody extends StatelessWidget {
  final Widget child;
  final DeviceSize deviceSize;

  const PayformBottomSheetBody({
    Key? key,
    required this.child,
    required this.deviceSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double horizontalPaddingValue;

    switch (deviceSize) {
      case DeviceSize.small:
        horizontalPaddingValue = 16;
        break;
      case DeviceSize.medium:
        horizontalPaddingValue = 32;
        break;
      case DeviceSize.large:
        horizontalPaddingValue = 335;
        break;
    }
    return SizedBox(
      height: 84,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.blue[100]?.withOpacity(.1)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPaddingValue,
            vertical: 18,
          ),
          child: child,
        ),
      ),
    );
  }
}
