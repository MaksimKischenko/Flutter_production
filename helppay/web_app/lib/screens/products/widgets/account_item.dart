import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:string_mask/string_mask.dart';

class AccountItem extends StatelessWidget {
  final MdomLoginResponseProductsCurrent account;
  final Function(MdomLoginResponseProductsCurrent account) onTap;
  final bool isMain;
  final EdgeInsetsGeometry margin;

  final String accountName;
  final String accountNumber;

  final Color color;
  final Color shadowColor;
  final Color textColor;

  AccountItem({
    required this.account,
    required this.onTap,
    this.isMain = false,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  }) : color = isMain
          ? AppStyles.secondaryColor
          : Colors.white,
      shadowColor = isMain
          ? AppStyles.secondaryColor.withOpacity(0.2)
          : AppStyles.mainColor.withOpacity(0.1),
      textColor = isMain
          ? Colors.white
          : AppStyles.mainColorDark,
      accountName = account.params.findByAlias(AliasList.productName)?.evalue ?? '',
      accountNumber = StringMask('UU00 UUUU 0000 0000 0000 0000 0000').apply(account.params.findByAlias(AliasList.number)?.evalue);
  
  
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => onTap(account),
    child: Container(
      margin: margin,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 4)
          )
        ]
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Text(
                        accountName,
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        accountNumber,
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),         
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 6),
          const Icon(
            CupertinoIcons.chevron_right,
            color: Color(0xffC7C7CC),
            size: 18,
          )             
        ],
      ),
    ),
  );
}