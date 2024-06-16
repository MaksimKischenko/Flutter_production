import 'package:flutter/material.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/styles.dart';


class ChangeGolorButton extends StatefulWidget {

  final bool isActive;
  final Function() onTap;
  final String? name;

  const ChangeGolorButton({
    required this.onTap,
    this.isActive = true,
    this.name = 'Добавить',
  });

  @override
  State<ChangeGolorButton> createState() => _ChangeGolorButtonState();
}

class _ChangeGolorButtonState extends State<ChangeGolorButton> {

  bool isFocused = false; 
  final Map<String, Icon> icons = ActionButtonType.icons;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) {
      setState(() {
        isFocused = true;
      }); 
    },
    onExit: (_) {
      setState(() {
        isFocused = false;
      }); 
    } ,    
    child: MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),        
      color: isFocused? AppStyles.colorGold2 : AppStyles.colorGold,
      focusColor: AppStyles.colorGold2,
      onPressed: widget.isActive? widget.onTap: null,
      child: Row(
        children: [
          icons['${widget.name}'] ?? const Icon(null),
          const SizedBox(width: 4),
          Text(
            '${widget.name}',
            style: AppStyles.textStyleWhiteTextButton
          ),
        ],
      ),
    ),
  );
}


