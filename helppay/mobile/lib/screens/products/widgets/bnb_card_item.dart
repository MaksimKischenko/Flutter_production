import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:string_mask/string_mask.dart';

// ignore: must_be_immutable
class BNDCardItem extends StatelessWidget {
  final MdomLoginResponseProductsCurrent card;
  // final Function(MdomLoginResponseProductsCurrent card) onTap;
  final bool isMain;
  final EdgeInsetsGeometry margin;

  late String cardName;
  late String cardNumber;
  late String cardExpirationDate;
  late CardIssuerType issuer;

  final Color color;
  final Color shadowColor;
  final Color textColor;
  late String issuerLogo;

  BNDCardItem(
      {required this.card,
      // required this.onTap,
      this.isMain = false,
      this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8)})
      : color = isMain ? AppStyles.secondaryColor : Colors.white,
        shadowColor = isMain
            ? AppStyles.secondaryColor.withOpacity(0.2)
            : AppStyles.mainColor.withOpacity(0.1),
        textColor = isMain ? Colors.white : AppStyles.mainColorDark {
    cardName = card.params.findByAlias(AliasList.productName)?.evalue ?? '';
    cardNumber = StringMask('0000 0000 0000 0000')
        .apply(card.params.findByAlias(AliasList.number)?.evalue);

    cardExpirationDate = StringMask('90/90')
        .apply(card.params.findByAlias(AliasList.expirationDate)?.evalue);

    issuer = CardIssuerTypeExtenson.fromCardNumber(cardNumber);

    issuerLogo = issuer.logo(isMain: isMain);
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: shadowColor,
                  blurRadius: 20,
                  offset: const Offset(0, 4))
            ]),
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              const Image(
                image: AssetImage('assets/images/123_card.png'),
                height: 50,
                width: 70,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardName,
                      style: TextStyle(fontSize: 16, color: textColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          cardNumber,
                          style: TextStyle(fontSize: 16, color: textColor),
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
                          style: TextStyle(fontSize: 16, color: textColor),
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
