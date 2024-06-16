import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:string_mask/string_mask.dart';

class AccountItem extends StatelessWidget {
  final MdomLoginResponseProductsCurrent item;

  final String accountName;
  final String accountNumber;

  AccountItem(this.item) :
    accountName = item.params.findByAlias(AliasList.productName)?.evalue ?? '',
    accountNumber = StringMask('UU00 UUUU 0000 0000 0000 0000 0000').apply(item.params.findByAlias(AliasList.number)?.evalue);
  

  @override
  Widget build(BuildContext context) => Container(
    // margin: EdgeInsets.all(4),
    margin: const EdgeInsets.fromLTRB(4, 24, 4, 24),
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    decoration: BoxDecoration(
      color: AppStyles.secondaryColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: AppStyles.secondaryColor.withOpacity(0.2),
          blurRadius: 20,
          offset: const Offset(0, 4)
        )
      ]
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Text(
                accountName,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white
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
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
      ],
    ),
  );
}