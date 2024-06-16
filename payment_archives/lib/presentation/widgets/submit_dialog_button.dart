import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';


class SubmitDialogButton extends StatefulWidget {
  
  final bool isActive;
  final double widthSize;
  final Function() onTap;
  final String? name;
    
  const SubmitDialogButton({
    required this.onTap,
    this.isActive = true,
    this.widthSize = 140,
    this.name = '',
  });

  @override
  State<SubmitDialogButton> createState() => _SubmitDialogButtonState();
}

class _SubmitDialogButtonState extends State<SubmitDialogButton> {

  bool isFocused = false; 

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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), 
      disabledColor: AppStyles.mainTextColor.withOpacity(0.5),
      color: isFocused? AppStyles.colorGold2 : AppStyles.colorGold,
      onPressed: widget.isActive? widget.onTap: null,
      child: Text(
        '${widget.name}',
        style: AppStyles.textStyleWhiteTextButton
      ),
    ),
  );
}
