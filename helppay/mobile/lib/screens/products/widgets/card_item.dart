import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helppay/screens/products/widgets/widgets.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/widgets/loading_indicator.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:string_mask/string_mask.dart';

// ignore: must_be_immutable
class CardItem extends StatelessWidget {
  final MdomLoginResponseProductsCurrent card;
  final Function(MdomLoginResponseProductsCurrent card) onTap;
  final bool isMain;
  final EdgeInsetsGeometry margin;

  late String cardName;
  late String cardNumber;
  late String cardExpirationDate;
  late CardIssuerType issuer;
  late bool is123Card;
  late String pictureUrl;

  final Color color;
  final Color shadowColor;
  final Color textColor;
  late String issuerLogo;
  late String? cardId;

  CardItem({
    required this.card,
    required this.onTap,
    this.isMain = false,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  })  : color = isMain ? AppStyles.secondaryColor : Colors.white,
        shadowColor = isMain
            ? AppStyles.secondaryColor.withOpacity(0.2)
            : AppStyles.mainColor.withOpacity(0.1),
        textColor = isMain ? Colors.white : AppStyles.mainColorDark {
    cardName = card.params.findByAlias(AliasList.productName)?.evalue ?? '';
    is123Card = card.params.findByAlias(AliasList.bankId)?.evalue == '765';
    pictureUrl =
        'http://192.168.244.126:8085/helppay_payform/imgs/${card.params.findByAlias(AliasList.pictureUrl)?.evalue}';

    if (card.params.findByAlias(AliasList.number)?.evalue?[0] != '*') {
      cardNumber = StringMask('0000 0000 0000 0000')
          .apply(card.params.findByAlias(AliasList.number)?.evalue);
    } else {
      cardNumber = StringMask('**** **** **** 0000').apply(
          card.params.findByAlias(AliasList.number)?.evalue?.substring(12));
    }

    cardExpirationDate = StringMask('90/90')
        .apply(card.params.findByAlias(AliasList.expirationDate)?.evalue);

    issuer = CardIssuerTypeExtenson.fromCardNumber(cardNumber);
    cardId = card.params.findByAlias(AliasList.cardId)?.evalue;
    issuerLogo = issuer.logo(isMain: isMain);
  }

  @override
  Widget build(BuildContext context) => is123Card
      ? Container(
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
            onTap: () => onTap(card),
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 18,
                  child: Image.network(
                    pictureUrl,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppStyles.mainColor,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
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
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (context.read<ProductsBloc>().state.balanceRequested ??
                    false)
                  const RepaintBoundary(
                    child: LoadingIndicator(),
                  )
                else
                  CheckBalanceButton(
                    cardId: cardId ?? '0',
                  ),
              ],
            ),
          ),
        )
      : Container(
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
            onTap: () => onTap(card),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: Text(
                              cardName,
                              style: TextStyle(fontSize: 16, color: textColor),
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
                                fontWeight: FontWeight.w400,
                                color: Color(0xff9B9CA8)),
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
                          if (context
                                  .read<ProductsBloc>()
                                  .state
                                  .balanceRequested ??
                              false)
                            const RepaintBoundary(
                              child: LoadingIndicator(),
                            )
                          else
                            CheckBalanceButton(
                              cardId: cardId ?? '0',
                            )
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
