

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/injection_component.dart';
import 'package:helppay/screens/card_creation_screen/widgets/widgets.dart';
import 'package:helppay/screens/products/widgets/widgets.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay_core/helppay_core.dart';

// ignore: must_be_immutable
class BnbCardAddScreen extends StatelessWidget {
  final Function(int) navigationFunc;
  final DataManager dataManager;
  final List<CardPayment>? cards;

  BnbCardAddScreen({required this.navigationFunc, required this.cards, Key? key})
      : dataManager = InjectionComponent.getDependency<DataManager>(),
        super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocListener(
      listeners: [
        BlocListener<ProductsBloc, ProductsState>(
          listener: (context, state) {
            if (state is ProductsSuccessAdd) {
              navigationFunc(4);
            } 
          },
        ),
        BlocListener<CardsIssueBloc, CardsIssueState>(
          listener: (context, state) {
            if(state is CardsIssueErrorKomplat) {
              kReleaseMode?
              Multiplatform.showMessage(
                context: context, 
                title: context.t.mobileScreens.cardRegistration.params.errorsInfoMessaes.errorTitle,
                message: context.t.mobileScreens.cardRegistration.params.errorsInfoMessaes.errorMessage,
                type: DialogType.error
              ):    
              RequestUtil.catchKomplatError(
                context: context, 
                errorCode: state.errorCode, 
                errorText: state.errorMessage
              );             
            }            
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            CardDesignHeader(
              dataManager: dataManager,
              headerText: context.t.mobileScreens.cardRegistration.params.title,
            ),
            const SizedBox(height: 24),
            const ProgressIndicatorBar(
              currentPage: 3,
            ),
            const SizedBox(height: 24),
            Text(
              context
                  .t.mobileScreens.cardRegistration.params.currentCardsTitle,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppStyles.cardDesignTextColor),
            ),
            SizedBox(
              height: cards == null? 0 : MediaQuery.of(context).size.height / 4.5,
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: cards?.length,
                itemBuilder: (context, index) => CurrentCardItem(
                  cardPayment: cards?[index],
                  dataManager: dataManager
                )
              ),
            ),
            IssueCard123Item(
              dataManager: dataManager,
            ) 
          ],
        ),
      ),
    );
}
