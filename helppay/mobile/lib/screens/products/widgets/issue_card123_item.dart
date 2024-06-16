import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

class IssueCard123Item extends StatefulWidget {
  final DataManager dataManager;
  const IssueCard123Item({
    required this.dataManager,
    Key? key,
  }) : super(key: key);

  @override
  State<IssueCard123Item> createState() => _IssueCard123ItemState();
}

class _IssueCard123ItemState extends State<IssueCard123Item> {
  late MdomResponseParams currentCardParams;
  late List<MdomResponseParam> paramsInputed;
  MdomResponseParam? cardIdParam;
  MdomResponseParam? cardNameParam;
  MdomResponseParam? cardPanMaskParam;
  int? cardId;
  String? cardPan;

  @override
  void initState() {
    currentCardParams = widget.dataManager.cardParams;
    paramsInputed = currentCardParams.params.map((e) => e.copyWith()).toList();
    cardNameParam = paramsInputed.firstOrNullWhere((param) =>
        currentCardParams.findByAlias(AliasList.productName)?.id == param.id);
    cardPanMaskParam = paramsInputed.firstOrNullWhere((param) =>
        currentCardParams.findByAlias(AliasList.number)?.id == param.id);
    cardIdParam = paramsInputed.firstOrNullWhere((param) =>
        currentCardParams.findByAlias(AliasList.cardId)?.id == param.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
    BlocListener<CardsIssueBloc, CardsIssueState>(
      listener: (context, state) {
        if (state is CardsIssue123ConfirmResponse) {
            cardId = state.cardId ?? 0;
            cardPan = state.cardPan;
          if (cardId != null) {
              cardIdParam?.evalue = cardId.toString();
              cardPanMaskParam?.evalue = cardPan;
              cardNameParam?.evalue = context
                  .t.mobileScreens.cardRegistration.params.difitalCard;
              final returnData = <MdomResponseParam>[...paramsInputed];
              context.read<ProductsBloc>().add(
                  ProductsAdd(tab: ProductsTab.cards, params: returnData));
          }
        }
      },
      child: BlocBuilder<CardsIssueBloc, CardsIssueState>(
        builder: (context, state) {
          Widget body = Container();
          if(state is CardsIssueLoading) {
            body = const Padding(
              padding: EdgeInsets.symmetric(vertical: 80),
              child: LoadingIndicator(),
            );
          } else {
            body = Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffEAEEF6).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          context.t.mobileScreens.cardRegistration.params.difitalCard,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.network(
                          '${widget.dataManager.cardPictureUrl}',
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width / 2.5,
                          opacity: const AlwaysStoppedAnimation(.5),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppStyles.mainColor,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 38,
                          child: MaterialButton(
                            onPressed: _onProductSelected,
                            color: AppStyles.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                context.t.mobileScreens.cardRegistration.releaseButton,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return body;
        },
      ),
    );

  void _onProductSelected() {
    context.read<CardsIssueBloc>().add(CardsIssue123ConfirmRun());
  }
}
