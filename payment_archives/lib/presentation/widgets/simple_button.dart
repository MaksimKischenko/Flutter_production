import 'package:flutter/material.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/styles.dart';


class SimpleButton extends StatefulWidget {

  final bool isActive;
  final Function() onTap;
  final String? name;

  const SimpleButton({
    required this.onTap,
    this.isActive = true,
    this.name = '',
  });

  @override
  State<SimpleButton> createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {

  final Map<String, Icon> icons = ActionButtonType.icons;

  @override
  Widget build(BuildContext context) => SizedBox(
    child: MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),     
      shape: Border.all(
        color: AppStyles.colorGrey3
      ),
      onPressed: widget.isActive? widget.onTap: null,
      child: Row(
        children: [
          icons['${widget.name}'] ?? const Icon(null),
          const SizedBox(width: 4),
          Text(
            '${widget.name}',
            style: AppStyles.textStyleBlackTextButton
          ),
        ],
      ),
    ),
  );
}


