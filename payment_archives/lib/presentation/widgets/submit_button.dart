import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';


class SubmitButton extends StatefulWidget {
  
  final bool isActive;
  final double widthSize;
  final Function() onTap;
  final String? name;
    
  const SubmitButton({
    required this.onTap,
    this.isActive = true,
    this.widthSize = 140,
    this.name = 'Добавить',
  });

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {

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
    child: SizedBox(
      width: widget.widthSize,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), 
        disabledColor: AppStyles.mainTextColor.withOpacity(0.5),
        color: isFocused? AppStyles.colorDark : AppStyles.colorDark3,
        onPressed: widget.isActive? widget.onTap: null,
        child: Text(
          '${widget.name}',
          style: AppStyles.textStyleWhiteTextButton
        ),
      ),
    ),
  );
}
