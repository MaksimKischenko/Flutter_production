import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:string_mask/string_mask.dart';

class AccountItem extends StatelessWidget {
  final MdomLoginResponseProductsCurrent item;
  final MdomLoginResponseProductsCurrent? groupValue;
  final Function(MdomLoginResponseProductsCurrent account) onTap;

  final String accountName;
  final String accountNumber;

  AccountItem({
    required this.item,
    required this.groupValue,
    required this.onTap
  }) : accountName = item.params.findByAlias(AliasList.productName)?.evalue ?? '',
      accountNumber = StringMask('UU00 UUUU 0000 0000 0000 0000 0000').apply(item.params.findByAlias(AliasList.number)?.evalue);

  @override
  Widget build(BuildContext context) => RadioListTile<MdomLoginResponseProductsCurrent>(
    onChanged: (account) => onTap(account!),
    value: item,
    groupValue: groupValue,
    title: Container(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
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
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppStyles.mainColorDark
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8)
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
                          color: AppStyles.mainColorDark
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}