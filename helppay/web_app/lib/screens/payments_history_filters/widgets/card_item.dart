import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:string_mask/string_mask.dart';

// ignore: must_be_immutable
class CardItem extends StatelessWidget {
  final MdomLoginResponseProductsCurrent item;
  final MdomLoginResponseProductsCurrent? groupValue;
  final Function(MdomLoginResponseProductsCurrent card) onTap;

  late String cardName;
  late String cardNumber;
  late String cardExpirationDate;
  late CardIssuerType issuer;

  late String issuerLogo;

  CardItem({
    required this.item,
    required this.groupValue,
    required this.onTap,
  }) {
    cardName = item.params.findByAlias(AliasList.productName)?.evalue ?? '';
    cardNumber = StringMask('0000 0000 0000 0000')
        .apply(item.params.findByAlias(AliasList.number)?.evalue);

    cardExpirationDate = StringMask('90/90')
        .apply(item.params.findByAlias(AliasList.expirationDate)?.evalue);

    issuer = CardIssuerTypeExtenson.fromCardNumber(cardNumber);

    issuerLogo = issuer.logo();
  }

  @override
  Widget build(BuildContext context) =>
      RadioListTile<MdomLoginResponseProductsCurrent>(
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
                            cardName,
                            style: const TextStyle(
                                fontSize: 16, color: AppStyles.mainColorDark),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          cardNumber,
                          style: const TextStyle(
                              fontSize: 16, color: AppStyles.mainColorDark),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 4),
                            child: SvgPicture.asset(
                              'assets/icon/$issuerLogo.svg',
                              width: 18,
                            ),
                          ),
                        ),
                        Text(
                          cardExpirationDate,
                          style: const TextStyle(
                              fontSize: 16, color: AppStyles.mainColorDark),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
