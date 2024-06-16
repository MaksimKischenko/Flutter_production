import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class SearchAuditLogButton extends StatefulWidget {
  final double widthSize;
  final Function() onTap;
  final String? name;

  const SearchAuditLogButton({
    required this.onTap,
    this.widthSize = 100,
    this.name = 'Поиск',
  });

  @override
  State<SearchAuditLogButton> createState() => _SearchAuditLogButtonState();
}

class _SearchAuditLogButtonState extends State<SearchAuditLogButton> {

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
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),        
      color: isFocused? AppStyles.colorGold2 : AppStyles.colorGold,
      focusColor: AppStyles.colorGold2,
      onPressed:  widget.onTap,
      child: Row(
        children: [
          const Icon(Icons.search, color: AppStyles.whiteColor, size: 16),
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


