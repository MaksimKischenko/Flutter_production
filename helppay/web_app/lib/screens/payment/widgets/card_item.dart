import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:string_mask/string_mask.dart';

// ignore: must_be_immutable
class CardItem extends StatelessWidget {
  final MdomLoginResponseProductsCurrent item;

  late String cardName;
  late String cardNumber;
  late String cardExpirationDate;
  late CardIssuerType issuer;

  late String issuerLogo;

  CardItem(this.item) {
    cardName = item.params.findByAlias(AliasList.productName)?.evalue ?? '';
    cardNumber = StringMask('0000 0000 0000 0000').apply(
      item.params.findByAlias(AliasList.number)?.evalue,
    );

    cardExpirationDate = StringMask('90/90').apply(
      item.params.findByAlias(AliasList.expirationDate)?.evalue,
    );

    switch (cardNumber[0]) {
      case '4':
        issuer = CardIssuerType.visa;
        break;
      case '5':
        issuer = CardIssuerType.mastercard;
        break;
      case '6':
        issuer = CardIssuerType.maestro;
        break;
      case '3':
        issuer = CardIssuerType.americanExpress;
        break;
      default:
        issuer = CardIssuerType.undefined;
    }

    switch (issuer) {
      case CardIssuerType.visa:
        issuerLogo = 'card_visa';
        break;
      case CardIssuerType.mastercard:
        issuerLogo = 'card_mastercard';
        break;
      case CardIssuerType.maestro:
        issuerLogo = 'card_maestro';
        break;
      case CardIssuerType.americanExpress:
        issuerLogo = 'card_american_express';
        break;
      default:
        issuerLogo = 'card_american_express';
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.fromLTRB(4, 24, 4, 24),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          color: AppStyles.secondaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppStyles.secondaryColor.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Text(
                          cardName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        cardNumber,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            'assets/icon/$issuerLogo.svg',
                            width: 18,
                          ),
                        ),
                      ),
                      Text(
                        cardExpirationDate,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
