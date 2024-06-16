// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class CurrentCardItem extends StatefulWidget {
  final CardPayment? cardPayment;
  final DataManager dataManager;

  const CurrentCardItem({
    required this.dataManager,
    this.cardPayment,
    Key? key,
  }) : super(key: key);

  @override
  State<CurrentCardItem> createState() => _CurrentCardItemState();
}

class _CurrentCardItemState extends State<CurrentCardItem> {
  late MdomResponseParams currentCardParams;
  late List<MdomResponseParam> paramsInputed;
  MdomResponseParam? cardNameParam;
  MdomResponseParam? cardPanMaskParam;
  MdomResponseParam? cardIdParam;
  MdomResponseParam? cardContractKindParam;

  @override
  void initState() {
    currentCardParams = widget.dataManager.cardParams;
    paramsInputed = currentCardParams.params.map((e) => e.copyWith()).toList();
    cardNameParam = paramsInputed.firstOrNullWhere((param) => currentCardParams.findByAlias(AliasList.productName)?.id == param.id);
    cardPanMaskParam = paramsInputed.firstOrNullWhere((param) => currentCardParams.findByAlias(AliasList.number)?.id == param.id);
    cardIdParam = paramsInputed.firstOrNullWhere((param) => currentCardParams.findByAlias(AliasList.cardId)?.id == param.id);
    cardContractKindParam = paramsInputed.firstOrNullWhere((param) => currentCardParams.findByAlias(AliasList.contractKind)?.id == param.id);    
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Card(
    elevation: 2,
    margin: const EdgeInsets.all(16),
    shadowColor: const Color(0xffEAEEF6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.cardPayment?.cardName ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w600, 
              fontSize: 16
            ),
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
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.cardPayment?.panMask.substring(8) ?? '',
                      style: AppStyles.inputLabelStyle),
                  const SizedBox(height: 48),
                  SizedBox(
                    height: 34,
                    child: MaterialButton(
                      onPressed: _onProductSelected,
                      color: const Color(0xffEAEEF6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Выбрать',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppStyles.mainColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );

  void _onProductSelected() {

   cardNameParam?.evalue = widget.cardPayment?.cardName ?? '';
   cardPanMaskParam?.evalue = widget.cardPayment?.panMask;
   cardIdParam?.evalue = widget.cardPayment?.cardId.toString();
   cardContractKindParam?.evalue = widget.cardPayment?.contractKind.toString();
   final returnData = <MdomResponseParam>[...paramsInputed]; 

    context.read<ProductsBloc>()
    .add(ProductsAdd(tab: ProductsTab.cards, params: returnData));
  }
}
