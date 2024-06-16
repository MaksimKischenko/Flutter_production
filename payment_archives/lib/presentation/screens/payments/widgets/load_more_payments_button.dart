import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class LoadMorePaymentsButton extends StatefulWidget {

  final bool isActive;
  final Function() onTap;

  const LoadMorePaymentsButton({
    required this.onTap,
    this.isActive = true,
  });

  @override
  State<LoadMorePaymentsButton> createState() => _LoadMorePaymentsButtonState();
}

class _LoadMorePaymentsButtonState extends State<LoadMorePaymentsButton> {

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
      color: isFocused? AppStyles.colorGold2 : AppStyles.colorGold,
      disabledColor: AppStyles.mainTextColor.withOpacity(0.5),
      focusColor: AppStyles.colorGold2,
      onPressed: widget.isActive? widget.onTap: null,
      child: const Row(
        children: [
          Icon(Icons.download_outlined, color: AppStyles.whiteColor, size: 16),
          SizedBox(width: 4),
          Text(
            'Загрузить еще',
            style: AppStyles.textStyleWhiteTextButton
          ),
        ],
      ),
    ),
  );
}


