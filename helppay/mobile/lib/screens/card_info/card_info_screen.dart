import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart' as widgets;
import 'package:helppay_core/helppay_core.dart';
import 'package:string_mask/string_mask.dart';

import 'widgets/widgets.dart';

class CardInfoScreen extends StatefulWidget {
  final MdomLoginResponseProductsCurrent card;

  const CardInfoScreen({required this.card});

  @override
  State<CardInfoScreen> createState() => _CardInfoScreenState();
}

class _CardInfoScreenState extends State<CardInfoScreen> {
  final GlobalKey<NavigatorState> nestedNavigatorKey =
      GlobalKey<NavigatorState>();

  final _info = <String, String>{};

  late MdomResponseParam nameParam;
  late MdomResponseParam numberParam;
  late MdomResponseParam? cardId;
  late String cardExpirationDate;
  late bool defaultFlag;

  @override
  void initState() {
    super.initState();

    nameParam = widget.card.params.findByAlias(AliasList.productName)!;
    numberParam = widget.card.params.findByAlias(AliasList.number)!;
    cardId = widget.card.params.findByAlias(AliasList.cardId);

    defaultFlag =
        (widget.card.params.findByAlias(AliasList.defaultFlag)?.evalue ??
                '0') ==
            '1';
    cardExpirationDate = StringMask('90/90').apply(
        widget.card.params.findByAlias(AliasList.expirationDate)?.evalue);

    _info[t.mobileScreens.cardInfo.properties.number] =
        numberParam.evalue?[0] != '*'
            ? StringMask('0000 0000 0000 0000').apply(numberParam.evalue)
            : StringMask('**** **** **** 0000')
                .apply(numberParam.evalue?.substring(12));

    _info[t.mobileScreens.cardInfo.properties.expirationDate] =
        cardExpirationDate;
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is ProductsSuccessMakeMain) {
            defaultFlag = !defaultFlag;
          }
          if (state is ProductsSuccessDelete) {
            Navigator.of(context).pop();
            Multiplatform.showMessage(
                context: context,
                title: context
                    .t.mobileScreens.cardInfo.modal.succesProductDelete.title,
                message: context
                    .t.mobileScreens.cardInfo.modal.succesProductDelete.message,
                type: DialogType.success);
          }
        },
        child: Navigator(
          key: nestedNavigatorKey,
          onGenerateRoute: (_) => MaterialPageRoute<void>(
              builder: (context) => Builder(
                    builder: (context) => CupertinoPageScaffold(
                      child: SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppStyles.secondaryColor,
                                  // borderRadius: BorderRadius.circular(10),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                      bottomLeft: Radius.circular(12)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppStyles.secondaryColor
                                            .withOpacity(0.2),
                                        blurRadius: 25,
                                        offset: const Offset(0, 4))
                                  ]),
                              padding: const EdgeInsets.fromLTRB(4, 12, 4, 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ArrowBack(),
                                  const SizedBox(height: 24),
                                  Name(
                                    pan: numberParam.evalue ?? '',
                                    nameParam: nameParam,
                                    onEditPressed: _onEditNamePressed,
                                  ),
                                  const SizedBox(height: 74),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                padding: const EdgeInsets.only(top: 16),
                                separatorBuilder: (context, index) => Divider(
                                    color: AppStyles.mainColorDark
                                        .withOpacity(0.1)),
                                itemCount: _info.length,
                                itemBuilder: (context, index) =>
                                    InfoItem(_info.entries.toList()[index]),
                              ),
                            ),
                            BlocBuilder<ProductsBloc, ProductsState>(
                              builder: (context, state) {
                                Widget body = Container();
                                if (state is ProductsInitial) {
                                  body = Column(
                                    children: [
                                      if (!defaultFlag)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 28, vertical: 8),
                                          child: CardInfoActionButton(
                                            onPressed: _onMakeMainPressed,
                                            title: context.t.mobileScreens
                                                .cardInfo.makeMainButton,
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            28, 0, 28, 0),
                                        child: DeleteButton(
                                          onPressed: _onDeletePressed,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                if (state is ProductsLoading) {
                                  body = const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 44),
                                    child: widgets.LoadingIndicator(),
                                  );
                                }
                                return body;
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      );

  void _onMakeMainPressed() {
    context.read<ProductsBloc>().add(ProductsMakeMain(product: widget.card));
  }

  void _onDeletePressed() {
    Multiplatform.showDecisionMessage(
        context: context,
        dialogTitle: t.mobileScreens.cardInfo.modal.deleteProduct.title,
        message: t.mobileScreens.cardInfo.modal.deleteProduct.message,
        cancelButtonTitle:
            t.mobileScreens.cardInfo.modal.deleteProduct.cancelButton,
        buttonTitle: t.mobileScreens.cardInfo.modal.deleteProduct.deleteButton,
        action: () {
          context
              .read<ProductsBloc>()
              .add(ProductsDelete(product: widget.card));
        });
  }

  void _onEditNamePressed() {
    nestedNavigatorKey.currentState?.push<void>(MaterialPageRoute(
      builder: (context) => EditName(
        pan: numberParam.evalue ?? '',
        nameParam: nameParam,
      ),
    ));
  }
}
